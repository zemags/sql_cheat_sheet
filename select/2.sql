-- сравнение.
select * from band where band_id in (303, 93, 192);

-- обратная операция
select * from band where band_id <> 2 and band_id <> 3;
select * from band where band_id not in (2, 3);

-- подзапрос
select * from band where band_id in (select id from list1);
select * from (
	select * from band where year >= 1980
) as p where p.band_id between 10 and 20;

-- между границами диапазона
select * from band where year between 1970 and 1980;

select * from album where band_id in (select band_id from band where name = 'Led Zeppelin');
