package employees;

import enums.ProgramingLevels;
import managers.Manager;
import todos.Todo;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "employyes")
public class Employee {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(nullable = false, updatable = false)
    private Integer employee_id;
    @Column(nullable = false)
    private String name;
    @Column(nullable = false)
    private String surname;
    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private ProgramingLevels level;
    @ManyToMany
    @JoinTable(
            name="todo_employye",
            joinColumns = {
                    @JoinColumn(name="employye_id")},
            inverseJoinColumns = {
                    @JoinColumn(name = "todo_id")}
    )
    private Set<Todo> todos;
    @ManyToOne
    @JoinColumn(name="manager", nullable = false)
    private Manager manager;

    public Employee() { }

    public Integer getEmployee_id() {
        return employee_id;
    }

    public void setEmployee_id(Integer employye_id) {
        this.employee_id = employye_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public ProgramingLevels getLevel() {
        return level;
    }

    public void setLevel(ProgramingLevels level) {
        this.level = level;
    }

    public Set getTodos() {
        return todos;
    }

    public void setTodos(Set<Todo> todos) {
        this.todos = todos;
    }

    public Manager getManager() {
        return manager;
    }

    public void setManager(Manager manager) {
        this.manager = manager;
    }
}
