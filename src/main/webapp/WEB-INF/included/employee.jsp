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

<c:set var="error" scope="request" value="${requestScope.error}"/>

<form action="${pageContext.request.contextPath}/Employee" method="post">
    <fieldset>
        <legend>Insert new employee information:</legend>
        <label for="name">Name:</label>
        <input type="text" name="name" id="name"
                <c:if test="${error == true}">
                    value="${pageContext.request.getParameter("name")}"
                </c:if>
        />
        <br/>
        <label for="surname">Surname:</label>
        <input type="text" name="surname" id="surname"
                <c:if test="${error == true}">
                    value="${pageContext.request.getParameter("surname")}"
                </c:if>
        />
        <br/>
        <label for="level">Select skill level:</label>
        <select name="level" id="level">
            <option value="junior">Junior</option>
            <option value="mid"
                    <c:if test="${pageContext.request.getParameter('level').equals('mid')}">selected="selected"</c:if>>
                Mid
            </option>
            <option value="senior"
                    <c:if test="${pageContext.request.getParameter('level').equals('senior')}">selected="selected"</c:if>>
                Senior
            </option>
        </select>
        <br/>
        <input type="submit" name="addEmployee" value="Send">
        <br/>

        <c:set var="submit" scope="request" value="${pageContext.request.getParameter('addEmployee')}"/>

        <c:choose>
            <c:when test="${error == true}">
                Check form again.
            </c:when>
            <c:otherwise>
                <c:if test="${submit != null && error == false}">
                    Success!
                </c:if>
            </c:otherwise>
        </c:choose>
    </fieldset>
</form>


<%--<table>--%>
<%--    <tbody>--%>
<%--    <tr>--%>
<%--        <th>Id</th>--%>
<%--        <th>Description</th>--%>
<%--        <th>Is done</th>--%>
<%--    </tr>--%>
<%--    <c:forEach items="${requestScope.todoList}" var="todo">--%>
<%--        <tr>--%>
<%--            <td><c:out value="${todo.id}"/></td>--%>
<%--            <td><c:out value="${todo.description}"/></td>--%>
<%--            <td><c:out value="${todo.degree}"/></td>--%>
<%--            <td>--%>
<%--                <form action="${pageContext.request.contextPath}/Todos" method="post">--%>
<%--                    <input type="hidden" name="idForCheckBox" value="<c:out value="${todo.id}"/>">--%>
<%--                    <input type="submit" name="submit" value="<c:out value="${todo.done}"/>">--%>
<%--                </form>--%>
<%--            </td>--%>
<%--        </tr>--%>
<%--    </c:forEach>--%>
<%--    </tbody>--%>
<%--</table>--%>

<c:import url="footer.jsp" charEncoding="UTF=8"/>
</body>
</html>