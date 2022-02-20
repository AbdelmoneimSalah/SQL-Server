----- DQL on Company_SD DataBase
--1.For each project, list the project name and the total hours per week (for all employees) spent on that project.
SELECT p.Pname,SUM(w.Hours) as [Total hours] 
FROM [dbo].[Project] p,[dbo].[Works_for] w
WHERE p.Pnumber= w.Pno
GROUP BY p.Pname
----------------------------------------------------------------
--2.Display the data of the department which has the smallest employee ID over all employees' ID.
SELECT d.*
FROM [dbo].[Departments] d , [dbo].[Employee] e
WHERE  e.Dno=d.Dnum AND e.SSN=(SELECT MIN(s.SSN) FROM [dbo].[Employee] s)
-----------------------------------------------------------------------------------------------------
--3.For each department, retrieve the department name and the maximum, minimum and average salary of its employees.
SELECT d.Dname, MAX(e.Salary) as [Max Salary],MIN(e.Salary) as [Min Salary],AVG(e.Salary) as [Avg Salary]
FROM [dbo].[Employee] e ,[dbo].[Departments] d
WHERE e.Dno=d.Dnum
GROUP BY d.Dname
---------------------------------------------------------------------
--4List the last name of all managers who have no dependents
SELECT e.Lname
FROM [dbo].[Employee] e ,[dbo].[Departments] d
WHERE  e.SSN =d.MGRSSN AND d.MGRSSN NOT IN(SELECT ESSN FROM [dbo].[Dependent])
--------------------------------------------------------------------------------
--5.For each department if its average salary is less than the average salary of all employees
--display its number, name and number of its employees
SELECT d.Dnum,d.Dnum,COUNT(e.SSN) as [#Employees]
FROM [dbo].[Departments] d ,[dbo].[Employee] e
WHERE e.Dno=d.Dnum
GROUP BY d.Dnum,d.Dname
HAVING AVG(e.Salary) <(SELECT AVG(Salary) FROM [dbo].[Employee] )
--------------------------------------------------------------------------------------
/*6.Retrieve a list of employees and the projects they are working on ordered by department and within each department, 
ordered alphabetically by last name, first name.*/
SELECT e.Fname,e.Lname,p.Pname,p.Dnum
FROM [dbo].[Employee] e , [dbo].[Project] p , [dbo].[Works_for] w
WHERE e.SSN=w.ESSn AND p.Pnumber=w.Pno 
GROUP BY e.Fname,e.Lname,p.Pname,p.Dnum
ORDER BY e.Lname,e.Fname
-------------------------------------------------------------------------------------------
--7. the max 2 salaries using subquery
SELECT DISTINCT e1.Salary
FROM [dbo].[Employee] e1
WHERE 2>(SELECT DISTINCT(COUNT(e2.Salary))  FROM [dbo].[Employee] e2 WHERE e2.Salary>e1.Salary) AND e1.Salary IS NOT NULL
------------------------------------------------------------------------------
--8. update all salaries of employees who work in Project ‘Al Rabwah’ by 30% 
UPDATE [dbo].[Employee] 
SET Salary=Salary+.3*Salary
WHERE SSN IN(SELECT w.ESSn FROM [dbo].[Project] p,[dbo].[Works_for] w WHERE p.Pnumber=w.Pno AND p.Pname='Al Rabwah')
-----------------------------------------------------------------------------------------
--10.Display the employee number and name if at least one of them have dependents
SELECT e.SSN , e.Fname
FROM [dbo].[Employee] e
WHERE EXISTS ( SELECT d.ESSN FROM [dbo].[Dependent] d WHERE d.ESSN=e.SSN)
---------------------------------------------------