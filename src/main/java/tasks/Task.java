package tasks;

import managers.Manager;
import org.hibernate.annotations.ColumnDefault;
import todos.Todo;

import javax.persistence.*;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "tasks")
public class Task {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(nullable = false, updatable = false)
    private Integer task_id;
    @Column(nullable = false)
    private String name;
    @Column(nullable = false)
    private String description;
    @ColumnDefault("0")
    private boolean done;
    @OneToMany(mappedBy = "task", fetch = FetchType.EAGER)
    private List<Todo> todos;
    @ManyToOne
    @JoinColumn(name="manager", nullable = false)
    private Manager manager;

    public Task() {
    }

    public Integer getTask_id() {
        return task_id;
    }

    public void setTask_id(Integer task_id) {
        this.task_id = task_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public List<Todo> getTodos() {
        return todos;
    }

    public void setTodos(List<Todo> items) {
        this.todos = items;
    }

    public Manager getManager() {
        return manager;
    }

    public void setManager(Manager manager) {
        this.manager = manager;
    }
}
