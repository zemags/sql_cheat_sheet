select * from band
where name like '%magic%'
order by name;

select * from band
where lower(name) like '%magic%'
order by name;

select name, substring(name,1,1) as first_letter from person
where substring(name,1,1) between 'A' and 'Z';

select count(*) from (
	select name, substring(name,1,1) as first_letter from person
	where substring(name,1,1) between 'A' and 'Z'
) as table_1; --155811

select first_letter, count(first_letter) from (
	select name, substring(name,1,1) as first_letter from person
	where substring(name,1,1) between 'A' and 'Z'
) as table_1
group by first_letter
order by count(first_letter) desc;

select name, substring(name,1,1) as first_letter from person
where substring(name,1,1) between 'A' and 'Z' and name like '% %';

select name, first_letter, position(' ' in name), substring(name, 1, position(' ' in name)-1) as name from (
	select name, substring(name,1,1) as first_letter from person
	where substring(name,1,1) between 'A' and 'Z' and name like '% %'
) as table_1;

select count(substring(name, 1, position(' ' in name)-1)), substring(name, 1, position(' ' in name)-1) as name from (
	select name, substring(name,1,1) as first_letter from person
	where substring(name,1,1) between 'A' and 'Z' and name like '% %'
) as table_1
group by substring(name, 1, position(' ' in name)-1)
order by count(substring(name, 1, position(' ' in name)-1)) desc;