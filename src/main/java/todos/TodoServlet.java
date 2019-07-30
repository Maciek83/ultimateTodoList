package todos;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class TodoServlet extends HttpServlet
{
    private final Logger logger = LogManager.getLogger("standard");

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        SessionFactory sessionFactory = (SessionFactory) req.getServletContext().getAttribute("SessionFactory");

        Session session = sessionFactory.getCurrentSession();

        TodoRepository todoRepository = new TodoRepository(session);

        List<Todo> todoList = todoRepository.findAll();

        req.setAttribute("todoList",todoList);

        req.getRequestDispatcher("WEB-INF/included/todo.jsp").forward(req,resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        SessionFactory sessionFactory = (SessionFactory) req.getServletContext().getAttribute("SessionFactory");

        Session session = sessionFactory.getCurrentSession();
        TodoRepository todoRepository = new TodoRepository(session);

        String toDoDescription = req.getParameter("description");

        String idForCheckBox = req.getParameter("idForCheckBox");

        if(idForCheckBox != null)
        {
            todoRepository.toggleTodo(Integer.parseInt(idForCheckBox));
        }


        if(toDoDescription != null)
        {

            Todo newToDo = new Todo();

            newToDo.setDescription(toDoDescription);
            newToDo.setDone(false);

            todoRepository.addTodo(newToDo);
        }

        doGet(req,resp);
    }
}
