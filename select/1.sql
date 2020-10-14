select * from band;

select band_id, name, upper(name) as u_name from band;

select band_id, name from band where band_id = 93;

select * from band limit 5;

select band_id, name from band where band_id = 93 or band_id = 12;

-- не пустой комментарий в колонке comment
select * from band where year < 1980 and comment <>'';

select * from band where name = 'Led Zeppelin';

select * from album where band_id = 388;

