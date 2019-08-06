package employees;

import enums.ProgramingLevels;
import managers.Manager;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class EmployeeRepository
{
    private Session session;

    public EmployeeRepository(Session session)
    {
        this.session = session;
    }

    List<Employee> findAll(Manager manager)
    {
        Transaction transaction = session.beginTransaction();

        List<Employee> result = session.createQuery("from Employee E where E.manager=:manager", Employee.class)
                .setParameter("manager",manager)
                .list();

        transaction.commit();

        return result;
    }

    Employee changePosition(Integer empId, String newPosition)
    {
        Transaction transaction = session.beginTransaction();

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
