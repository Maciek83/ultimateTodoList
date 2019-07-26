<%@ page import="java.time.LocalDateTime" %>
<%@ taglib prefix="c" uri="http://logging.apache.org/log4j/tld/log" %>
<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" language="java" %>
<html>
<head>
    <title>Error Page</title>
</head>
<body>
<h3>Due to following reasons an error has occurred.</h3>
<% if(response.getStatus() == 500){ %>
<p style="color: red">Error: <%=exception.getMessage() %></p>
<p style="color: red">Date: <% LocalDateTime.now(); %></p>

<c:debug>
    <% exception.getClass(); %>
    <% exception.getMessage(); %>
    <% exception.getLocalizedMessage(); %>
    <% exception.getStackTrace()[0].getLineNumber();%>
</c:debug>

<%}
else {%>
<p>Hi There, error code is <%=response.getStatus() %>.</p>
<p>Please go to <a href="${pageContext.request.contextPath}/Welcome">Home Page</a></p>
<%} %>
</body>
</html>
