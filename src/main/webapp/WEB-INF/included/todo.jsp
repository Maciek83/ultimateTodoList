<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <c:import url="meta.jsp" charEncoding="UTF=8">
        <c:param name="title" value="Todo Mabager"/>
        <c:param name="description" value="Menage here your todos"/>
        <c:param name="keywords" value="todo,tasks"/>
    </c:import>
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<c:import url="header.jsp" charEncoding="UTF=8"/>
<form action="${pageContext.request.contextPath}/Todos" method="post">
    <fieldset>
        <legend>Insert todo information:</legend>
        <label for="info">Todo description:</label>
        <input type="text" name="description" id="info" required>
        <br/>
        <input type="submit" name="submit" value="Send">
    </fieldset>
</form>

<table>
    <tbody>
    <tr>
        <th>Id</th>
        <th>Description</th>
        <th>Is done</th>
    </tr>
    <c:forEach items="${requestScope.todoList}" var="todo">
        <tr>
            <td><c:out value="${todo.id}"/></td>
            <td><c:out value="${todo.description}"/></td>
            <td><c:out value="${todo.degree}"/></td>
            <td>
                <form action="${pageContext.request.contextPath}/Todos" method="post">
                    <input type="hidden" name="idForCheckBox" value="<c:out value="${todo.id}"/>">
                    <input type="submit" name="submit" value="<c:out value="${todo.done}"/>">
                </form>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<c:import url="footer.jsp" charEncoding="UTF=8"/>
</body>
</html>
