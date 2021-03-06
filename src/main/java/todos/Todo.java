package todos;

import employees.Employee;
import enums.ProgramingLevels;
import managers.Manager;
import org.hibernate.annotations.ColumnDefault;
import tasks.Task;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "todos")
public class Todo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(nullable = false, updatable = false)
    private Integer todo_id;
    @Column(nullable = false)
    private String description;
    @ColumnDefault("0")
    private boolean done;
    @Column(name = "degree", nullable = false)
    @Enumerated(EnumType.STRING)
    private ProgramingLevels degree;
    @ManyToOne
    @JoinColumn(name="task", nullable = false)
    private Task task;
    @ManyToMany(mappedBy = "todos", fetch = FetchType.EAGER)
    private Set<Employee> employees;
    @ManyToOne
    @JoinColumn(name="manager", nullable = false)
    private Manager manager;

    public Todo() { }

    public Integer getTodo_id() {
        return todo_id;
    }

    public void setTodo_id(Integer todo_id) {
        this.todo_id = todo_id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isDone() {
        return done;
    }

    public void setDone(boolean done) {
        this.done = done;
    }

    public ProgramingLevels getDegree() {
        return degree;
    }

    public void setDegree(ProgramingLevels degree) {
        this.degree = degree;
    }

    public Task getTask() {
        return task;
    }

    public void setTask(Task task) {
        this.task = task;
    }

    public Set getEmployees() {
        return employees;
    }

    public void setEmployees(Set<Employee> employees) {
        this.employees = employees;
    }

    public Manager getManager() {
        return manager;
    }

    public void setManager(Manager manager) {
        this.manager = manager;
    }
}
