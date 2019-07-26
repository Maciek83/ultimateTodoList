package todos;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

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

        for (Todo t: todoList)
        {
            resp.getWriter().println(t.getText());
        }

    }
}
