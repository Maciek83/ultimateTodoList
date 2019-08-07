<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <c:import url="meta.jsp" charEncoding="UTF=8">
        <c:param name="title" value="Tasks Manager"/>
        <c:param name="description" value="Manage here all tasks"/>
        <c:param name="keywords" value="task"/>
    </c:import>
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css"/>
</head>
<body>

<c:set var="submitTask" scope="request" value="${pageContext.request.getParameter('addTask')}"/>
<c:set var="submitTodo" scope="request" value="${pageContext.request.getParameter('addTodo')}"/>

<jsp:useBean id="taskTest" class="tasks.Task" scope="request">
    <jsp:setProperty name="taskTest" property="name" value="${pageContext.request.getParameter('name').trim()}"/>
    <jsp:setProperty name="taskTest" property="description"
                     value="${pageContext.request.getParameter('description').trim()}"/>
</jsp:useBean>

<c:set var="isFormValid" scope="request"
       value="${taskTest.name.trim().length() != 0 && taskTest.description.trim().length() != 0 && submit != null}"/>

<c:import url="header.jsp" charEncoding="UTF=8"/>

<form action="${pageContext.request.contextPath}/Tasks" method="post">
    <fieldset>
        <legend>Insert new task information.</legend>
        <br/>
        <label for="name">Name:</label>
        <input
        <c:if test="${taskTest.name.trim().length() == 0 && submitTask != null}"> class="errorInput" </c:if>
        <c:if test="${!isFormValid}"> value="${taskTest.name}"</c:if> type="text" id="name" name="name">
        <br/>
        <br/>
        <label for="description">Description:</label>
        <input
        <c:if test="${taskTest.description.trim().length() == 0 && submitTask != null}"> class="errorInput" </c:if>
        <c:if test="${!isFormValid}"> value="${taskTest.description}"</c:if> type="text" id="description"
                                                                                     name="description">
        <br/>
        <br/>
        <input class="add-button" type="submit" name="addTask" value="Create">

        <c:choose>
            <c:when test="${!isFormValid && submitTask != null}">
                <p class="error">Fill in the missing fields.</p>
            </c:when>
            <c:otherwise>
                <c:if test="${submitTask != null}">
                    <p class="success">Success! You've created a new task.</p>
                </c:if>
            </c:otherwise>
        </c:choose>

    </fieldset>
</form>

<c:forEach items="${requestScope.allTasks}" var="task">
    <form action="${pageContext.request.contextPath}/Tasks" method="post">
        <input value="${task.task_id}" type="hidden" name="taskID">
        <input class="add-button" type="submit" name="flipTask" value="
<c:choose>
<c:when test="${!task.done}">
Undone
</c:when>
<c:otherwise>
Done
</c:otherwise>
</c:choose>"></form>
    <c:if test="${task.done}">
        <form action="${pageContext.request.contextPath}/Tasks" method="post">
            <input value="${task.task_id}" type="hidden" name="taskID">
            <input class="delete-button" type="submit" name="deleteTask" value="Delete Task">
        </form>
    </c:if>
    <p>Name: <c:out value="${task.name}"/></p>
    <p>Description: <c:out value="${task.description}"/></p>
    <span>Add new Todo: </span>
    <form action="${pageContext.request.contextPath}/Tasks" method="post">
        <input value="${task.task_id}" type="hidden" name="taskID">
        <label for="descriptionTodo">Description:</label>
        <input type="text" id="descriptionTodo" name="descriptionTodo">
        <label for="degree">Select entry skill level:</label>
        <select name="degree" id="degree">
            <option value="junior">Junior</option>
            <option value="mid">Mid</option>
            <option value="senior">Senior</option>
        </select>
        <input class="add-button" type="submit" name="addTodo" value="Create">
        <c:if test="${submitTodo != null && pageContext.request.getParameter('descriptionTodo').length() == 0}">
            <p class="error">Insert to do description.</p>
        </c:if>
    </form>
    <c:forEach items="${task.todos}" var="todo">
        <p>Name of Todo <c:out value="${todo.description}"/></p>
        <form action="${pageContext.request.contextPath}/Tasks" method="post">
            <input value="${todo.todo_id}" type="hidden" name="todoID">
            <input class="add-button" type="submit" name="flipTodo" value="
<c:choose>
<c:when test="${!todo.done}">
Undone
</c:when>
<c:otherwise>
Done
</c:otherwise>
</c:choose>">
        </form>
        <c:if test="${todo.done}">
            <form action="${pageContext.request.contextPath}/Tasks" method="post">
                <input value="${todo.todo_id}" type="hidden" name="todoId">
                <input class="delete-button" type="submit" name="deleteTodo" value="deleteTodo">
            </form>
        </c:if>
        <c:if test="${!(requestScope.allEmployee.size() == todo.employees.size())}">
        <form action="${pageContext.request.contextPath}/Tasks" method="post">
            <input value="${todo.todo_id}" type="hidden" name="todoId">
            <label for="employee">Add employee:</label>
            <select name="employee" id="employee">
                <c:forEach items="${requestScope.allEmployee}" var="emp">
                    <c:if test="${!todo.employees.contains(emp) && emp.getLevel().ordinal() >= todo.getDegree().ordinal()}">
                        <option value="${emp.employee_id}"><c:out value="${emp.name} ${emp.surname}"/></option>
                    </c:if>
                </c:forEach>
            </select>
            <input class="add-button" type="submit" name="addEmployee" value="addEmployee">
        </form>
        </c:if>
        <c:forEach items="${todo.employees}" var="emp">
            <span>${emp.name} ${emp.surname} Current position: ${emp.level}</span>
            <form action="${pageContext.request.contextPath}/Tasks" method="post">
                <input value="${todo.todo_id}" type="hidden" name="todoId">
                <input value="${emp.employee_id}" type="hidden" name="empId">
                <input class="delete-button" type="submit" name="deleteFormDoTo" value="Delete from this todo">
            </form>
        </c:forEach>
    </c:forEach>
</c:forEach>

<c:import url="footer.jsp" charEncoding="UTF=8"/>
</body>
</html>
