<html><head><title>Booking Confirmation</title></head>
<body>
<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %> 

<%
	try{
	String name=request.getParameter("iname");
	String ename=request.getParameter("eventname");
	String bdate=request.getParameter("bookingdate");
	String slot=(request.getParameter("slot"));		
	HttpSession sess=request.getSession();	
	Object s=sess.getAttribute("un");
	
	Class.forName("com.mysql.jdbc.Driver");  
	Connection connection = null; 
	connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/aud", "root", "");	
	Statement st= connection.createStatement();		
	
	String q="select * from `booking` where `bookingDate`='"+bdate+"' and `slot`="+slot+"";	
	ResultSet rs= st.executeQuery(q);
	int x=0;
	while(rs.next())
	{
		x=1; break;
	}
if(x==1)	
{
	response.sendRedirect("booking.jsp?a=1");
}
else
{String query="INSERT INTO `booking`(`iname`, `eventName`, `bookingDate`,`personname`, `slot`) VALUES ('"+name+"','"+ename+"','"+bdate+"','"+s+"',"+slot+")";
int a= st.executeUpdate(query);	
%>
<div align="center"><b>BOOKING SUCCESSFULL</b></div>
<%
response.sendRedirect("booking.jsp?a=2");}
}catch(Exception e){out.println(e);}  
%>
</body>
</html>