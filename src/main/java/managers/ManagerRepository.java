package managers;

import org.hibernate.Session;
import org.hibernate.Transaction;

import javax.persistence.NoResultException;
import java.util.Optional;

public class ManagerRepository {

    private Session session;

    public ManagerRepository(Session session) {
        this.session = session;
    }

    public boolean addManager(Manager newManager) {
        Transaction transaction = session.beginTransaction();

        Optional<Manager> manager = Optional.empty();

        try {
            manager = Optional.ofNullable(session.createQuery("From Manager M WHERE M.email = :em", Manager.class)
                    .setParameter("em", newManager.getEmail())
                    .getSingleResult());
        } catch (NoResultException e) {


        }


        if (manager.isEmpty())
        {
            session.persist(newManager);
            transaction.commit();
            return true;
        }

        transaction.commit();

        return false;
    }
}
