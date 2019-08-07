package employees;

import enums.ProgramingLevels;
import managers.Manager;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

public class EmployeeServlet extends HttpServlet{


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        setupEmployeesLists(req);

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
            changeEmployeeLevel(req);
        }
        else if (req.getParameter("deleteEmployee") != null)
        {
            EmployeeRepository employeeRepository = new EmployeeRepository(getSession(req));

            Integer empId = Integer.parseInt(req.getParameter("empId2"));

            Transaction transaction = getSession(req).beginTransaction();
            employeeRepository.deleteEmployee(empId);
            transaction.commit();
        }

        doGet(req, resp);
    }

    private void changeEmployeeLevel(HttpServletRequest req) {
        EmployeeRepository employeeRepository = new EmployeeRepository(getSession(req));

        int empId = Integer.parseInt(req.getParameter("empId"));
        String newLevel = req.getParameter("empLevel");

        Transaction transaction = getSession(req).beginTransaction();
        employeeRepository.changePosition(empId,newLevel);
        transaction.commit();
    }

    private void addEmployee(HttpServletRequest req) {

        EmployeeRepository employeeRepository = new EmployeeRepository(getSession(req));
        Manager manager = (Manager) req.getSession().getAttribute("loggedManager");

        String name = req.getParameter("name").trim();
        String surname = req.getParameter("surname").trim();
        String level = req.getParameter("level").trim();


        if (name.length() == 0 || surname.length() == 0)  return;

        Employee employee = new Employee();
        employee.setName(name.trim());
        employee.setSurname(surname.trim());
        employee.setLevel(ProgramingLevels.valueOf(level));
        employee.setManager(manager);

        Transaction transaction = getSession(req).beginTransaction();
        employeeRepository.addEmployee(employee);
        transaction.commit();

    }

    private Session getSession(HttpServletRequest req) {
        SessionFactory sessionFactory = (SessionFactory) req.getServletContext().getAttribute("SessionFactory");
        return sessionFactory.getCurrentSession();
    }

    private void setupEmployeesLists(HttpServletRequest req) {
        EmployeeRepository employeeRepository = new EmployeeRepository(getSession(req));
        Manager manager = (Manager) req.getSession().getAttribute("loggedManager");

        Transaction transaction = getSession(req).beginTransaction();
        List<Employee> employees = employeeRepository.findAll(manager);
        transaction.commit();

        List<Employee> junior = employees.stream().filter(e->e.getLevel().equals(ProgramingLevels.junior)).collect(Collectors.toList());
        List<Employee> mid = employees.stream().filter(e->e.getLevel().equals(ProgramingLevels.mid)).collect(Collectors.toList());
        List<Employee> senior = employees.stream().filter(e->e.getLevel().equals(ProgramingLevels.senior)).collect(Collectors.toList());

        req.setAttribute("junior",junior);
        req.setAttribute("mid",mid);
        req.setAttribute("senior",senior);
    }


}
