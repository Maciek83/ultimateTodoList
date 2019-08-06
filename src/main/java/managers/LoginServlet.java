package managers;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class LoginServlet extends HttpServlet
{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("WEB-INF/included/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        ManagerRepository managerRepository = prepareManagerRepository(req);

        String email = req.getParameter("email").trim();
        String password = req.getParameter("password").trim();

        managerRepository.tryLogin(email,password)
                .ifPresentOrElse(manager -> {
                    req.getSession().setAttribute("loggedManager",manager);
                    },

                        ()->{
                    req.getSession().setAttribute("loggedManager",null);
                });


        doGet(req,resp);
    }

    private ManagerRepository prepareManagerRepository(HttpServletRequest req) {
        SessionFactory sessionFactory = (SessionFactory) req.getServletContext().getAttribute("SessionFactory");
        Session session = sessionFactory.getCurrentSession();


        return new ManagerRepository(session);
    }
}
