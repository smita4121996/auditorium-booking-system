<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.*"%>
<%@page import="java.servlet.*"%>
<%@page import="java.servlet.http.*"%>
<%

Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>
<html>
<title>
BOOKING
</title>
<head>
  <style>
  .header {
    background-color: #F1F1F1;
    text-align: center;
    padding: 20px;
}

div.topnav {
    overflow: hidden;
    background-color: #333;
}

/* Navbar links */
.topnav a {
    float: left;
    display: block;
    color: #f2f2f2;
    text-align: center;
    padding: 14px 16px;
    text-decoration: none;
}

/* Links - change color on hover */
.topnav a:hover {
    background-color: #ddd;
    color: black;
  </style>
  
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<div class="header">
<center> <header > <h1>Online Auditorium Booking </h1> </header>
<div align="right"><input type=button value="Logout" onclick="location.href='killsession.jsp';"></div>
</div>
<%
	HttpSession sess=request.getSession();	
	Object s=sess.getAttribute("un");
	if(s==null)
	{
		response.sendRedirect("index.html");
	}
	else{
	out.print("<b>Welocome "+s+"</b>");}
%>	
<div class="topnav" >
<h3><a href="killsession.jsp"> HOME <br></a></h3>
<h3><a href="booking.jsp?a=2"> MY BOOKINGS<br></a></h3>
<h3><a href="abouts.html"> ABOUT US <br></a></h3>
<h3><a href="cc.html"> CONTACT US<br> </a></h3>
</div>
<body>
<style>
body {font-family: Arial, Helvetica, sans-serif;}
* {box-sizing: border-box}

/* Full-width input fields */
input[type=text], input[type=password] {
    width: 100%;
    padding: 15px;
    margin: 5px 0 22px 0;
    display: inline-block;
    border: none;
    background: #f1f1f1;
}

input[type=text]:focus, input[type=password]:focus {
    background-color: #ddd;
    outline: none;
}

hr {
    border: 1px solid #f1f1f1;
    margin-bottom: 25px;
}

/* Set a style for all buttons */
button {
    background-color: #4CAF50;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    cursor: pointer;
    width: 100%;
    opacity: 0.9;
}

button:hover {
    opacity:1;
}

/* Extra styles for the cancel button */
.cancelbtn {
    padding: 14px 20px;
    background-color: #f44336;
}

/* Float cancel and signup buttons and add an equal width */
.cancelbtn, .signupbtn {
  float: left;
  width: 50%;
}

/* Add padding to container elements */
.container {
    padding: 16px;
}

/* Clear floats */
.clearfix::after {
    content: "";
    clear: both;
    display: table;
}

/* Change styles for cancel button and signup button on extra small screens */
@media screen and (max-width: 300px) {
    .cancelbtn, .signupbtn {
       width: 100%;
    }
}
</style>

<body>
<%
String a=request.getParameter("a");
if(a!=null)
{
	if(a.equals("2"))
	{%>
<br><br><div align="center">
<table border="1">
<tr>
<td><b>BOOKING ID</b></td>
<td><b>EVENT INCHARGE NAME</b></td>
<td><b>EVENT NAME</b></td>
<td><b>BOOKING DATE</b></td>
<td><b>PERSON NAME</b></td>
<td><b>BOOKING SLOT</b></td>
</tr>
<%
try{
connection  = DriverManager.getConnection("jdbc:mysql://localhost:3306/aud", "root", "");
statement=connection.createStatement();
String sql ="SELECT * FROM `booking` where personname='"+s.toString()+"'";
resultSet = statement.executeQuery(sql);
while(resultSet.next()){
%>
<tr>
<td><%=resultSet.getString("bID") %></td>
<td><%=resultSet.getString("iname") %></td>
<td><%=resultSet.getString("eventName")%></td>
<td><%=resultSet.getString("bookingDate") %></td>
<td><%=resultSet.getString("personname") %></td>
<%
	String sl=resultSet.getString("slot");
	if(sl.equals("1"))
	{%><td>MORNING SESSION(9AM-2PM)</td><%}
		else if(sl.equals("2"))
		{%><td>AFTERNOON SESSION(3PM-8PM)</td><%}
			else if(sl.equals("3"))
			{%><td>WHOLE DAY(9AM-8PM)</td><%}
%>
</tr>
<%
}
connection.close();
} catch (Exception e) {
out.print(e.getMessage());
}
%>
</table>
</div>
<%}
else if(a.equals("1"))
{
	%><p><b>Oops Auditorium has been already booked for this date and slot!</b></p><%
}
}
else
{
%>
<form action="confirmBooking.jsp" style="border:1px solid #ccc" method="post">
  <div class="container">
    <h1>Sign Up</h1>
    <p><b> FILL THIS FORM TO BOOK AUDITORIUM </b></p>
    <hr>
	
	  <label for="nm"><b>EVENT INCHARGE</b></label>
    <input type="text" placeholder="EVENT INCHARGE NAME" name="iname" required>
	
	 	
	<label for="nm"><b>NAME OF EVENT</b></label>
    <input type="text" placeholder="NAME OF EVENT" name="eventname" required> <br>
	
	<label for="nm"><b>DATE</b></label>
    <input type="date" name="bookingdate" required> <br><br>
		  	
	  <br>
	  <label for="number"><b>CHOOSE TIME SLOT</b></label> 
		<select name="slot" required>						
   						<option value="1">MORNING SESSION(9AM-2PM)</option>
						<option value="2">AFTERNOON SESSION(3PM-8PM)</option>   						
						<option value="3">WHOLE DAY(9AM-8PM)</option>
 				 </select><br><br>
    <div class="clearfix">
      <button type="reset" class="cancelbtn">CANCEL</button>
      <button type="submit" class="signupbtn">SUBMIT</button>
    </div>
  </div>
<%}%>
</form>

</body>




</html>


