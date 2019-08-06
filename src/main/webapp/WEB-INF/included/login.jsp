<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <c:import url="meta.jsp" charEncoding="UTF=8">
        <c:param name="title" value="Login"/>
        <c:param name="description" value="Login"/>
        <c:param name="keywords" value="login"/>
    </c:import>
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<c:import url="header.jsp" charEncoding="UTF=8"/>
<c:set var="submit" scope="request" value="${pageContext.request.getParameter('login')}"/>
<c:set var="isEmailFieldValid" scope="request" value="${pageContext.request.getParameter('email').trim().length() != 0}"/>
<c:set var="isPasswordFieldValid" scope="request" value="${pageContext.request.getParameter('password').trim().length() != 0}"/>


<form action="${pageContext.request.contextPath}/Login" method="post">
    <fieldset>
        <legend>Insert login information:</legend>
        <br/>
        <label for="email">Email:</label>
        <input
                <c:if test="${(!isEmailFieldValid || pageContext.session.getAttribute('loggedManager') == null) && submit != null}">class="errorInput" </c:if>
                type="text" name="email" id="email"/>
        <br/>
        <br/>
        <label for="password">Password:</label>
        <input
                <c:if test="${(!isPasswordFieldValid || pageContext.session.getAttribute('loggedManager') == null) && submit != null}">class="errorInput" </c:if>
                type="password" name="password" id="password" />
        <br/>
        <br/>
        <input class="add-button" type="submit" name="login" value="Login">
        <br/>


        <c:choose>
            <c:when test="${(!isEmailFieldValid || !isPasswordFieldValid) && submit != null}">
                <p class="error">Fill in the missing fields.</p>
            </c:when>
            <c:otherwise>
                <c:if test="${pageContext.session.getAttribute('loggedManager') == null && submit != null}">
                    <p class="error">The password or login is incorrect.</p>
                </c:if>
                <c:if test="${pageContext.session.getAttribute('loggedManager') != null && submit != null}">
                    <c:redirect url="/Welcome"/>
                    <p class="success">Logged in. Welcome ${pageContext.session.getAttribute("loggedManager").name}</p>
                </c:if>
            </c:otherwise>
        </c:choose>
    </fieldset>
</form>

<c:import url="footer.jsp" charEncoding="UTF=8"/>
</body>
</html>
