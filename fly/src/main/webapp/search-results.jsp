<%@page import="java.sql.*"%>
<%@ page import="model.Search" %>
<%
    String driverName = "com.mysql.jdbc.Driver";
    String connectionUrl = "jdbc:mysql://flyawaydb.cyp0rsmjgi5q.ap-south-1.rds.amazonaws.com:3306/";
    String dbName = "flyaway";
    String userId = "root";
    String password = "adminadmin";
    String query = Search.getQuery();
    try {
        Class.forName(driverName);
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;
%>

<!DOCTYPE html>
<html>
<head>
    
    <title>Search Results - FlyAway Airlines</title>
   
</head>

<body>
<div class="w3-bar w3-white w3-card" id="myNavbar">
    <a href="/fly/index.jsp" class="w3-bar-item w3-button w3-wide">  FlyAway</a>
    <div class="w3-right w3-hide-small">
        <a href="/fly/login.jsp" class="w3-bar-item w3-button"><i class="fa fa-gear"></i> Admin Login</a>
    </div>
</div>
<div class="container">
    <h2 align="center"><span><strong>Search Results</strong></span></h2>
    <p align="center"><span><strong>
        Showing available flights from <%=Search.source%> to  <%=Search.destination%> <br>
        Date of travel : <%=Search.date%> (<%=Search.day%>)  <br>
        No of travellers :  <%=Search.persons%>  <br>
    </p>
    <table class="table table-hover table-striped">
        <thead>
        <tr>
            <th scope="col">Flight</th>
            <th scope="col">Source</th>
            <th scope="col">Destination</th>
            <th scope="col">Date</th>
            <th scope="col">Ticket Price</th>
            <th scope="col">Select</th>
        </tr>
        </thead>
        <tbody>
        <br><p align="center"><span><strong>Select a flight</strong></span></p><br>
        <%
            try{
                connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
                statement=connection.createStatement();
                resultSet = statement.executeQuery(query);
                while(resultSet.next()){
        %>
        <tr bgcolor="#F5F5F5">
            <td><%=resultSet.getString("name") %></td>
            <td><%=resultSet.getString("source") %></td>
            <td><%=resultSet.getString("destination") %></td>
            <td><%=Search.date%></td>
            <td><%=resultSet.getString("ticket_price") %></td>
            <td>
                <form action="${pageContext.request.contextPath}/booking-details.jsp" method="post">
                    <input type="hidden" id="name" name="name" value="<%=resultSet.getString("name")%>">
                    <input type="hidden" id="ticket_price" name="ticket_price" value="<%=resultSet.getString("ticket_price")%>">
                    <input type="hidden" id="flight_id" name="flight_id" value="<%=resultSet.getString("flight_id")%>">
                    <input type="submit" class="btn btn-success mb-2 btn-block" value="Book This Flight">
                    
                </form>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
        </tbody>
    </table>
</div>
<div class="footer" align="center">
    FlyAway by Anil Kumar
</div>
</body>
</html>