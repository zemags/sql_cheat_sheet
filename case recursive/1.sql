select a.album_id, a.name as album_name, b.band_id, b.name as band_name,
(case
	when a.name = b.name then 1
	else 0
end) as e
from album as a
inner join band as b
on a.band_id = b.band_id;

select
sum(case
	when a.name = b.name then 1
	else 0
end) as album_sum
from album as a
inner join band as b
on a.band_id = b.band_id; --6615

select * from album limit 2;
select * from band limit 2;

select count(*) from album
where name in (select name from band); --15277

select count(*), sum(band_found_flag), sum(names_found_flag)
from (
	select 
		a.*,
		case when b.name is not null then 1 else 0 end as band_found_flag,
		case when a.name = b2.name then 1 else 0 end as names_found_flag
	from album as a
	inner join band as b2
		on b2.band_id = a.band_id
	left outer join(
		select distinct name from band
	) as b
		on a.name = b.name
) as table_1;


-- recursive

with recursive recursive_table as (
	select level_1.parent_id, cast(null as character varying) as parent_name,
			coalesce(level_1.name, '') as chained_name,
			level_1.id, level_1.name, 1 as depth
		from music_instrument as level_1
		where level_1.id = 1
	union all
	select recursive_alias.id as parent_id, recursive_alias.name as parent_name,
	recursive_alias.chained_name || ' -> ' || coalesce(level_next.name, '') as chained_name,
	level_next.id, level_next.name, recursive_alias.depth + 1 as depth
		from recursive_table as recursive_alias
	left join music_instrument as level_next
	on level_next.parent_id = recursive_alias.id
		where depth <= 100
		and level_next.id is not null
) select * from recursive_table order by depth, parent_name, name