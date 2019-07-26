package welcome;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class WelcomeServlet extends HttpServlet
{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        List<String> strings = new ArrayList<>();
        strings.add("a");
        strings.add("b");
        strings.add("c");

        req.setAttribute("stringi",strings);

        resp.setContentType("text/html");
        resp.getWriter().print("Hi im welcome Servlet. I have logger.");

        req.getRequestDispatcher("WEB-INF/included/dolacz.jsp").include(req,resp);
    }
}
