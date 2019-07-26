<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<c:forEach items="${requestScope.stringi}" var="s">
    <br>
    <c:out value="${s}"></c:out>
    <br>
</c:forEach>

</body>
</html>
