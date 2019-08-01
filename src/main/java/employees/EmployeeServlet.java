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
import java.util.stream.Collectors;

public class EmployeeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        EmployeeRepository employeeRepository = prepareEmployeeRepository(req);

        List<Employee> employees = employeeRepository.findAll();

        List<Employee> junior = employees.stream().filter(e->e.getLevel().equals(ProgramingLevels.junior)).collect(Collectors.toList());
        List<Employee> mid = employees.stream().filter(e->e.getLevel().equals(ProgramingLevels.mid)).collect(Collectors.toList());
        List<Employee> senior = employees.stream().filter(e->e.getLevel().equals(ProgramingLevels.senior)).collect(Collectors.toList());

        req.setAttribute("junior",junior);
        req.setAttribute("mid",mid);
        req.setAttribute("senior",senior);


        req.getRequestDispatcher("WEB-INF/included/employee.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        if (req.getParameter("addEmployee") != null)
        {
            addEmployee(req);
        }
        else if (req.getParameter("changeLevel") != null)
        {
            EmployeeRepository employeeRepository = prepareEmployeeRepository(req);

            int empId = Integer.parseInt(req.getParameter("empId"));
            String newLevel = req.getParameter("empLevel");

            employeeRepository.changePosition(empId,newLevel);
        }

        doGet(req, resp);
    }

    private void addEmployee(HttpServletRequest req) {

        EmployeeRepository employeeRepository = prepareEmployeeRepository(req);

        String name = req.getParameter("name");
        String surname = req.getParameter("surname");
        String level = req.getParameter("level");


        if (name.length() == 0 || surname.length() == 0) {
            return;
        }

        req.setAttribute("error", false);

        Employee employee = new Employee();
        employee.setName(name.trim());
        employee.setSurname(surname.trim());
        employee.setLevel(ProgramingLevels.valueOf(level));

        employeeRepository.addEmployee(employee);

    }

    private EmployeeRepository prepareEmployeeRepository(HttpServletRequest req) {
        SessionFactory sessionFactory = (SessionFactory) req.getServletContext().getAttribute("SessionFactory");
        Session session = sessionFactory.getCurrentSession();
        return new EmployeeRepository(session);
    }

}
