<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <c:import url="WEB-INF/included/meta.jsp" charEncoding="UTF=8">
        <c:param name="title" value="Home page"/>
        <c:param name="description" value="Ultimate Todos"/>
        <c:param name="keywords" value="todo,tasks"/>
    </c:import>
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<c:import url="WEB-INF/included/header.jsp" charEncoding="UTF=8"/>
<div class="app-info">
<h3>Welcome to task manager</h3>
    <a href="https://github.com/Maciek83/ultimateTodoList" target="_blank">Link to the github repository</a>
<p>Application allows you to create tasks that can contain in themselves smaller tasks (Todo).
    Each Todo may contain list of employees who are currently working on it.
</p>
<p>From database side the application works as follows:</p>
<ul>
    <li>Each <strong>Manager</strong> has a one-to-many relationship with <strong>Task</strong> and
        <strong>Todo</strong> and <strong>Employee</strong>.
    </li>
    <li>Each <strong>Task</strong> has a one-to many relationship with <strong>Todo</strong>
        and many-to-one relationship with <strong>Manager</strong>.
    </li>
    <li>
        Each <strong>Todo</strong> has a many-to-one relationship with <strong>Task</strong>
        and <strong>Manager</strong> and many-to-many relationship with <strong>Employee</strong>.
    </li>
    <li>
        Each <strong>Employee</strong> has a many-to-one relationship with <strong>Manager</strong>
         and many-to-many relationship with <strong>Todo</strong>.
    </li>
</ul>
</div>

<c:import url="WEB-INF/included/footer.jsp" charEncoding="UTF=8"/>
</body>
</html>