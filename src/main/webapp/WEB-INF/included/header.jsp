<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header>
    <nav>
        <ul>
            <li><a href="${pageContext.request.contextPath}/Welcome">Home</a></li>
            <c:choose>
                <c:when test="${pageContext.session.getAttribute('loggedManager') != null}">
                    <li><a href="${pageContext.request.contextPath}/Todos">Manage Todos</a></li>
                    <li><a href="${pageContext.request.contextPath}/Employee">Manage Employee</a></li>
                    <li><a href="${pageContext.request.contextPath}/Logout">Logout</a></li>
                    <li>Welcome ${pageContext.session.getAttribute("loggedManager").name}</li>
                </c:when>
                <c:otherwise>
                    <li><a href="${pageContext.request.contextPath}/Register">Register</a></li>
                    <li><a href="${pageContext.request.contextPath}/Login">Login</a></li></c:otherwise>
            </c:choose>
        </ul>
    </nav>
</header>