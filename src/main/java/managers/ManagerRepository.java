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
            return true;
        }


        return false;
    }

    public Optional<Manager> tryLogin(String email, String password)
    {

        Optional<Manager> manager = Optional.empty();

        try {
            manager = Optional.ofNullable(session.createQuery("From Manager M WHERE M.email = :em and M.password = :pas", Manager.class)
                    .setParameter("em", email)
                    .setParameter("pas",password)
                    .getSingleResult());
        } catch (NoResultException e) { }

        return manager;

    }
}
