package tasks;

import employees.Employee;
import managers.Manager;
import org.hibernate.Session;

import java.util.List;
import java.util.Set;

public class TaskRepository {

    private Session session;

    public TaskRepository(Session session) {
        this.session = session;
    }

    public List<Task> findAll(Manager manager)
    {
        return session.createQuery("from Task T where T.manager=:manager", Task.class)
                .setParameter("manager",manager)
                .list();
    }
    public Task addTask(Task task)
    {
        session.persist(task);
        return task;
    }
    public boolean changeIsDone(Integer taskId)
    {
        Task taskToFlip = session.get(Task.class,taskId);

        taskToFlip.getTodos().forEach(todo -> todo.setDone(!taskToFlip.isDone()));

        taskToFlip.setDone(!taskToFlip.isDone());

        return taskToFlip.isDone();
    }
    public Task deleteTask(Integer taskId)
    {
        Task taskToDelete = session.get(Task.class,taskId);

        taskToDelete.getTodos().forEach(todo -> {

            Set<Employee> employees = todo.getEmployees();

            employees.forEach(employee -> employee.getTodos().remove(todo));

            session.delete(todo);
        });

        session.delete(taskToDelete);
        return taskToDelete;
    }
}
