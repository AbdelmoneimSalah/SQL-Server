-- Wroking on Company_SD Database
-------------------------------------
--1.Display all the employees Data
SELECT * 
FROM [dbo].[Employee]
-----------------------------------------------------------------------------
--2.Display the employee First name, last name, Salary and Department number
SELECT Fname,Lname,Salary,Dno
FROM [dbo].[Employee]
------------------------------------------------------------------------------
--3.Display all the projects names, locations and the department which is responsible about it.
SELECT Pname,Plocation,Dnum
FROM [dbo].[Project]
----------------------------------------------------------------------------------------------
/*4.If you know that the company policy is to pay an annual commission for each
employee with specific percent equals 10% of his/her annual salary .Display each
employee full name and his annual commission in an ANNUAL COMM column (alias).*/
SELECT Fname+' '+Lname as [Full name], (Salary*12)*.1 as [ANNUAL COMM]
from [dbo].[Employee]
---------------------------------------------------------------------------------
--5.Display the employees Id, name who earns more than 1000 LE monthly.
SELECT SSN,Fname,Salary
FROM [dbo].[Employee]
WHERE Salary >1000;
-------------------------------------------------------------------------
--6.Display the employees Id, name who earns more than 10000 LE annually
SELECT SSN,Fname,Salary
FROM [dbo].[Employee]
WHERE (Salary*12)>10000;
--------------------------------------------------------------------------
--7.Display the names and salaries of the female employees 
SELECT Fname,Salary
FROM [dbo].[Employee]
WHERE Sex='F'
------------------------------------------------------------------------
--8.Display each department id, name which managed by a manager with id equals 968574.
SELECT Dnum,Dname
from [dbo].[Departments]
WHERE MGRSSN=968574
----------------------------------------------------------------------------
--9.Dispaly the ids, names and locations of  the pojects which controled with department 10.
SELECT Pnumber,Pname,Plocation
FROM [dbo].[Project]
WHERE Dnum=10
--------------------------------------------------------------------------------
--10.	Display the Department id, name and id and the name of its manager.
SELECT d.Dnum,d.Dname,e.Fname as [Manger Name]
FROM [dbo].[Departments] d,[dbo].[Employee] e
WHERE d.MGRSSN=e.SSN
-------------------------------------------------------------
--11.Display the name of the departments and the name of the projects under its control.
SELECT d.Dname,p.Pname
FROM [dbo].[Departments] d,[dbo].[Project] p
WHERE d.Dnum=p.Dnum
Group BY d.Dname,p.Pname
-------------------------------------------------------------------------------------
--12.Display the full data about all the dependence associated with the name of the employee they depend on him/her
SELECT d.*,e.Fname as [employee name]
FROM [dbo].[Dependent] d,[dbo].[Employee] e
where e.SSN=d.ESSN
--------------------------------------------------------------------------------------
--13.Display the Id, name and location of the projects in Cairo or Alex city.
SELECT Pnumber,Pname,Plocation
FROM [dbo].[Project]
WHERE City in('Alex','Cairo')
------------------------------------------------------------------------------------------
--14.Display the Projects full data of the projects with a name starts with "a" letter.
SELECT *
FROM [dbo].[Project] p
WHERE p.Pname LIKE 'a%'
------------------------------------------------------
--15.display all the employees in department 30 whose salary from 1000 to 2000 LE monthly
SELECT *
FROM [dbo].[Employee] e
WHERE e.Dno=30 AND Salary BETWEEN 1000 AND 2000
------------------------------------------------------------------
--16.Retrieve the names of all employees in department 10 who works more than or equal 10 hours per week on "AL Rabwah" project.
SELECT e.Fname
FROM [dbo].[Employee] e, [dbo].[Project] p,[dbo].[Works_for] w
WHERE e.SSN=w.ESSn AND p.Pnumber=w.Pno AND e.Dno=10 AND w.Hours>= 10 AND p.Pname='AL Rabwah'
--------------------------------------------------------------------------------------------------
--17.Find the names of the employees who directly supervised with Kamel Mohamed
SELECT e.Fname
FROM [dbo].[Employee] e ,[dbo].[Employee] s
WHERE s.Superssn =e.SSN AND s.Fname='Kamel' AND s.Lname='Mohamed'
-------------------------------------------------------------------------------------
--18.Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name
SELECT e.Fname , p.Pname
FROM [dbo].[Employee] e , [dbo].[Project] p,[dbo].[Works_for] w
WHERE e.SSN=w.ESSn and p.Pnumber=w.Pno
ORDER BY p.Pname 
---------------------------------------------------------------------------------------------
/*19.For each project located in Cairo City , find the project number, the controlling department name ,the department manager last name 
,address and birthdate.*/
SELECT p.Pname,d.Dname,e.Lname as [Manger Lname],e.Address as [Manger Address],e.Bdate as [Manger Bdate]
FROM [dbo].[Project] p ,[dbo].[Departments] d , [dbo].[Employee] e
WHERE p.Dnum=d.Dnum AND d.MGRSSN=e.SSN AND p.City='Cairo'
------------------------------
--20.Display All Data of the mangers
SELECT e.*
FROM [dbo].[Employee] e ,[dbo].[Departments] d
WHERE e.SSN=d.MGRSSN
-------------------------------------------------------------------
--21.Display All Employees data and the data of their dependents even if they have no dependents
SELECT e.*,d.*
FROM [dbo].[Employee] e LEFT OUTER JOIN [dbo].[Dependent] d
ON e.SSN=d.ESSN
---------------------------------
--22.Insert your personal data to the employee table as a new employee in department number 30, SSN = 102672, Superssn = 112233, salary=3000.
INSERT INTO [dbo].[Employee] 
VALUES('Abdelmoneim','Salah',102672,'1995-08-28','Helwan','M',3000,112233,30)
----------------------------------------------------------------
/*23.Insert another employee with personal data your friend as new employee in department number 30, SSN = 102660, 
but don’t enter any value for salary or manager number to him.*/
INSERT INTO [dbo].[Employee] (Fname,Lname,SSN,Bdate,Address,Sex,Dno)
VALUES('Abdelrhamn','Adnan',102660,'1995-07-20','Giza','M',30)
------------------------------------------------------------------------------
--24.Upgrade your salary by 20 % of its last value.
UPDATE [dbo].[Employee]
SET Salary=Salary+.2*Salary
WHERE SSN=102672
----------------------------------------