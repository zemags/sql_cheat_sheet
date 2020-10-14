-- поиск расхождений между таблицами
select count(*) from album; -- 121918
select sum(n_albums) from band_extended; --121918

--данные могут не совпадать по отдельным муз группам
select count(*) from album where band_id = -100; --0
select sum(n_albums) from band_extended where band_id = -100; --25

--поиск расхождений
select band_id, count(*) as album_count from album
group by 1;

select band_id, n_albums as album_count
from band_extended
where n_albums > 0;

-- вычтем из одной таблицы другую
select band_id, count(*) as album_count from album
group by 1
except
select band_id, n_albums as album_count
from band_extended
where n_albums > 0; --93, 192

-- и наоборот
select band_id, n_albums as album_count
from band_extended
where n_albums > 0
except
select band_id, count(*) as album_count from album
group by 1; --100

--поиск расхождений
select * from (
	select band_id, n_albums as album_count
	from band_extended
	where n_albums > 0or n_albums is null
) as table_1
full outer join
(
	select band_id, count(*) as album_count from album
	group by 1
) as table_2
on table_1.band_id = table_2.band_id
where table_1.album_count <> table_2.album_count
or (table_1.album_count is null and table_2.album_count is not null)
or (table_1.album_count is not null and table_2.album_count is null);


-- устранение расхождений
create table table_comparison as 
select 
	table_1.band_id as band_id_band_extended,
	table_1.album_count as album_count_band_extended,
	table_2.band_id as band_id_album,
	table_2.album_count as album_count_balbum
from (
		select band_id, n_albums as album_count
		from band_extended
		where n_albums > 0or n_albums is null
	) as table_1
	full outer join
	(
		select band_id, count(*) as album_count from album
		group by 1
	) as table_2
	on table_1.band_id = table_2.band_id
	where table_1.album_count <> table_2.album_count
	or (table_1.album_count is null and table_2.album_count is not null)
	or (table_1.album_count is not null and table_2.album_count is null);
	
	
select * from table_comparison;

--band_id=93; update
update band_extended as band_alias
set n_albums = table_1.album_count
from (select band_id, count(*) as album_count from album group by 1) as table_1
where band_alias.band_id = table_1.band_id
and band_alias.band_id in ( -- только для строк где расхождения
	select band_id_band_extended from table_comparison
	where band_id_band_extended is not null
	and band_id_album is not null
);

--band_id=-100; delete
delete from band_extended
where band_id in (
	select band_id_band_extended from table_comparison
	where band_id_band_extended is not null
		and band_id_album is null
);

--band_id=192; insert
insert into band_extended(band_id, name, year, comment, n_albums, n_songs)
select b.band_id, b.name, b.year, b.comment, 
coalesce(albums.album_count,0) as n_albums,
/*coalesce(songs.album_count,0)*/ null as n_songs from band as b -- таблицы song нет
left outer join (select band_id, count(*) as album_count from album group by 1) as albums
on albums.band_id = b.band_id
/*left outer join (select band_id, count(*) as song_count from song group by 1) as songs
on songs.band_id = b.band_id*/
where b.band_id in (
	select band_id_album from table_comparison
	where band_id_band_extended is null
		and band_id_album is not null
);

