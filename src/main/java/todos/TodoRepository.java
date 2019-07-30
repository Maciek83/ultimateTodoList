package todos;

import org.hibernate.Session;

import java.util.List;

public class TodoRepository
{
    private Session session;

    public TodoRepository(Session session)
    {
        this.session = session;
    }

    List<Todo> findAll()
    {
        var transaction = session.beginTransaction();

        var result = session.createQuery("from Todo",Todo.class).list();
        
        transaction.commit();

        return result;
    }

    Todo toggleTodo(Integer todoId)
    {
        var transaction = session.beginTransaction();

        var todo = session.get(Todo.class,todoId);
        todo.setDone(!todo.isDone());

        transaction.commit();

        return todo;
    }

    Todo addTodo(Todo newTodo)
    {
        var transaction = session.beginTransaction();

        session.persist(newTodo);

        transaction.commit();

        return newTodo;
    }
}
