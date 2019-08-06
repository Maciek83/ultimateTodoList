<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <c:import url="meta.jsp" charEncoding="UTF=8">
        <c:param name="title" value="Logout"/>
        <c:param name="description" value="Logout"/>
        <c:param name="keywords" value="logout"/>
    </c:import>
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<c:import url="header.jsp" charEncoding="UTF=8"/>
<p class="success">You are logged out.</p>
<c:import url="footer.jsp" charEncoding="UTF=8"/>
</body>
</html>
