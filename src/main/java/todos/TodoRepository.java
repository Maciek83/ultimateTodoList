package todos;

import employees.Employee;
import org.hibernate.Session;
import tasks.Task;

import java.util.List;
import java.util.Set;

public class TodoRepository {
    private Session session;

    public TodoRepository(Session session) {
        this.session = session;
    }

    List<Todo> findAll() {
        return session.createQuery("from Todo", Todo.class).list();
    }

    public Todo toggleTodo(Integer todoId) {
        Todo todo = session.get(Todo.class, todoId);
        todo.setDone(!todo.isDone());

        return todo;
    }

    public Employee addMToMEmployeeToToDo(Integer employee_id, Integer todo_id) {

        Employee employee = session.createQuery("from Employee E where E.employee_id=:employee_id", Employee.class).setParameter("employee_id", employee_id).getSingleResult();
        Todo todo = session.createQuery("from Todo T where T.todo_id=:todo_id", Todo.class).setParameter("todo_id", todo_id).getSingleResult();


        employee.getTodos().add(todo);
        todo.getEmployees().add(employee);

        session.update(employee);


        return employee;
    }

    public Todo addTodo(Todo newTodo, Integer taskId) {

        Task task = session.createQuery("from Task T where T.task_id=:taskid", Task.class).setParameter("taskid", taskId).getSingleResult();

        newTodo.setTask(task);

        session.persist(newTodo);


        return newTodo;
    }

    public Todo deleteTodo(Integer todoId)
    {
        Todo todoToDelete = session.get(Todo.class,todoId);

        Set<Employee> employees = todoToDelete.getEmployees();

        employees.forEach(employee -> employee.getTodos().remove(todoToDelete));

        session.delete(todoToDelete);

        return todoToDelete;
    }

    public Employee deleteEmployeeFromMakingToDo(Integer empId, Integer todoId)
    {
        Todo todo = session.get(Todo.class,todoId);
        Employee employee = session.get(Employee.class,empId);

        todo.getEmployees().remove(employee);
        employee.getTodos().remove(todo);

        session.update(employee);

        return employee;
    }

}
