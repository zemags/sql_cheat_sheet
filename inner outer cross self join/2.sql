select * from album where name = 'Now';

select * from album where name = 'The Collection';

select a.band_id from album as a
where a.name = 'Now'
intersect
select b.band_id from album as b
where b.name = 'The Collection';

select name from band where band_id in (5196, 15916);