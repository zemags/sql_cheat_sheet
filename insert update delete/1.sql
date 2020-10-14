--create table band_extended_backup as select * from band_extended; --как делать бэкап

select count(*) from band_extended_backup;

select sum(n_albums) from band_extended; --121918

select count(*) from album;

update band_extended
set n_albums = NULL
where n_albums = 11 and
name = 'Metallica';

select * from band_extended
where name = 'Metallica';

insert into band_extended (
	band_id, name, year, comment, n_albums, n_songs
) values (
	-100, 'My Test Music Group', 2000, 'My Comment', 25, 54
);

select * from band_extended
where band_id = -100;

delete from band_extended
where band_id = -100;

delete from band_extended
where name = 'Queen';

select * from band_extended
where
 1 = 1
 and name = 'Queen';