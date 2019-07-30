package tasks;

import org.hibernate.annotations.GenericGenerator;
import todos.Todo;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name="tasks")
public class Task
{
    @Id
    @GeneratedValue(generator = "inc")
    @GenericGenerator(name ="inc", strategy = "increment")
    private Integer id;
    private String name;
    @OneToMany(mappedBy = "task")
    private Set<Todo> items;

    public Task(){}

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Set<Todo> getItems() {
        return items;
    }

    public void setItems(Set<Todo> items) {
        this.items = items;
    }
}
