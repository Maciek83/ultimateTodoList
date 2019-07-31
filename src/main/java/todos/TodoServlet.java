package todos;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

public class TodoServlet extends HttpServlet
{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        TodoRepository todoRepository = prepareTodoRepository(req);

        List<Todo> todoList = todoRepository.findAll();
        req.setAttribute("todoList",todoList);

        req.getRequestDispatcher("WEB-INF/included/todo.jsp").forward(req,resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        TodoRepository todoRepository = prepareTodoRepository(req);

        toggleTodo(req, todoRepository);
        addNewTodo(req, todoRepository);

        doGet(req,resp);
    }

    private void addNewTodo(HttpServletRequest req, TodoRepository todoRepository) {

        Optional<String> optionalParam = Optional.of(req.getParameter("description"));

        optionalParam.ifPresent(s->{
            Todo newToDo = new Todo();
            newToDo.setDescription(s);
            newToDo.setDone(false);
            todoRepository.addTodo(newToDo);
        });
    }

    private void toggleTodo(HttpServletRequest req, TodoRepository todoRepository) {
        Optional<String> optionalParam = Optional.of(req.getParameter("idForCheckBox"));
        optionalParam.ifPresent(s->
        todoRepository.toggleTodo(Integer.parseInt(s)));
    }

    private TodoRepository prepareTodoRepository(HttpServletRequest req) {
        SessionFactory sessionFactory = (SessionFactory) req.getServletContext().getAttribute("SessionFactory");
        Session session = sessionFactory.getCurrentSession();
        return new TodoRepository(session);
    }
}
