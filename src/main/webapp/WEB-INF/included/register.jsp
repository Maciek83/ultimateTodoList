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

<c:set var="isNameOk" scope="request" value="${pageContext.request.getAttribute('isNameOk')}"/>
<c:set var="isSurnameOk" scope="request" value="${pageContext.request.getAttribute('isSurnameOk')}"/>
<c:set var="managerAdded" scope="request" value="${pageContext.request.getAttribute('managerAdded')}"/>
<c:set var="isEmailValid" scope="request" value="${pageContext.request.getAttribute('isEmailValid')}"/>
<c:set var="isPasswordOk" scope="request" value="${pageContext.request.getAttribute('isPasswordOk')}"/>

<form class="big-form" action="${pageContext.request.contextPath}/Register" method="post">
    <fieldset>
        <legend>Insert new manager information</legend>
        <br/>
        <label for="email">Email:</label>
        <input
                <c:if test="${submit != null && !isEmailValid && !managerAdded}">class="errorInput" </c:if>
                type="text" name="email" id="email" <c:if test="${submit != null && !managerAdded}">value="${manager.email}"</c:if>/>
        <br/>
        <br/>
        <label for="password">Password:</label>
        <input
                <c:if test="${!isPasswordOk && submit!=null}">class="errorInput" </c:if>
                type="password" name="password" id="password" />
        <br/>
        <br/>
        <label for="passwordCheck">Password retype:</label>
        <input
                <c:if test="${!isPasswordOk && submit!=null}">class="errorInput" </c:if>
                type="password" name="passwordCheck" id="passwordCheck" />
        <br/>
        <br/>
        <label for="name">Name:</label>
        <input
                <c:if test="${manager.name.length() == 0 && submit!=null}">class="errorInput" </c:if>
                type="text" name="name" id="name" <c:if test="${!isNameOk || !managerAdded}">value="${manager.name}"</c:if>/>
        <br/>
        <br/>
        <label for="surname">Surname:</label>
        <input
                <c:if test="${manager.surname.length() == 0 && submit!=null}">class="errorInput" </c:if>
                type="text" name="surname" id="surname" <c:if test="${!isSurnameOk || !managerAdded}">value="${manager.surname}"</c:if>/>
        <br/>
        <br/>

        <input type="submit" name="addManager" value="Create">
        <br/>

        <c:choose>
            <c:when test="${!isNameOk && !isSurnameOk && submit != null}">
                <p class="error">Fill in the missing fields.</p>
                <c:if test="${!isEmailValid}">
                    <p class="error">Enter correct email.</p>
                </c:if>
                <c:if test="${!isPasswordOk}">
                    <p class="error">Passwords do not match.</p>
                </c:if>
            </c:when>
            <c:otherwise>
                <c:choose>
                    <c:when test="${!managerAdded && submit != null}">
                        <p class="error">This email is already registered.</p>
                    </c:when>
                    <c:otherwise>
                        <c:if test="${submit != null && managerAdded}">
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
