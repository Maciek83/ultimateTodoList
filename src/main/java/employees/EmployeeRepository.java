package employees;

import enums.ProgramingLevels;
import org.hibernate.Session;

import java.util.List;

public class EmployeeRepository
{
    private Session session;

    public EmployeeRepository(Session session)
    {
        this.session = session;
    }

    List<Employee> findAll()
    {
        var transaction = session.beginTransaction();

        var result = session.createQuery("from Employee", Employee.class).list();

        transaction.commit();

        return result;
    }

    Employee changePosition(Integer empId, String newPosition)
    {
        var transaction = session.beginTransaction();

        ProgramingLevels newLevel = ProgramingLevels.valueOf(newPosition);
        Employee employeeToChange = session.get(Employee.class,empId);
        employeeToChange.setLevel(newLevel);

        transaction.commit();

        return employeeToChange;
    }

    Employee addEmployee(Employee newEmployee)
    {
        var transaction = session.beginTransaction();

        session.persist(newEmployee);

        transaction.commit();

        return newEmployee;
    }
}
