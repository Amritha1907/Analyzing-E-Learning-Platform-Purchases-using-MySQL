create database Digital_course;
use Digital_course;

#1. Create the database and schema. Populate the Schema:

create table learners(
learner_id int Primary key, 
Full_name Varchar(100), 
Country varchar(100)
);

Create table courses(
course_id int Primary key, 
course_name Varchar(100), 
category varchar(100),
unit_price float
);

Create table purchases(
purchase_id int primary key,
quantity int,
purchase_date date,
learner_id int, 
course_id int,
foreign key (learner_id) references learners(learner_id)
on update cascade
on delete cascade,
foreign key (course_id) references courses(course_id)
on update cascade
on delete cascade
);

INSERT INTO learners (learner_id, full_name, country) VALUES
(1, 'Alice Johnson', 'USA'),
(2, 'Bob Smith', 'UK'),
(3, 'Charlie Lee', 'India'),
(4, 'Diana Patel', 'Canada'),
(5, 'Amritha', 'USA'),
(6, 'Varsha', 'India'),
(7, 'Patel', 'Germary'),
(8, 'Ethan Brown', 'Australia');

INSERT INTO courses (course_id, course_name, category, unit_price) VALUES
(101, 'Python Basics', 'Programming', 55.2389),
(102, 'Advanced Python', 'Programming', 81.3171),
(103, 'Data Science 101', 'Data Science', 100.4063),
(104, 'Machine Learning', 'Data Science', 150.5534),
(105, 'UI/UX Design', 'Design', 70.8256),
(106, 'Photoshop Essentials', 'Design', 65.2101),
(107, 'Cybersecurity Fundamentals', 'Security', 129.1923); 

INSERT INTO purchases (purchase_id, learner_id, course_id, quantity, purchase_date) VALUES
(1, 1, 101, 1, '2026-01-05'), 
(2, 1, 103, 1, '2026-01-10'), 
(3, 2, 102, 2, '2026-01-12'), 
(4, 2, 105, 1, '2026-01-15'), 
(5, 3, 103, 1, '2026-01-20'), 
(6, 3, 104, 1, '2026-01-22'), 
(7, 4, 101, 1, '2026-01-25'), 
(8, 4, 105, 2, '2026-01-28'),
(9, 5, 106, 1, '2026-01-30'); 

insert into purchases
(purchase_id, Quantity, Purchase_date, learner_id, Course_id) values
(1007, 8, '2023-09-11', 4,103),
(1008, 7, '2025-11-10', 2,102);

select*from purchases;
select*from courses;
select*from learners;

#Format currency values to 2 decimal places.

alter table courses 
modify unit_price decimal(10,2);

#2. Data Exploration Using Joins
#Combine learner, course, and purchase data.

select full_name, Country
from learners
join Purchases
On Learners.learner_id = purchases.learner_id;

select full_name as Learner_name, Course_name, Category
from learners as l
Left Join purchases as p
On l.learner_id = p.learner_id
Left Join courses as c
On p.course_id = c.course_id;

select Quantity, Unit_price, Category, Full_name as Learner_name
from purchases p
Right Join Learners l
On p.learner_id =l.learner_id
Right Join Courses c
On p.course_id =c.course_id;

#Sort results appropriately (e.g., highest total_spent first).
#Display each learner’s purchase details (course name, category, quantity, total amount, and purchase date).

Select Country, Full_Name, Course_name , category course_category, Quantity, Unit_price, (Quantity*unit_price) total_amount, purchase_date from purchases p
Inner join learners l
On p.learner_id = l.Learner_id
Inner Join Courses c
On p. course_id = c.course_id
order by total_amount desc;

#3. Analytical Queries
#Q1. Display each learner’s total spending (quantity × unit_price) along with their country.

Select (quantity*unit_price) total_amount, country
from purchases p
join learners l
On l.learner_id=p.learner_id
Join Courses c
On c.course_id=p.course_id;

#Q2. Find the top 3 most purchased courses based on total quantity sold.

Select course_name, sum(Quantity) as Total_Quantity
from purchases p
join courses c
On c.course_id=p.course_id
group by c.course_name
order by total_quantity desc
limit 3;

#Q3. Show each course category’s total revenue and the number of unique learners who purchased from that category.
select Category, sum(unit_price*Quantity) Total_revenue, count(distinct p.learner_id) Unique_Purchase
from Purchases p
join courses c
On c.course_id =p.course_id
group by category
order by Total_revenue desc;

#Q4. List all learners who have purchased courses from more than one category

select Full_name 
from Learners l
Join Purchases p
On p.learner_id=l.learner_id
Join Courses c
On p.Course_id= c.Course_id
group by l.learner_id, full_name
having count(distinct category)>1;

#Q5. Identify courses that have not been purchased at all.

Select Category, Course_name
from Courses c
left join purchases p
On p.course_id=c.course_id
where Quantity is null;
