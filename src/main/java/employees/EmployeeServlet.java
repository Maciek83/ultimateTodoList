package employees;

import enums.ProgramingLevels;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class EmployeeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        EmployeeRepository employeeRepository = prepareEmployeeRepository(req);

        List<Employee> employees = employeeRepository.findAll();

        req.setAttribute("employees",employees);

        req.getRequestDispatcher("WEB-INF/included/employee.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        if (req.getParameter("addEmployee") != null)
        {
            addEmployee(req);
        }

        doGet(req,resp);
    }

    private void addEmployee(HttpServletRequest req) {

        EmployeeRepository employeeRepository = prepareEmployeeRepository(req);

        String name = req.getParameter("name");
        String surname = req.getParameter("surname");
        String level = req.getParameter("level");

        if(name.length() == 0 || surname.length() == 0)
        {
            req.setAttribute("error",true);
        }
        else
        {
            req.setAttribute("error",false);

            Employee employee = new Employee();
            employee.setName(name.trim());
            employee.setSurname(surname.trim());
            employee.setLevel(ProgramingLevels.valueOf(level));

            employeeRepository.addEmployee(employee);
        }
    }

    private EmployeeRepository prepareEmployeeRepository(HttpServletRequest req) {
        SessionFactory sessionFactory = (SessionFactory) req.getServletContext().getAttribute("SessionFactory");
        Session session = sessionFactory.getCurrentSession();
        return new EmployeeRepository(session);
    }

}
