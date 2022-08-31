-- DROP
if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'u_dinning_halls_hall_name')
    alter table dinning_halls drop constraint u_dinning_halls_hall_name

if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'u_student_year_student_year_name')
    alter table student_year drop constraint u_student_year_student_year_name

if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'fk_student_student_year_id')
    alter table students drop constraint fk_student_student_year_id

if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'fk_students_dinning_halls_student_hall_id')
    alter table students drop constraint fk_students_dinning_halls_student_hall_id

if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'u_waste_waste_name')
    alter table waste drop constraint u_waste_waste_name

if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'fk_inventory_waste_inventory_waste_id')
    alter table inventory drop constraint fk_inventory_waste_inventory_waste_id

if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'fk_inventory_dinning_halls_inventory_hall_id')
    alter table inventory drop constraint fk_inventory_dinning_halls_inventory_hall_id

if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'u_inventory_name_inventory_hall_id')
    alter table inventory drop constraint u_inventory_name_inventory_hall_id

if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'fk_waste_report_dinning_halls_hall_id')
    alter table waste_report drop constraint fk_waste_report_dinning_halls_hall_id 

if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'u_hall_id_generation_date')
    alter table waste_report drop constraint u_hall_id_generation_date   

if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'fk_food_dinning_halls_food_hall_id')
    alter table food drop constraint fk_food_dinning_halls_food_hall_id 

if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'fk_food_waste_food_waste_id')
    alter table food drop constraint fk_food_waste_food_waste_id   

if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'u_food_name_food_hall_id')
    alter table food drop constraint u_food_name_food_hall_id   

if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'fk_cost_report_dinning_halls_report_hall_id')
    alter table cost_report drop constraint fk_cost_report_dinning_halls_report_hall_id       

if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'fk_food_waste_report_hall_id')
    alter table food_waste_report drop constraint fk_food_waste_report_hall_id

if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'fk_food_waste_report_waste_id')
    alter table food_waste_report drop constraint fk_food_waste_report_waste_id       

if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'fk_inventory_waste_report_hall_id')
    alter table inventory_waste_report drop constraint fk_inventory_waste_report_hall_id  

if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'fk_inventory_waste_report_waste_id')
    alter table inventory_waste_report drop constraint fk_inventory_waste_report_waste_id

if exists(select * from INFORMATION_SCHEMA.TABLE_CONSTRAINTS where CONSTRAINT_NAME = 'u_waste_waste_name')
    alter table waste drop constraint u_waste_waste_name
 

GO
drop view if exists v_food_waste_report
drop view if exists v_inventory_waste_report
drop table if exists dinning_halls
drop table if exists student_year
drop table if exists students
drop table if exists inventory
drop table if exists waste
drop table if exists waste_report
drop table if exists food
drop table if exists cost_report
drop table if exists food_waste_report
drop table if exists inventory_waste_report



GO

-- CREATE
Create Table dinning_halls(
    hall_id Int IDENTITY(1,1),
    hall_name varchar(100) not Null,
    hall_capacity int not NULL
    Constraint "pk_dinning_halls_hall_name" primary key(hall_id)
)

Alter TABLE dinning_halls 
ADD Constraint "u_dinning_halls_hall_name" UNIQUE (hall_name)

Create TABLE student_year(
    student_year_id int not Null,
    student_year_name varchar(100) not Null,
    Constraint "pk_student_year_student_year_id" primary key (student_year_id)
)
Alter Table student_year
Add Constraint "u_student_year_student_year_name" unique (student_year_name)

 
Create Table students(
    student_id int IDENTITY(1,1),
    student_firstname varchar(100) not NULL,
    student_lastname varchar(100) not Null,
    student_year_id int not null,
    student_hall_id int not NULL,
    Constraint "pk_student_id" primary key(student_id)
)

Alter table students 
add constraint "fk_student_student_year_id" foreign key (student_year_id) REFERENCES student_year

Alter Table students
add Constraint "fk_students_dinning_halls_student_hall_id" foreign key (student_hall_id) REFERENCES dinning_halls

Create table waste(
    waste_id int not null,
    waste_name varchar(100) not null,
    Constraint "pk_waste_id" primary key (waste_id)
)
ALTER TABLE waste
Add Constraint "u_waste_waste_name" UNIQUE (waste_name)

Create Table inventory(
    inventory_id bigint Identity(1,1),
    inventory_name varchar(100) not null,
    inventory_quantity bigint not null,
    inventory_quantity_unit varchar(100) not Null,
    inventory_cost_per_unit money not null,
    inventory_hall_id bigint not null,
    inventory_waste_id bigint not NULL,
    Constraint "pk_inventory_id" primary key(inventory_id)
)
Alter table inventory 
add constraint "fk_inventory_dinning_halls_inventory_hall_id" foreign key(inventory_hall_id) references dinning_halls

Alter Table inventory 
add constraint "fk_inventory_waste_inventory_waste_id" foreign key (inventory_waste_id) references waste

Alter TABLE inventory
add constraint "u_inventory_name_inventory_hall_id" Unique(inventory_name, inventory_hall_id)

Create table waste_report(
    report_id int IDENTITY(1,1),
    report_hall_id int not Null, 
    report_food_wasted int not Null,
    report_inventory_wasted int not Null,
    report_student_count int not Null,
    report_generation_date DATE not Null,
    CONSTRAINT "pk_waste_report_id" primary key(report_id)
)

Alter Table waste_report 
    add constraint "fk_waste_report_dinning_halls_hall_id" foreign key (report_hall_id) references dinning_halls

Alter Table waste_report
add constraint "u_hall_id_generation_date" unique(report_hall_id,report_generation_date)

Alter Table waste_report
add  report_id bigint IDENTITY(1,1)

Alter Table waste_report
add constraint "pk_waste_report_id" primary key(report_id)

Create Table food(
    food_id int IDENTITY(1,1),
    food_name varchar(100) not NULL,
    food_quantity int not Null,
    food_quantity_unit varchar(100) not Null,
    food_cost_per_unit money not NULL,
    food_hall_id int not NULL,
    food_waste_id int not Null,
    Constraint "pk_food_id" PRIMARY KEY(food_id)
)
Alter Table food
    add CONSTRAINT "fk_food_dinning_halls_food_hall_id" foreign key(food_hall_id) references dinning_halls

Alter Table food 
    add CONSTRAINT "fk_food_waste_food_waste_id" foreign key(food_waste_id) references waste

Alter Table food
    add CONSTRAINT "u_food_name_food_hall_id" Unique (food_name,food_hall_id) 

Create Table cost_report(
    report_id int IDENTITY(1,1),
    report_generation_date DATE not Null,
    report_hall_id int not Null,
    report_hall_student_count int not NULL,
    report_cost_incurred money not Null,
    report_cp_ratio float not Null,
    Constraint "pk_cost_report_id" primary Key(report_id)
)
ALTER Table cost_report
    add CONSTRAINT "fk_cost_report_dinning_halls_report_hall_id" foreign key(report_hall_id) REFERENCES dinning_halls

Create Table food_waste_report(
    food_waste_report_id bigint Identity(1,1),
    food_waste_report_food_id bigint not Null,
    food_waste_report_quantity bigint not Null,
    food_waste_report_cost float not null,
    food_waste_report_hall_id bigint not Null,
    food_waste_report_waste_id bigint not Null,
    food_waste_report_date DATETIME not Null
    Constraint "pk_food_waste_id" primary key(food_waste_report_id)
)
Alter table food_waste_report 
Add CONSTRAINT "fk_food_waste_report_hall_id" Foreign Key(food_waste_report_hall_id) references dinning_halls

Alter table food_waste_report
add Constraint "fk_food_waste_report_waste_id" Foreign Key(food_waste_report_waste_id) references waste

Create Table inventory_waste_report(
    inventory_waste_report_id bigint IDENTITY(1,1),
    inventory_waste_report_inventory_id bigint not Null,
    inventory_waste_report_hall_id bigint not Null,
    inventory_waste_report_waste_id bigint not Null,
    inventory_report_inventory_cost float not Null,
    inventory_waste_report_date DATE not Null,
    inventory_waste_report_quantity bigint not Null,
    Constraint "pk_inventory_waste_report" Primary Key (inventory_waste_report_id)
)
Alter Table inventory_waste_report
Add Constraint "fk_inventory_waste_report_hall_id" foreign key (inventory_waste_report_hall_id) references dinning_halls

Alter Table inventory_waste_report
Add Constraint "fk_inventory_waste_report_waste_id" foreign key(inventory_waste_report_waste_id) REFERENCES waste


GO
Drop view if exists v_food_waste_report
GO
Create view v_food_waste_report with SCHEMABINDING AS
    select food_waste_report_hall_id,sum(food_waste_report_cost) as food_waste_report_cost,food_waste_report_waste_id, hall_name, waste_name
    from dbo.food_waste_report 
    Join dbo.dinning_halls on hall_id = food_waste_report_hall_id
    Join dbo.waste on waste_id = food_waste_report_waste_id
    group by food_waste_report_hall_id, food_waste_report_waste_id, hall_name, waste_name
GO

Drop View if exists v_inventory_waste_report
GO
Create View v_inventory_waste_report with SCHEMABINDING AS
    Select inventory_waste_report_hall_id,sum(inventory_waste_report_quantity) as inventory_quantity,sum(inventory_report_inventory_cost) as inventory_waste_report_inventory_cost,hall_name,inventory_waste_report_waste_id, waste_name
    from dbo.inventory_waste_report 
    Join dbo.dinning_halls on hall_id = inventory_waste_report_hall_id
    Join dbo.waste on waste_id = inventory_waste_report_waste_id
    group by inventory_waste_report_hall_id, inventory_waste_report_waste_id, hall_name, waste_name

-- VIEW
GO
SELECT * from cost_report
SELECT * from waste_report
SELECT * from food
SELECT * from waste
SELECT * from dinning_halls
SELECT * from students
SELECT * from student_year
SELECT * from inventory
select * from food_waste_report
select * from inventory_waste_report

select * from v_inventory_waste_report
select * from v_food_waste_report


-- Triggers and Procedures
GO
DROP PROCEDURE if EXISTS p_insert_cost_report

GO

CREATE PROCEDURE p_insert_cost_report
(
    @p_report_hall_id int,
    @p_report_hall_student_count int,
    @p_report_cost_incurred money,
    @p_report_cp_ratio float
)
as Begin 
    Begin TRY
        Begin TRANSACTION
            Insert Into cost_report(report_generation_date, report_hall_id, report_hall_student_count, report_cost_incurred, report_cp_ratio)
            Values (SYSDATETIME(),@p_report_hall_id, @p_report_hall_student_count,@p_report_cost_incurred, @p_report_cp_ratio)
                if @@ROWCOUNT <>1 Throw 50001, 'Error in Insert',1
                return @@Identity
            COMMIT
        END TRY
        Begin CATCH
        THROW 50002, 'Invalid Input',1
        ROLLBACK;
        End CATCH
    END

GO

Drop view if exists v_waste_report 

Go

Create view v_waste_report WITH SCHEMABINDING As
    select report_id, report_hall_id, report_food_wasted,report_inventory_wasted,report_student_count, report_generation_date from dbo.waste_report
    
Go
drop trigger if exists t_v_waste_cost


GO
Create trigger t_v_waste_cost
    on waste_report
        INSTEAD OF INSERT
        As Begin 
        Declare @report_hall_id int
        Declare @report_hall_student_count int
        Declare @inventory_wasted INT
        Declare @food_wasted INT
        select @report_hall_id = report_hall_id, @report_hall_student_count = report_student_count, @food_wasted = report_food_wasted, @inventory_wasted = report_inventory_wasted from inserted;

        Declare @report_cost_incurred_food float = (select food_waste_report_cost from v_food_waste_report where food_waste_report_hall_id = @report_hall_id)

        Declare @report_cost_incurred_inventory float = (select cast(sum(inventory_waste_report_inventory_cost)as float) from v_inventory_waste_report where inventory_waste_report_hall_id = @report_hall_id)
        Declare @report_cost_incurred float = (@report_cost_incurred_food + @report_cost_incurred_inventory)
        Declare @food_prepared float = (select cast(sum(food_quantity)as float) from food where food_hall_id = @report_hall_id)
        Declare @inventory_bought float = (select cast(sum(inventory_quantity) as float) from inventory where inventory_hall_id = @report_hall_id)
        Declare @report_cp_ratio float =((@food_prepared + @inventory_bought - @food_wasted - @inventory_wasted)/(@food_prepared + @inventory_bought))

        EXEC p_insert_cost_report @p_report_hall_id = @report_hall_id, @p_report_hall_student_count = @report_hall_student_count, @p_report_cost_incurred = @report_cost_incurred, @p_report_cp_ratio = @report_cp_ratio
       
        END    

GO


--1: Which hall has created the maximum wase

select Top 1 sum(report_food_wasted + report_inventory_wasted) as waste_count, report_hall_id, hall_name
from waste_report 
Join dinning_halls on hall_id = report_hall_id
group by report_hall_id, hall_name
ORDER BY waste_count DESC

--2: Which hall has incurred the highest cost?

select Top 1 sum(report_cost_incurred) as cost_incurred, hall_name
from cost_report 
Join dinning_halls on hall_id = report_hall_id
group by (report_hall_id), hall_name
ORDER by (cost_incurred) DESC

--3: Which is the most and least pouplar hall?
-- Most Popular
select Top 1 sum(report_student_count) as student_count, hall_name
from waste_report
join dinning_halls on hall_id = report_hall_id
group by report_hall_id, hall_name
order by student_count desc

--Least Popular
select Top 1 sum(report_student_count) as student_count, hall_name
from waste_report
join dinning_halls on hall_id = report_hall_id
group by report_hall_id, hall_name
order by student_count 


--4: Which hall has the highest waste for non recyclable inventory?
select Top 1 sum(inventory_waste_report_inventory_cost) as inventory_cost, sum(inventory_quantity) as report_inventory_quantity, waste_name,dinning_halls.hall_name
from v_inventory_waste_report
Join dinning_halls on hall_id = inventory_waste_report_hall_id
where inventory_waste_report_waste_id = 2
group by inventory_waste_report_hall_id, inventory_waste_report_waste_id, waste_name, dinning_halls.hall_name
order by report_inventory_quantity desc

--5: Which hall has the highest food wasted?
select top 1 hall_name, sum(food_waste_report_quantity) as quantity, sum(food_waste_report_cost) as cost
from food_waste_report
join dinning_halls on hall_id = food_waste_report_hall_id
group by food_waste_report_hall_id, hall_name
order by quantity desc


