select name, count(*) from band group by name;

select name, count(*) from band group by name having count(*)>=2;

select name, count(*) from band group by name having count(*)>=2 order by count(*) desc;

select band_id, count(*) from album group by band_id;

select band_id, count(*) from album group by band_id order by 2 desc; -- 562672

select * from band where band_id = 562672;

select * from band where band_id in (
	select band_id from album group by band_id order by count(album) desc limit 1
);

select * from band 
	where band_id in (
		select band_id from album group by 1 
		having count(*) = (select max(counter) from
			(select band_id, count(*) as counter from album group by 1) as table_1
		)
	);