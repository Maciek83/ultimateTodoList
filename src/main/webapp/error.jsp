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
<p class="error">Error: <%=exception.getMessage() %></p>
<p class="error">Class: <%=exception.getClass().toString() %></p>
<p class="error">Localization: <%=exception.getLocalizedMessage() %></p>
<p class="error">Line: <%=exception.getStackTrace()[0].getLineNumber() %></p>
<p class="error">Date: <%=LocalDateTime.now() %></p>

<c:setLogger logger="standard">

</c:setLogger>
<% String msg = exception.getClass().toString() +
        exception.getMessage() +
        exception.getLocalizedMessage() +
        exception.getStackTrace()[0].getLineNumber();
%>
<c:debug>
    <%= msg %>
</c:debug>

<%}
else {%>
<p>Hi There, error code is <%=response.getStatus() %>.</p>
<p>Please go to <a href="${pageContext.request.contextPath}/Welcome">Home Page</a></p>
<%} %>
</body>
</html>
