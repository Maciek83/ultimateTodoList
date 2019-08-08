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
       value="${taskTest.name.trim().length() != 0 && taskTest.description.trim().length() != 0 && submitTask != null}"/>


<c:import url="header.jsp" charEncoding="UTF=8"/>

<%--add task form start--%>
<form class="big-form" action="${pageContext.request.contextPath}/Tasks" method="post">
    <fieldset>
        <legend>Insert new task information</legend>

        <label for="name">Name:</label>

        <input
        <c:if test="${taskTest.name.trim().length() == 0 && submitTask != null}"> class="errorInput" </c:if>
        <c:if test="${!isFormValid}"> value="${taskTest.name}"</c:if>
                                                                                  type="text"
                                                                                  id="name"
                                                                                  placeholder="Enter task name"
                                                                                  maxlength="225"
                                                                                  name="name">

        <br/>
        <br/>
        <label for="description">Description:</label>

        <input
        <c:if test="${taskTest.description.trim().length() == 0 && submitTask != null}"> class="errorInput" </c:if>
                                                                                         type="text"
                                                                                         id="description"
                                                                                         placeholder="Enter task description"
                                                                                         width="150"
                                                                                         name="description"
                                                                                         maxlength="225">
        <br/>
        <br/>
        <input type="submit" name="addTask" value="Create">

        <%--add task form validation info start--%>
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
        <%--add tasko form validation info end--%>
    </fieldset>
</form>
<%--add task form end--%>
<c:if test="${requestScope.allTasks.size() > 0}">
    <div class="tasks-body">
        <h2 class="manager-tile">Manage Tasks</h2>
        <c:forEach items="${requestScope.allTasks}" var="task">
            <div class="task-body">
                    <%--flip task form start--%>
                <form class="small-form" action="${pageContext.request.contextPath}/Tasks" method="post">
                    <input value="${task.task_id}" type="hidden" name="taskID">
                    <input
                            type="submit"
                            name="flipTask"
                    <c:choose>
                    <c:when test="${!task.done}">
                            class="undone-button"
                    </c:when>
                    <c:otherwise>
                            class="done-button"
                    </c:otherwise>
                    </c:choose>
                    <c:choose>
                    <c:when test="${!task.done}">
                            value="Done"
                    </c:when>
                    <c:otherwise>
                            value="Undone"
                    </c:otherwise>
                    </c:choose>>
                </form>
                    <%--flip task form end--%>
                <c:if test="${task.done}">
                    <%--delete task form start--%>
                    <form class="small-form" action="${pageContext.request.contextPath}/Tasks" method="post">
                        <input value="${task.task_id}" type="hidden" name="taskID">
                        <input type="submit" name="deleteTask" value="Delete Task">
                    </form>
                    <%--delete task form end--%>
                </c:if>
                <p class="task-title">Task name: <c:out value="${task.name}"/></p>
                <p class="task-description">Task description: <c:out value="${task.description}"/></p>
                        <c:if test="${task.todos.size() > 0}">
                            <p class="todo-list-title">List of Todos</p>
                <ol>
                    <c:forEach items="${task.todos}" var="todo">
                    <li>
                        <ul>
                            <li>Todo name: <c:out value="${todo.description}"/>
                                    <%--flip todu form start--%>
                                <form class="small-form" action="${pageContext.request.contextPath}/Tasks"
                                      method="post">
                                    <input value="${todo.todo_id}" type="hidden" name="todoID">
                                    <input
                                            type="submit"
                                            name="flipTodo"
                                    <c:choose>
                                    <c:when test="${!todo.done}">
                                            class="undone-button"
                                    </c:when>
                                    <c:otherwise>
                                            class="done-button"
                                    </c:otherwise>
                                    </c:choose>

                                    <c:choose>
                                    <c:when test="${!todo.done}">
                                            value="Done"
                                    </c:when>
                                    <c:otherwise>
                                            value="Undone"
                                    </c:otherwise>
                                    </c:choose>
                                    >
                                </form>
                                    <%--flip todu form end--%>
                                <c:if test="${todo.done}">
                                    <%--delete todu form start--%>
                                    <form class="small-form" action="${pageContext.request.contextPath}/Tasks"
                                          method="post">
                                        <input value="${todo.todo_id}" type="hidden" name="todoId">
                                        <input type="submit" name="deleteTodo" value="Delete Todo">
                                    </form>
                                    <%--delete todu form end--%>
                                </c:if></li>


                            <c:if test="${todo.employees.size()>0}">
                                <li>List of employees working on todo:</li>
                                <ol>
                                    <c:forEach items="${todo.employees}" var="emp">
                                        <li>
                                                ${emp.name} ${emp.surname} - ${emp.level}
                                                <%--delete employee form start--%>
                                            <form class="small-form" action="${pageContext.request.contextPath}/Tasks"
                                                  method="post">
                                                <input value="${todo.todo_id}" type="hidden" name="todoId">
                                                <input value="${emp.employee_id}" type="hidden" name="empId">
                                                <input type="submit" name="deleteFormDoTo" value="Unassign">
                                            </form>
                                                <%--delete employee form end--%>
                                        </li>
                                    </c:forEach>
                                </ol>
                            </c:if>

                            <li>
                                    <%--add employee form start--%>
                                <form class="small-form" action="${pageContext.request.contextPath}/Tasks"
                                      method="post">
                                    <input value="${todo.todo_id}" type="hidden" name="todoId">
                                    <label for="employee">Assign Employee to Todo:</label>
                                    <select name="employee" id="employee">
                                        <option value="">Select Employee</option>
                                        <c:forEach items="${requestScope.allEmployee}" var="emp">
                                            <c:if test="${!todo.employees.contains(emp) && emp.getLevel().ordinal() >= todo.getDegree().ordinal()}">
                                                <option value="${emp.employee_id}"><c:out
                                                        value="${emp.name} ${emp.surname}"/></option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                    <input type="submit" name="addEmployee" value="+">
                                </form>
                                    <%--add employee form end--%>
                            </li>
                        </ul>
                        </c:forEach>

                    </li>
                </ol>
                        </c:if>
                    <%--add todu form start--%>
                <form class="big-form" action="${pageContext.request.contextPath}/Tasks" method="post">
                    <fieldset>
                        <legend>Insert new todo information</legend>
                        <input value="${task.task_id}" type="hidden" name="taskID">
                        <label for="descriptionTodo">Description:</label>
                        <input type="text" maxlength="225" id="descriptionTodo" name="descriptionTodo">
                        <br/>
                        <br/>
                        <label for="degree">Select entry skill level:</label>
                        <select name="degree" id="degree">
                            <option value="junior">Junior</option>
                            <option value="mid">Mid</option>
                            <option value="senior">Senior</option>
                        </select>
                        <br/>
                        <br/>
                        <input type="submit" name="addTodo" value="Create">
                        <c:if test="${submitTodo != null && pageContext.request.getParameter('descriptionTodo').length() == 0}">
                            <p class="error">Insert to do description.</p>
                        </c:if>
                    </fieldset>
                </form>
                    <%--add todu form end--%>

            </div>
        </c:forEach>
    </div>
</c:if>


<c:import url="footer.jsp" charEncoding="UTF=8"/>
</body>
</html>
