package tasks;

import employees.Employee;
import employees.EmployeeRepository;
import enums.ProgramingLevels;
import managers.Manager;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import todos.Todo;
import todos.TodoRepository;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class TaskServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        TaskRepository taskRepository = new TaskRepository(getSession(req));
        EmployeeRepository employeeRepository = new EmployeeRepository(getSession(req));

        Manager manager = (Manager) req.getSession().getAttribute("loggedManager");

        Transaction transaction = getSession(req).beginTransaction();

        List<Task> taskList = taskRepository.findAll(manager);
        List<Employee> employeeList = employeeRepository.findAll(manager);


        transaction.commit();

        req.setAttribute("allTasks", taskList);
        req.setAttribute("allEmployee",employeeList);

        req.getRequestDispatcher("WEB-INF/included/task.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        if (req.getParameter("addTask") != null)
        {
            addTask(req);
        }
        else if (req.getParameter("addTodo") != null)
        {
            addTodo(req);
        }
        else if (req.getParameter("addEmployee") != null)
        {
            addMToMTodoEmployee(req);
        }
        else if (req.getParameter("deleteTodo") != null)
        {
            deleteTodo(req);
        }
        else if (req.getParameter("flipTask") != null)
        {
            flipTask(req);
        }
        else if (req.getParameter("deleteTask") != null)
        {
            deleteTask(req);
        }
        else if(req.getParameter("flipTodo") != null)
        {
            flipTodo(req);
        }
        else if(req.getParameter("deleteFormDoTo") != null)
        {
            deleteEmpFromMakingToDo(req);
        }

        doGet(req, resp);

    }

    private void deleteEmpFromMakingToDo(HttpServletRequest req) {
        TodoRepository todoRepository = new TodoRepository(getSession(req));
        Integer todoId = Integer.parseInt(req.getParameter("todoId"));
        Integer empId = Integer.parseInt(req.getParameter("empId"));

        Transaction transaction = getSession(req).beginTransaction();
        todoRepository.deleteEmployeeFromMakingToDo(empId,todoId);
        transaction.commit();
    }

    private void flipTodo(HttpServletRequest req) {
        TodoRepository todoRepository = new TodoRepository(getSession(req));
        Integer todoId = Integer.parseInt(req.getParameter("todoID"));

        Transaction transaction = getSession(req).beginTransaction();
        todoRepository.toggleTodo(todoId);
        transaction.commit();
    }

    private void deleteTask(HttpServletRequest req) {
        TaskRepository taskRepository = new TaskRepository(getSession(req));
        Integer taskId = Integer.parseInt(req.getParameter("taskID"));

        Transaction transaction = getSession(req).beginTransaction();
        taskRepository.deleteTask(taskId);
        transaction.commit();
    }

    private void flipTask(HttpServletRequest req) {
        TaskRepository taskRepository = new TaskRepository(getSession(req));
        Integer taskId = Integer.parseInt(req.getParameter("taskID"));

        Transaction transaction = getSession(req).beginTransaction();
        taskRepository.changeIsDone(taskId);
        transaction.commit();
    }

    private void deleteTodo(HttpServletRequest req) {
        TodoRepository todoRepository = new TodoRepository(getSession(req));
        Integer toDoId = Integer.parseInt(req.getParameter("todoId"));

        Transaction transaction = getSession(req).beginTransaction();
        todoRepository.deleteTodo(toDoId);
        transaction.commit();
    }

    private void addMToMTodoEmployee(HttpServletRequest req) {

        TodoRepository todoRepository = new TodoRepository(getSession(req));

        if(req.getParameter("employee") == null)
        {
            return;
        }

        Integer empId = Integer.parseInt(req.getParameter("employee"));
        Integer todoId = Integer.parseInt(req.getParameter("todoId"));


        Transaction transaction = getSession(req).beginTransaction();
        todoRepository.addMToMEmployeeToToDo(empId,todoId);
        transaction.commit();
    }

    private void addTodo(HttpServletRequest req) {
        TodoRepository todoRepository = new TodoRepository(getSession(req));

        Manager manager = (Manager) req.getSession().getAttribute("loggedManager");
        Integer taskId = Integer.parseInt(req.getParameter("taskID"));
        String description = req.getParameter("descriptionTodo");
        String entryLevel = req.getParameter("degree");

        if (description.length() == 0 || entryLevel == null)
        {
            return;
        }

        Todo newTodo = new Todo();
        newTodo.setDone(false);
        newTodo.setDescription(description);
        newTodo.setDegree(ProgramingLevels.valueOf(entryLevel));
        newTodo.setManager(manager);

        Transaction transaction = getSession(req).beginTransaction();
        todoRepository.addTodo(newTodo,taskId);
        transaction.commit();
    }

    private void addTask(HttpServletRequest req) {

        TaskRepository taskRepository = new TaskRepository(getSession(req));
        Manager manager = (Manager) req.getSession().getAttribute("loggedManager");

        Task task = new Task();

        String name = req.getParameter("name").trim();
        String description = req.getParameter("description").trim();

        if (name.length() == 0 || description.length() == 0)
            return;

        task.setName(name);
        task.setDescription(description);
        task.setManager(manager);
        task.setDone(false);

        Transaction transaction = getSession(req).beginTransaction();
        taskRepository.addTask(task);
        transaction.commit();
    }

    private Session getSession(HttpServletRequest req) {
        SessionFactory sessionFactory = (SessionFactory) req.getServletContext().getAttribute("SessionFactory");
        return sessionFactory.getCurrentSession();
    }
}
