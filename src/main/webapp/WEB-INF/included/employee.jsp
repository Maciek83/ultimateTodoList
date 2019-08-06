<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <c:import url="meta.jsp" charEncoding="UTF=8">
        <c:param name="title" value="Employye Manager"/>
        <c:param name="description" value="Manage here all employees"/>
        <c:param name="keywords" value="employye"/>
    </c:import>
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<c:import url="header.jsp" charEncoding="UTF=8"/>

<c:set var="submit" scope="request" value="${pageContext.request.getParameter('addEmployee')}"/>

<jsp:useBean id="emp" scope="request" class="employees.Employee">
    <jsp:setProperty name="emp" property="name" value="${pageContext.request.getParameter('name')}"/>
    <jsp:setProperty name="emp" property="surname" value="${pageContext.request.getParameter('surname')}"/>
    <jsp:setProperty name="emp" property="level" value="${pageContext.request.getParameter('level')}"/>
</jsp:useBean>


<c:set var="isValid" scope="request" value="${emp.name.length() != 0 && emp.surname.length() != 0}"/>

<form action="${pageContext.request.contextPath}/Employee" method="post">
    <fieldset>
        <legend>Insert new employee information:</legend>
        <br/>
        <label for="name">Name:</label>
        <input
                <c:if test="${!isValid && submit!=null && emp.name.length() == 0}">class="errorInput" </c:if>
                type="text" name="name" id="name" <c:if test="${!isValid}">value="${emp.name}"</c:if>/>
        <br/>
        <br/>
        <label for="surname">Surname:</label>
        <input
                <c:if test="${!isValid && submit!=null && emp.surname.length() == 0}">class="errorInput" </c:if>
                type="text" name="surname" id="surname" <c:if test="${!isValid}">value="${emp.surname}"</c:if>/>
        <br/>
        <br/>
        <label for="level">Select skill level:</label>
        <select name="level" id="level">
            <option value="junior">Junior</option>
            <option value="mid"
                    <c:if test="${emp.level.toString().equals('mid')}">selected="selected"</c:if>>
                Mid
            </option>
            <option value="senior"
                    <c:if test="${emp.level.toString().equals('senior')}">selected="selected"</c:if>>
                Senior
            </option>
        </select>
        <br/>
        <br/>
        <input class="add-button" type="submit" name="addEmployee" value="Create">
        <br/>

        <c:choose>
            <c:when test="${!isValid && submit != null}">
                <p class="error">Fill in the missing fields.</p>
            </c:when>
            <c:otherwise>
                <c:if test="${submit != null}">
                    <p class="success">Success! You've created a new employee.</p>
                </c:if>
            </c:otherwise>
        </c:choose>

    </fieldset>
</form>

<h2 class="manager-tile">Manage employees</h2>
<div class="row">
    <div class="column">
        <p class="entry-description">Junior</p>
        <c:forEach items="${requestScope.junior}" var="emp">
            <hr class="dot-style"/>
            <span class="entry-left">${emp.name} ${emp.surname}</span>
            <form class="right-form" action="${pageContext.request.contextPath}/Employee" method="post">
                <input type="hidden" name="empId" value="${emp.employee_id}">
                <input type="hidden" name="empLevel" value="mid">
                <input class="move-button" type="submit" name="changeLevel" value="->">
            </form>
            <form class="delete-user-form" action="${pageContext.request.contextPath}/Employee" method="post">
                <input type="hidden" name="empId" value="${emp.employee_id}">
                <input class="delete-button" type="submit" name="deleteEmployee" value="DELETE">
            </form>
            <hr class="dot-style"/>
        </c:forEach>
    </div>
    <div class="column">
        <p class="entry-description">Mid</p>
        <c:forEach items="${requestScope.mid}" var="emp">
            <hr class="dot-style"/>
            <form class="left-form" action="${pageContext.request.contextPath}/Employee" method="post">
                <input type="hidden" name="empId" value="${emp.employee_id}">
                <input type="hidden" name="empLevel" value="junior">
                <input class="move-button" type="submit" name="changeLevel" value="<-">
            </form>
            <span class="entry-center">${emp.name} ${emp.surname}</span>
            <form class="right-form" action="${pageContext.request.contextPath}/Employee" method="post">
                <input type="hidden" name="empId" value="${emp.employee_id}">
                <input type="hidden" name="empLevel" value="senior">
                <input class="move-button" type="submit" name="changeLevel" value="->">
            </form>
            <br/>
            <form class="delete-user-form" action="${pageContext.request.contextPath}/Employee" method="post">
                <input type="hidden" name="empId" value="${emp.employee_id}">
                <input class="delete-button" type="submit" name="deleteEmployee" value="DELETE">
            </form>
            <hr class="dot-style"/>
        </c:forEach>
    </div>
    <div class="column">
        <p class="entry-description">Senior</p>
        <c:forEach items="${requestScope.senior}" var="emp">
            <hr class="dot-style"/>
            <form class="left-form" action="${pageContext.request.contextPath}/Employee" method="post">
                <input type="hidden" name="empId" value="${emp.employee_id}">
                <input type="hidden" name="empLevel" value="mid">
                <input class="move-button" type="submit" name="changeLevel" value="<-">
            </form>
            <span class="entry-right">${emp.name} ${emp.surname}</span>
            <br/>
            <form class="delete-user-form" action="${pageContext.request.contextPath}/Employee" method="post">
                <input type="hidden" name="empId" value="${emp.employee_id}">
                <input class="delete-button" type="submit" name="deleteEmployee" value="DELETE">
            </form>
            <hr class="dot-style"/>
        </c:forEach>
    </div>
</div>

<c:import url="footer.jsp" charEncoding="UTF=8"/>
</body>
</html>