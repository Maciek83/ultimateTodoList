package todos;

import enums.ProgramingLevels;
import org.hibernate.annotations.GenericGenerator;
import tasks.Task;

import javax.persistence.*;

@Entity
@Table(name = "todos")
public class Todo {
    @Id
    @GeneratedValue(generator = "inc")
    @GenericGenerator(name = "inc", strategy = "increment")
    private Integer id;
    private String description;
    private boolean done;
    @Column(name = "degree")
    @Enumerated(EnumType.STRING)
    private ProgramingLevels degree;
//    @ManyToOne
//    @JoinColumn(name="task")
//    private Task task;

//    public Task getTask() {
//        return task;
//    }
//
//    public void setTask(Task task) {
//        this.task = task;
//    }

    public Todo() {
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public ProgramingLevels getDegree() {
        return degree;
    }

    public void setDegree(ProgramingLevels degree) {
        this.degree = degree;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public boolean isDone() {
        return done;
    }

    public void setDone(boolean done) {
        this.done = done;
    }
}
