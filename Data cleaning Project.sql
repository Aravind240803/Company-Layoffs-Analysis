select * 
from layoffs;

# Create a sample copied version of original data
create table layoffs_staging
like layoffs;

select * 
from layoffs_staging;

insert into layoffs_staging 
select * from layoffs;

# Removing Duplicates
with duplicate_cte as
(
select *,
row_number() over
(partition by company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) row_num
from layoffs_staging
)
Delete from duplicate_cte 
where row_num > 1;

# The above one actually won't work in MySQL so we can do it by creating new table
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` bigint DEFAULT NULL,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from layoffs_staging2;

insert into layoffs_staging2
select *,
row_number() over
(partition by company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions) row_num
from layoffs_staging;

Delete from layoffs_staging2
where row_num > 1;

Select * from layoffs_staging2
where row_num > 1;

# Standardizing the data (Checking each columns)
select * from layoffs_staging2;

select company, trim(company) from layoffs_staging2;

update layoffs_staging2
set company = trim(company);

select distinct industry from layoffs_staging2
order by 1;

select * from layoffs_staging2 where industry like 'Crypto%';

update layoffs_staging2 
set industry = 'Crypto'
where industry like 'Crypto%';

select * from layoffs_staging2;

select distinct location from layoffs_staging2
order by 1;
select distinct country from layoffs_staging2
order by 1;

select distinct country, trim(trailing '.' from country) from layoffs_staging2
order by 1;

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United States%';

select `date`,
str_to_date(`date`, '%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y');

select * from layoffs_staging2;

alter table layoffs_staging2
modify column `date` date;

# Working with null and blank values
select * from layoffs_staging2;

select * from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select distinct industry from layoffs_staging2;
select * from layoffs_staging2
where industry is null 
or industry = '';

select * from layoffs_staging2
where company = 'Airbnb';

update layoffs_staging2 
set industry = null
where industry = '';

select t1.industry, t2.industry from layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

update layoffs_staging2 t1
join layoffs_staging2 t2 
on t1.company = t2.company
set t1.industry = t2.industry
where (t1.industry = '' or t1.industry is null)
and t2.industry is not null;

select * from layoffs_staging2
where industry is null;

# Removing the unnecessary rows or columns

select * from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

delete from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select * from layoffs_staging2;

select * from layoffs_staging2
where percentage_laid_off = 0
and total_laid_off is null;

delete from layoffs_staging2
where percentage_laid_off = 0
and total_laid_off is null;

# Delete the row_num column which was created in the beginning for our reference
alter table layoffs_staging2
drop column row_num;
