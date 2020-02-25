/*Chapter 3.2*/
%let path=/folders/myfolders/Data_One/;

libname orion "/folders/myfolders/Data_One/";
/*Level 1*/
/*a, Use an interactive facility to explore the orion.library and 
     answer the questions.*/
proc contents data=orion.country;
run;

proc print data=orion.country;
run;
/*a, 7 observations; 6 variables; South Africa;*/
/*b, Submit a PROC CONTENTS step to generate a list of all members
     in the orion library. What is the name of the last member listed?*/
proc contents data=orion._all_ nods;
run;
/*b, US_SUPPLIERS;*/
/*Level 2*/
/*Examine the general data set properties of orion.staff.*/
proc contents data=orion.staff;
run;
/*b, What is the information is stored for this data set?
   According to the variables and index inforamtion
   we know the information is sorted according to index
   Employee_ID with ANSI character.*/
/*Challenge
Name:autoexec.sas
Purpose: Autoexec file contains the statements that will
         be executed immediately at initial of SAS. Auotoexec
         file can help set up variables of SAS and other system
         options to assist users.
How to create: Use SAS text editor with SAS statements and save 
         as autoexec file.
How could useful: One typical autoexec file is LIBNAME statement 
         which can help set the library.
*/

/*Chapter 4.1*/
/*Level 1*/
/*a, Run the program and view the output.Observe that there are 
     617 observations. Observations might be displayed over two 
     lines, depending on output settings.*/
proc print data=orion.order_fact;
run;
/*b, Add a SUM statement to display the sum of Total_Retail_Price.
     The last several lines of the report is given.*/
proc print data=orion.order_fact;
     sum Total_Retail_Price;
run;
/*c, Add a WHERE statement to select only the observations with Total_
     Retail_Price more than 500. Submit the program, verify that 35
     observations were displayed.*/
proc print data=orion.order_fact;
     where Total_Retail_Price >500;
     sum Total_Retail_Price;
run;
/*What do you notice about the Obs column:
  Ans:Obs column numbers are not sequential because they keep their original number.
  Did the sum of Total_Retail_Price change to reflect only the subset:
  Ans:Yes, sum change to reflect only the subset.*/
/*d, Add an option to suppress the Obs column. How can you verify the
     number of observations in the results?*/
proc print data=orion.order_fact noobs;
     where Total_Retail_Price >500;
     sum Total_Retail_Price;
run;
/*Ans: See the log notes to verify the number of observations.*/
/*e, Add an ID statement to use Customer_ID as the identifying variable. Submit
     the program. The results contains 35 observations. How did the output change?*/
proc print data=orion.order_fact noobs;
     where Total_Retail_Price >500;
     sum Total_Retail_Price;
     id Customer_ID;
run;
/*Ans:Add one Customer_ID column in the left side.*/
/*f, Add a VAR statement to display Customer_ID, Order_ID, Order_Type, Quantity,
     and Total_Retail_Price.What do you notice about customer_ID?*/
proc print data=orion.order_fact noobs;
     where Total_Retail_Price >500;
     sum Total_Retail_Price;
     id Customer_ID;
     var Customer_ID Order_ID Order_Type 
         Quantity Total_Retail_Price;
run;
/*Ans:The Customer_ID has appeared twice because
      one is act as id the other is variable.*/
/*g, Modify the VAR statement to address the issue with Customer_ID.*/
proc print data=orion.order_fact noobs;
     where Total_Retail_Price >500;
     sum Total_Retail_Price;
     id Customer_ID;
     var Order_ID Order_Type 
         Quantity Total_Retail_Price;
run;
/*Level 2*/
/* a, Write a PRINT step to display orion.customer_dim*/
proc print data=orion.customer_dim;
run;
/* b, selecting customers between ages of 30 and 40, suppress
the Obs column*/
proc print data=orion.customer_dim noobs;
     where Customer_age between 30 and 40;
run;
/* c, Use Customer_ID as id*/
proc print data=orion.customer_dim noobs;
     where Customer_age between 30 and 40;
     id Customer_ID;
run;
/* d, only show variables in the report*/
proc print data=orion.customer_dim noobs;
     where Customer_age between 30 and 40;
     id Customer_ID;
     var Customer_ID Customer_Name Customer_Age
         Customer_Type;
run;

/*Chapter 4.2*/
/*Level 1*/
/*Question 1*/
/*a, Add a PROC SORT to sort orion.employee_payroll
     by salary, placing the sorted observations into
     a temporary data set named sort_salary.*/
proc sort data=orion.employee_payroll
			 out=work.sort_salary;
	by Salary;
run;
/*b, Modify the PROC PRINT step to display the new data
     set. Verify that your output matches the report.*/
proc print data=work.sort_salary;
run;
/*Question 2*/
/*a, Add a PROC SORT step to sort orion.employee_payroll
     by Employee_Gender, and within gender by Salary in
     descending order. Place the sorted observations into
     a temporary data set named sort_salary2.*/
proc sort data=orion.employee_payroll
			 out=work.sort_salary2;
	by Employee_Gender descending Salary;
run;
/*b, Modify the PROC PRINT step to display the new data set with
     the observations grouped by Employee_Gender.*/
proc print data=work.sort_salary2;
	by Employee_Gender;
run;
/*Level 2*/
/*a, Sort orion.employee_payroll by Employee_Gender, and by 
     descending Salary within gender. Place the sorted observation
     into a temporary data set named sort_sal.*/
proc sort data=orion.employee_payroll
			 out=work.sort_sal;
	by Employee_Gender descending Salary;
run;
/*b, Print a subset of the sort_sal data set. Select only the observation
     for active employees(those without a value for Employee_Term_Date) who
     earn more than $65,000. Group the report by Employee_Gender, and include
     a total and subtotal for Salary. Suppress the Obs column. Display only 
     Employee_ID, Salary, and Marital_Status.*/
proc print data=work.sort_sal noobs;
	by Employee_Gender;
	sum Salary;
	where Employee_Term_Date is missing and Salary>65000;
	var Employee_ID Salary Marital_Status;
 run;
/*Chapter 4.3*/
/*Level 1*/
/*Question 1*/
/*a, just run the code*/
/*b, Add a VAR statement to display only the variables shown
     in the report.*/
proc print data=orion.sales noobs;
	where Country='AU' and Job_Title contains 'Rep. IV';
	var Employee_ID First_Name Last_Name Gender Salary;
run;
/*c, Add TITLE and FOOTNOTE statements to include the titles
     and footnotes shown in the report.*/
title1 'Australian Sales Employees';
title2 'Senior Sales Representatives';
footnote1 'Job_Title: Sales Rep. IV';

proc print data=orion.sales noobs;
	where Country='AU' and Job_Title contains 'Rep. IV';
	var Employee_ID First_Name Last_Name Gender Salary;
run;
title;
footnote;
/*d, verify the output*/
/*e, submit a null TITLE and null FOOTNOTE statement to clear
     all titles and footnotes.*/
proc print data=orion.sales noobs;
	where Country='AU' and Job_Title contains 'Rep. IV';
	var Employee_ID First_Name Last_Name Gender Salary;
run;
/*Question 2*/
/*a, Modify the program to define and use the given labels.*/
title 'Entry-level Sales Representatives';
footnote 'Job_Title: Sales Rep. I';

proc print data=orion.sales noobs label;
	where Country='US' and Job_Title='Sales Rep. I';
	var Employee_ID First_Name Last_Name Gender Salary;
	label Employee_ID="Employee ID"
			First_Name="First Name"
			Last_Name="Last Name"
			Salary="Annual Salary";	
run;

title;
footnote;

title 'Entry-level Sales Representatives';
footnote 'Job_Title: Sales Rep. I';
/*b, Modify the program to use a blank space as the SPLIT=
     character to generate two-line column headings. Submit
     the modified program and verify that two-line column labels
     are displayed.*/
proc print data=orion.sales noobs split=' ';
	where Country='US' and Job_Title='Sales Rep. I';
	var Employee_ID First_Name Last_Name Gender Salary;
	label Employee_ID="Employee ID"
			First_Name="First Name"
			Last_Name="Last Name"
			Salary="Annual Salary";	
run;

title;
footnote;
/*Level 2*/
/*a, Write a program to display a sub set of orion.employee_
     address as shown. The program should sort the observations
     by State, City, and Employee_Name*/
proc sort data=orion.employee_addresses out=work.address;
	where Country='US';
	by State City Employee_Name;
run;
/*And then display the sorted observations grouped by State.*/
title "US Employees by State";
proc print data=work.address noobs split=' ';
	var Employee_ID Employee_Name City Postal_Code;
	label Employee_ID='Employee ID'
			Employee_Name='Name'
			Postal_Code='Zip Code';
	by State;
run;

/*Chapter 5.1*/
/*Level 1*/
/*b, Modify the PROC PRINT step to display only Employee_ID,
     Salary, Birth_Date, and Employee_Hire_Date.*/
proc print data=orion.employee_payroll;
	var Employee_ID Salary Birth_Date Employee_Hire_Date;
run;
/*c, Add a FORMAT statement to display Salary in a dollar format,
     Birth_Date in 01/31/2012 date style, and Employee_Hire_Date
     in the 01JAN2012 date style.*/
proc print data=orion.employee_payroll;
	var Employee_ID Salary Birth_Date Employee_Hire_Date;
	format Salary dollar11.2 Birth_Date mmddyy10. 
		    Employee_Hire_Date date9.;
run;
/*Level 2*/
/*a, Write a PROC PRINT step to display the report below using 
     orion.sales as input. Subset the observations and variables
     to produce the report as shown. Include titles, labels, and 
     formats.*/
title1 'US Sales Employees';
title2 'Earning Under $26,000';

proc print data=orion.sales label noobs;
	where Country='US' and Salary<26000;
	var Employee_ID First_Name Last_Name Job_Title Salary Hire_Date;
	label First_Name='First Name'
		   Last_Name='Last Name'
			Job_Title='Title'
			Hire_Date='Date Hired';
	format Salary dollar10. Hire_Date monyy7.;
run;
title;
footnote;

/*Chapter 5.2*/
/*Level 1*/
/*a, Retrieve the starter program*/
data Q1Birthdays;
   set orion.employee_payroll;
   BirthMonth=month(Birth_Date);
   if BirthMonth le 3;
run;
/*b, Create a character format named $GENDER that displays gender 
     codes as required.*/
proc format;
   value $gender
      'F'='Female'
      'M'='Male';
run;
/*c, Create a numeric format named MNAME that displays month numbers.*/
proc format;
   value mname
       1='January'
       2='February'
       3='March';
run;
/*d, Add a PROC PRINT step to display the data set, applying these two user-defined
     formats to the Employee_Gender and BirthMonth variables, respectively.*/
proc print data=Q1Birthdays;
	 format Employee_Gender $gender.
          BirthMonth mname.;
run;
/*e, Submit the program to produce the report.*/          
title 'Employees with Birthdays in Q1';
proc print data=Q1Birthdays;
	var Employee_ID Employee_Gender BirthMonth;
   format Employee_Gender $gender.
          BirthMonth mname.;
run;
title;
/*Level 2*/
/*a, Retrieve the starter program.*/
proc print data=orion.nonsales;
   var Employee_ID Job_Title Salary Gender;
   title1 'Salary and Gender Values';
   title2 'for Non-Sales Employees';
run;
/*b, Create a character format named $GENDER that
     displays gender codes as given.*/
proc format;
   value $gender 'F'='Female'
                 'M'='Male'
               other='Invalid code';
run;
/*c, Create a numeric format named SALRANGE that displays
     salary ranges as given.*/     
proc format;
   value $gender 'F'='Female'
                 'M'='Male'
               other='Invalid code';

   value salrange .='Missing salary'
      20000-<100000='Below $100,000'
      100000-500000='$100,000 or more'
              other='Invalid salary';
run;
/*d, In the PROC PRINT step, apply these two user-defined formats 
     to the Gender and Salary variables, respectively. Submit the
     program to produce the report.*/
title1 'Salary and Gender Values';
title2 'for Non-Sales Employees';

proc print data=orion.nonsales;
   var Employee_ID Job_Title Salary Gender;
   format Salary salrange. Gender $gender.;
run;

title;

/*Chapter 6.2*/
/*a, Write a DATA step to create work.delays
     using orion.orders as input.*/
data work.delays;
   set orion.orders;
run;
/*b, Create a new variable, Order_Month, and 
     set it to the month of Order_Date.*/
data work.delays;
   set orion.orders;
   Order_Month=month(Order_Date);
run; 
/*c, Use a WHERE statement and a subsetting IF
     statement to select only the observations 
     that meet all of the given conditions.*/
data work.delays;
   set orion.orders;
   where Order_Date+4<Delivery_Date 
         and Employee_ID=99999999;
   Order_Month=month(Order_Date);
   if Order_Month=8;
run;
/*d, The new data set should include only
     Employee _ID, Order_Date, Delivery_Date,
     and Order_Month.*/
/*e, Add permanent labels for Order_Date, Delivery_Date,
     and Order_Month as shown.*/
data work.delays;
   set orion.orders;
   where Order_Date+4<Delivery_Date 
         and Employee_ID=99999999;
   Order_Month=month(Order_Date);
   if Order_Month=8;
	label Order_Date='Date Ordered'
	      Delivery_Date='Date Delivered'
			Order_Month='Month Ordered';
run;     
/*f, Add permanent formats to display Order_Date
     and Delivery_Date as MM/DD/YYYY.*/   
data work.delays;
   set orion.orders;
   where Order_Date+4<Delivery_Date 
         and Employee_ID=99999999;
   Order_Month=month(Order_Date);
   if Order_Month=8;
	label Order_Date='Date Ordered'
	      Delivery_Date='Date Delivered'
			Order_Month='Month Ordered';
	format Order_Date Delivery_Date mmddyy10.;
	keep Employee_ID Customer_ID Order_Date Delivery_Date Order_Month;
run;
/*g, Add a PROC CONTENTS step to verify that labels and
     formats were stored permanently.*/
proc contents data=work.delays;
run;
/*h, Write a PROC PRINT step to create the report below.Results
     should contain nine observations.*/
proc print data=work.delays;
run;

/*Chapter 9.1 */
/*Level 2*/
/*a, Write a DATA step that reads orion.customer
     to create work.birthday.*/
data work.birthday;
   set orion.customer;
run;
/*b, In the DATA step, create three new variables:
     Bday2012, BdayDOW2012, and Age2012.*/
data work.birthday;
   set orion.customer;
   Bday2012=mdy(month(Birth_Date),day(Birth_Date),2012);
   BdayDOW2012=weekday(Bday2012);
   Age2012=(Bday2012-Birth_Date)/365.25;
run; 
/*c, Include only the following variables in the new data
     set:Customer_Name, Birth_Date, Bday2012, BdayDOW2012,
     and Age2012.*/
data work.birthday;
   set orion.customer;
   Bday2012=mdy(month(Birth_Date),day(Birth_Date),2012);
   BdayDOW2012=weekday(Bday2012);
   Age2012=(Bday2012-Birth_Date)/365.25;
   keep Customer_Name Birth_Date Bday2012 BdayDOW2012 Age2012;
run;
/*d, Formate Bday2012 to display in the form 01Jan2012 should 
     be formatted to display with no decimal places.*/
data work.birthday;
   set orion.customer;
   Bday2012=mdy(month(Birth_Date),day(Birth_Date),2012);
   BdayDOW2012=weekday(Bday2012);
   Age2012=(Bday2012-Birth_Date)/365.25;
   keep Customer_Name Birth_Date Bday2012 BdayDOW2012 Age2012;
   format Bday2012 date9. Age2012 3.;
run;
/*e, Write a PROC PRINT step to create the report below. The results
     should contain 77 observations.*/
proc print data=work.birthday;
run;

/*Chapter 9.2*/
/*Level*/
/*Question 1*/
/*a, Write a DATA step that reads orion.custome_dim to 
     create work.season.*/
data work.season;
   set orion.customer_dim; 
run;    
/*b, Create two new variables:Promo and Promo2.*/
data work.season;
   set orion.customer_dim;
   length Promo2 $ 6;
   Quarter=qtr(Customer_BirthDate);
   if Quarter=1 then Promo='Winter';
   else if Quarter=2 then Promo='Spring';
   else if Quarter=3 then Promo='Summer';
   else if Quarter=4 then Promo='Fall';
   if Customer_Age>=18 and Customer_Age<=25 then  Promo2='YA';
   else if Customer_Age>=65 then  Promo2='Senior';
run;
/*c, The new data set should include only Customer_FirstName,
     Customer_LastName, Customer_BirthData, Customer_Age, Promo,
     and Promo2.*/     
data work.season;
   set orion.customer_dim;
   length Promo2 $ 6;
   Quarter=qtr(Customer_BirthDate);
   if Quarter=1 then Promo='Winter';
   else if Quarter=2 then Promo='Spring';
   else if Quarter=3 then Promo='Summer';
   else if Quarter=4 then Promo='Fall';
   if Customer_Age>=18 and Customer_Age<=25 then  Promo2='YA';
   else if Customer_Age>=65 then  Promo2='Senior';
   keep Customer_FirstName Customer_LastName Customer_BirthDate   
        Customer_Age Promo Promo2; 
run;
/*d, Create the report as given. The results include 77 observations.*/
proc print data=work.season;
   var Customer_FirstName Customer_LastName Customer_BirthDate Promo 
       Customer_Age Promo2; 
run;
/*Question 2*/
/*a, Write a DATA step that reads orion.orders to create
     work.ordertype.*/
data work.ordertype;
   set orion.orders;
run; 
/*b, Create a new variable, DayOfWeek, that is equal to the 
     weekday of Order_Date.*/ 
data work.ordertype;
   set orion.orders;
   length Type $ 13 SaleAds $ 5;
   DayOfWeek=weekday(Order_Date); 
run;       
/*c, Create the new variable Type, as described.*/ 
data work.ordertype;
   set orion.orders;
   length Type $ 13 SaleAds $ 5;
   DayOfWeek=weekday(Order_Date);
   if Order_Type=1 then Type='Retail Sale';
   else if Order_Type=2 then Type='Catalog Sale';
   else if Order_Type=3 then Type='Internet Sale';
run;
/*d, Create the new variable SaleAds, which is equal to*/
data work.ordertype;
   set orion.orders;
   length Type $ 13 SaleAds $ 5;
   DayOfWeek=weekday(Order_Date);
   if Order_Type=1 then 
      Type='Retail Sale';
   else if Order_Type=2 then do;
      Type='Catalog Sale';
	   SaleAds='Mail';
   end;
   else if Order_Type=3 then do;
      Type='Internet Sale';
	   SaleAds='Email';
   end;
run;
/*e, Do not include Order_Type, Employee_ID,
     and Customer_ID in the new data set.*/      
data work.ordertype;
   set orion.orders;
   length Type $ 13 SaleAds $ 5;
   DayOfWeek=weekday(Order_Date);
   if Order_Type=1 then 
      Type='Retail Sale';
   else if Order_Type=2 then do;
      Type='Catalog Sale';
	   SaleAds='Mail';
   end;
   else if Order_Type=3 then do;
      Type='Internet Sale';
	   SaleAds='Email';
   end;
   drop Order_Type Employee_ID Customer_ID;
run;
/*f, Create the report as given, the results should contains
     490 observations.*/
proc print data=work.ordertype;
run;

/*Chapter 10.1*/
/*Level 2*/
/*a, Submit the PROC CONTENTS steps or explore the data sets
     interactively to complete the table given by filling in attributes
     information for each variable in the each data set.*/
proc contents data=orion.charities;
run;

proc contents data=orion.us_suppliers;
run;

proc contents data=orion.consultants;
run;
/*                        code           Company         ContactType
                      Type   Length    Type   Length   Type    Length
Orion.charities       char      6       char     40    char       10
Orion.us_suppliers    char      6       char     30    char       1   
Orion.consultants     char      6       char     30    char       8
*/
/*b, Write a DATA step to concatenate orion.charities and orion.us_suppliers,
     creating a temporary data set, contacts.*/
data work.contacts;	
	set orion.charities orion.us_suppliers;
run;
/*c, Write PROC CONTENTS step to examine work.contacts. From which
     input data set were the variable attributes assigned?*/
proc contents data=work.contacts;
run;
/* From the Orion.charities data set*/
/*d, Write a DATA step to concatenate orion.us_suppliers and orion.charities,
     creating a temporary data set, contacts2. Note that these are the same
     data sets as the previous program, but they are in reverse order.*/
data work.contacts2;	
	set orion.us_suppliers orion.charities;
run;
/*e, Submit a PROC CONTENTS step to exam work.contacts2. From which input data
     set were the variable attributes assigned.*/
proc contents data=work.contacts2;
run;
/* From the Orion.us_suppliers.
/*f, Write a DATA step to concatenate orion.us_suppliers and orion.consultants,
    creating a temporary data set, contacts3.*/
data work.contacts3;	
	set  orion.us_suppliers orion.consultants;
run;
/*The resaon of fail:Variable ContactType has been defined as both character and numeric.*/

/*Chapter 10.3*/
/*Level 2*/
/*a, Sort orion.product_list by Product_Level to create a
     new data set, work.product_list.*/
proc sort data=orion.product_list 
          out=work.product_list;
  	by Product_Level;
run;
/*b, Merge orion.product_level with the sorted data set. Create a new data set, work.listlevel,
     which includes only Product_ID, Product_Name, Product_Level, and Product_Level_Name.*/
data work.listlevel;
  	merge orion.product_level work.product_list ;
  	by Product_Level;
	keep Product_ID Product_Name Product_Level Product_Level_Name;
run;
/*c, Create the report, including only observations with Product Level equal to3.*/
proc print data=work.listlevel noobs;
	where Product_Level=3;   
run;

/*Chapter 10.4*/
/*Level 2*/
/*a, Write a PROC SORT step to sort orion.customer by Country to 
     create a new data set, work.customer.*/
proc sort data=orion.customer
          out=work.customer;
   by Country;
run;
/*b, Write a DATA step to merge the resulting data set with orion.lookup_country 
     by Country to create a new data set, work.allcustomer. In the orion.lookup_country data
     set, rename Start to Country and rename Label to Country_Name. Include only four variables:
     Customer_ID, Country, Customer_Name, and Country_Name.*/
data work.allcustomer;
	merge work.customer(in=Cust) 
         orion.lookup_country(rename=(Start=Country Label=Country_Name) in=Ctry);
	by Country;
	keep Customer_ID Country Customer_Name Country_Name;
	if Cust=1 and Ctry=1;
run;
/*Create the report, the results should contain 308 observations.*/
proc print data=work.allcustomer;
run;























