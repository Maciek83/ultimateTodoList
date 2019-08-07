package employees;

import enums.ProgramingLevels;
import managers.Manager;
import org.hibernate.Session;

import java.util.List;

public class EmployeeRepository
{
    private Session session;

    public EmployeeRepository(Session session)
    {
        this.session = session;
    }

    public List<Employee> findAll(Manager manager)
    {
        return session.createQuery("from Employee E where E.manager=:manager", Employee.class)
                .setParameter("manager",manager)
                .list();
    }

    public Employee changePosition(Integer empId, String newPosition)
    {
        ProgramingLevels newLevel = ProgramingLevels.valueOf(newPosition);

        Employee employeeToChange = session.get(Employee.class,empId);
        employeeToChange.setLevel(newLevel);

        return employeeToChange;
    }

    public Employee addEmployee(Employee newEmployee)
    {
        session.persist(newEmployee);

        return newEmployee;
    }

    public Employee deleteEmployee(Integer empId)
    {
        Employee employee = session.get(Employee.class,empId);
        session.delete(employee);

        return employee;
    }

}
