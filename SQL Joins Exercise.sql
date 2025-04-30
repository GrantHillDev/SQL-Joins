/* joins: select all the computers from the products table:
using the products table and the categories table, return the product name and the category name */
SELECT P. NAME as ProductName, C.NAME AS CategoryName -- ProductName is the alias for P.Name, and CategoryName is the alias for C.Name. Could also be written out as Products.Name and Categories.Name.
FROM products AS P -- P is the alias for products
INNER JOIN  categories as C -- C is the alias for categories
ON C. CategoryID = P.CategoryID
WHERE C.NAME = 'Computers'; -- LEFT JOIN doesn't exclude as much data.

/* SELECT products.NAME, categories.NAME
FROM products -- INNER JOIN can be thought of as a visual unity between two different tables.... in this case; between the category table and the product table. LEFT JOIN would only join a table that wasn't necessarily overlapping (if you could visually imagine the tables as circles that partially overlap with each other, and that overlapped space would represent the INNER region, whereas if products was the table located to the left of the category table [same visualization], then the LEFT JOIN command would also work, and we're then querying all of that data.
INNER JOIN categories on categories.CategoryID = products.CategoryID -- we use the INNER command when we know that every product is going to have a category. LEFT is less exclusive than INNER, in this context.
WHERE categories.Name = 'Computers'; */ -- this is a sample of the above written code block, but without the use of aliases.

/* joins: find all product names, product prices, and products ratings that have a rating of 5 */
SELECT products.NAME, products.Price, reviews.Rating -- these represent the columns we'll be getting back. Right now, we don't want any products that haven't been reviewed.
FROM products -- I'm thinking that the product table would be the one located visually on the left per the LEFT command because we're utilizing the FROM command per the product table and the reviews table is being JOINED which I'm guessing means it would visually be the table joining in the products table from the right.
INNER JOIN reviews ON reviews.ProductID = products.ProductID -- what do the reviews and product tables have in common? a product ID, so that's the column we want returned here.... which should ideally give us only the products which have been reviewed.
WHERE reviews.rating = 5;

-- SELECT * Still don't know what this actually does. Never mind, I just figured it out.... seems to be a useful way to display more than one table at the same time in the result grid, but you still to have to specify which tables you're selecting within that same block of code. It's like a select all command.

/* joins: find the employee with the most total quantity sold.  use the sum() function and group by */
-- What are my tables? How Do I join them? This is the thought process when crafting your code here.
SELECT e.FirstName, e.LastName, Sum(s.Quantity) AS Total -- if code isn't running after compile time, especially if it's not necessarily selected, chances are that it has encountered a run time error but SQL won't tell you this explicitly unless you hgihlight and slect that chunk code you wish to test or run.
FROM sales AS s -- you can join more than one table.... you could join 2 more tables if you wanted to.
INNER JOIN employees AS e ON e.EmployeeID = s.EmployeeID -- need to utilize join command here because we need to figure out the employees who not only made sales, but made the most amount of sales.
GROUP BY e.EmployeeID -- keeps the data organized by each individual employee.... we don't need to conduct the sum sold by all of the employees. Does EmployeeID contain information for each employee's first name and last name?
ORDER BY Total DESC -- this works well here for what was initially asked, but we can take it a step further by way of utilizing a limit command to specify the top sales contenders based just on this list we've generated.
LIMIT 2; -- displays the top 2 contenders of employees who sold the most product.

/* joins: find the name of the department, and the name of the category for Appliances and Games */
SELECT d.NAME AS 'Department Name', c.NAME AS 'Category Name' FROM departments as d -- get into the habit of looking for commonalities between differing tables.... because this how they will be joined. For instance, the product, reveiws, and sales tables all have the ProductID factor in common, and they could be joined by utilziing it.
INNER JOIN  categories AS c ON c.DepartmentID
WHERE c.NAME = 'Appliances' OR c.NAME = 'Games';
 
/* joins: find the product name, total # sold, and total price sold,
 for Eagles: Hotel California --You may need to use SUM() */
 SELECT p.NAME, sum(s.Quantity) AS 'Total Sold', Sum(s.Quantity * s.PricePerUNit) as 'Total Price'
 FROM products AS p
 INNER JOIN sales AS s ON s.ProductId = p.ProductID
 WHERE p.ProductID = 97;
 -- To verfiy
 SELECT * FROM sales WHERE ProductID = 97;
 
/* joins: find Product name, reviewer name, rating, and comment on the Visio TV. (only return for the lowest rating!) */
SELECT p.NAME, r.Reviewer, MIN(r.Rating)
FROM products AS p
INNER JOIN reviews AS r ON r.ProductID = p.ProductID
WHERE P.ProductID = 857;

-- ------------------------------------------ Extra - May be difficult
/* Your goal is to write a query that serves as an employee sales report.
This query should return:
-  the employeeID
-  the employee's first and last name
-  the name of each product
-  and how many of that product they sold */
SELECT e.FirstName, e.LastName, e.EmployeeID, p.NAME, sum(s.Quantity) AS TotalSold
FROM Sales AS s
INNER JOIN employees AS e ON e.EmployeeID = s.EmployeeID -- Sales acts as the starting table here, denoted by the FROM command, aliased as s. Next, we join the employees table to the sales table, aliased as e, but notice how the employees table doesn't have a commonality with either the sales or products tables.... so we assign an employee ID to each member of the employees tables being joined to the sales table, perhaps because it's a more generally standard method of identifying the members of the table itself, in this context. Lastly, we add the products table with it being aliased as p.
INNER JOIN products AS p ON p.ProductId = s.ProductID
GROUP BY e.EmployeeID, p.ProductID -- I didn't see the product ID pop up in the results grid for this.
ORDER BY TotalSold DESC;