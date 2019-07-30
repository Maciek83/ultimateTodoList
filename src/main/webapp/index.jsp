<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<c:import url="WEB-INF/included/meta.jsp" charEncoding="UTF=8">
    <c:param name="title" value="Home page"/>
    <c:param name="description" value="Ultimate Todos"/>
    <c:param name="keywords" value="todo,tasks"/>
</c:import>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
<c:import url="WEB-INF/included/header.jsp" charEncoding="UTF=8"/>
<div>Ultimate to do list.</div>
<c:import url="WEB-INF/included/footer.jsp" charEncoding="UTF=8"/>
</body>
</html>