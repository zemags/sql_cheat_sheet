select * from band where name = 'Led Zeppelin';

select * from band as b
inner join album as a
on b.band_id = a.band_id
where b.name = 'Led Zeppelin';

select a.* from album as a
where a.band_id = 388
order by a.year asc;

select a.year, count(a.year) from album as a
where a.band_id = 388
group by a.year
order by a.year asc;

select c.year from calendar_year as c
where year between 1969 and 1982
order by year asc;

select * from calendar_year as c
left join album as a
on c.year = a.year and
a.band_id = 388
where c.year between 1969 and 1982
order by c.year;

select c.year, count(a.album_id) from calendar_year as c
left join album as a
on c.year = a.year and
a.band_id = 388
where c.year between 1969 and 1982
group by c.year
order by c.year;

select c_year, count(*), count(album_id)
from (
	select c.year as c_year, a.album_id, a.name, a.band_id, a.year as a_year from calendar_year as c
	left join album as a
	on c.year = a.year and
	a.band_id = 388
	where c.year between 1969 and 1982
) as table_1
group by c_year
order by c_year;

select * from music_instrument m
where id = 1;

select a.id, a.name, b.id as child_id, b.name as child_name 
from music_instrument a
left join music_instrument b
on a.id = b.parent_id
where a.id = 1;

select a.id, a.name, b.id as child_id, b.name as child_name, c.id as grand_child_id, c.name as grand_child_name,
d.id as level_4_parent_id, d.name as level_name_parent
from music_instrument a
left join music_instrument b
on a.id = b.parent_id
left join music_instrument c
on b.id = c.parent_id
left join music_instrument d
on c.id = d.parent_id
where a.id = 1
order by name, child_name, grand_child_name;
