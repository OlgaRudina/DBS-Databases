DBS201

Lab2: Database and Table Creation

- become familiar with the signing on process for the i-Series
- create a collection
- create tables for a collection using SQL
- compare Schemas Libraries and Collections

---------------------------------------------------------------------------------------------------------------------

Lab3: Constraints

1. FOREIGN KEY CONSTRAINT: 
          a.	How To Establish 1:M relationships between tables using Foreign Keys. 
          b.	The Syntax of the command to identify the Foreign Key.
          c.	How the database preserves referential integrity using Foreign Keys.
2. UNIQUE CONSTRAINT: 
          a.	How to Add a UNIQUE constraint.
3. CHECK CONSTRAINT:  
          a.	How to Add a CHECK constraint
4. How to test if our constraints are working.
5. How to print out information on Table/File Constraints 

---------------------------------------------------------------------------------------------------------------------

Lab4: JOINS and VIEWS

1. use a JOIN for reports that needs data from more than 1 table.
2. create a VIEW
	- a VIEW contains no data
	- the VIEW appears to the user as a table.
        - the VIEW runs a “SELECT” to create a temporary table.
	- the user can use this temporary table to produce reports or anything else that a table can be used for.
3. copy data from one table to another.
4.  use calculated fields that are derived from two or more attributes

---------------------------------------------------------------------------------------------------------------------

Lab5: Changing a VIEW /  Default Values / Permissions

1. ALTER a VIEW
2. Distinguish the options for a column. Not Null With Default, Not Null, a different default than the natural one 
for data type or nothing specified.
3. Use information from physical design documents to implement tables
4. Grant Permissions giving other users access to your database.     

---------------------------------------------------------------------------------------------------------------------

Lab6: More on Referential Constraints

1. Use the RUNSQLSTM statement at the command line to execute a number of DDL SQL statements.
2. Experience the differences between a referential constraint that uses one of three options:  
	ON DELETE RESTRICT
	ON DELETE CASCADE
	ON DELETE SET DEFAULT       

---------------------------------------------------------------------------------------------------------------------

Lab7: ERD for the Lakeside Soccer League

Teams at any time may have no players enrolled or one or more players enrolled. Players are only allowed to play 
for one team.  For a player to be accepted into the league, there must be one or more guardians for that player. 
Guardians may be responsible for one or more players. Coaches can be in charge of one or more teams and teams may 
have more than one coach. Some of the older teams can play in the league without using a coach. 
A sponsor may sponsor one or more teams, but teams are allowed only one sponsor. Sponsors who are not associated with
any teams are not included in the season. A team may not have a sponsor before the season begins and the league will
be the sponsor of some of those teams and drop others.
Player team data – registration number, personal info (name, birth date) shirt number and team number.
Determine the data to be stored for all other entities.

---------------------------------------------------------------------------------------------------------------------

Lab8: Normalization

1. Create the Unnormalized Form (UNF) relation from a user view
2. Identify a Multi-valued Dependency (a.k.a. Repeating Group )
3. Create the First Normal Form (1NF) relation from the UNF.

---------------------------------------------------------------------------------------------------------------------

Lab9: 1NF, 2NF, 3NF

1. Continue the normalization of user views from 1NF to 2NF and 3NF
2. How to identify and remove partial dependencies
3. How to identify and remove transitive dependencies

---------------------------------------------------------------------------------------------------------------------

FinalProject: Normalization of CanAmazing.com User Views

1) UNF relation including the Primary Key and Multi-Valued Dependencies.
2) Convert the UNF to 1st Normal Form and print the 1st Normal Form.
3) Convert the 1st Normal Form to 2nd Normal Form and print the 2nd Normal Form
4) Convert the 2nd Normal Form to 3rd Normal Form and print the 3rd Normal Form
5) Simplify primary keys wherever possible and print any relations that changed. 
6) Name the relations (tables) and print the recommended tables from the User View.

---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------

DBS301: All descriptions are inside the files