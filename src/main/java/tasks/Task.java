package tasks;

import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.GenericGenerator;
import todos.Todo;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "tasks")
public class Task {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(nullable = false)
    private Integer task_id;
    @Column(nullable = false)
    private String name;
    @Column(nullable = false)
    private String description;
    @ColumnDefault("0")
    private boolean done;
    @OneToMany(mappedBy = "task")
    private Set<Todo> items;

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

    public Set<Todo> getItems() {
        return items;
    }

    public void setItems(Set<Todo> items) {
        this.items = items;
    }
}
