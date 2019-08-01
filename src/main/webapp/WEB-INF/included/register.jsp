<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <c:import url="meta.jsp" charEncoding="UTF=8">
        <c:param name="title" value="Register"/>
        <c:param name="description" value="Register"/>
        <c:param name="keywords" value="register"/>
    </c:import>
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<c:import url="header.jsp" charEncoding="UTF=8"/>

<c:set var="submit" scope="request" value="${pageContext.request.getParameter('addManager')}"/>

<jsp:useBean id="manager" scope="request" class="managers.Manager">
    <jsp:setProperty name="manager" property="email" value="${pageContext.request.getParameter('email')}"/>
    <jsp:setProperty name="manager" property="name" value="${pageContext.request.getParameter('name')}"/>
    <jsp:setProperty name="manager" property="surname" value="${pageContext.request.getParameter('surname')}"/>
</jsp:useBean>

<c:set var="isValid" scope="request" value="${pageContext.request.getAttribute('isValid')}"/>
<c:set var="emailRegistered" scope="request" value="${pageContext.request.getAttribute('emailRegistered')}"/>
<c:set var="isEmailValid" scope="request" value="${pageContext.request.getAttribute('isEmailValid')}"/>


<c:out value="${emailRegistered}"/>

<form action="${pageContext.request.contextPath}/Register" method="post">
    <fieldset>
        <legend>Insert new manager information:</legend>
        <br/>
        <label for="email">Email:</label>
        <input
                <c:if test="${!isEmailValid && submit!=null || manager.email.length() == 0 && submit!=null && !emailRegistered}">class="errorInput" </c:if>
                type="text" name="email" id="email" <c:if test="${!isValid}">value="${manager.email}"</c:if>/>
        <br/>
        <br/>
        <label for="name">Name:</label>
        <input
                <c:if test="${!isValid && submit!=null && manager.name.length() == 0}">class="errorInput" </c:if>
                type="text" name="name" id="name" <c:if test="${!isValid}">value="${manager.name}"</c:if>/>
        <br/>
        <br/>
        <label for="surname">Surname:</label>
        <input
                <c:if test="${!isValid && submit!=null && manager.surname.length() == 0}">class="errorInput" </c:if>
                type="text" name="surname" id="surname" <c:if test="${!isValid}">value="${manager.surname}"</c:if>/>
        <br/>
        <br/>

        <input class="add-button" type="submit" name="addManager" value="Create">
        <br/>

        <c:choose>
            <c:when test="${!isValid && submit != null}">
                <p class="error">Fill in the missing fields.</p>
                <c:if test="${!isEmailValid}">
                    <p class="error">Enter the correct email.</p>
                </c:if>
            </c:when>
            <c:otherwise>
                <c:choose>
                    <c:when test="${emailRegistered && submit != null}">
                        <p class="error">This email is already registered.</p>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${submit != null && !emailRegistered}">
                        <p class="success">A new account has been registered.</p>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>

    </fieldset>
</form>

<c:import url="footer.jsp" charEncoding="UTF=8"/>
</body>
</html>
