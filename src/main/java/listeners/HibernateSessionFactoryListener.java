package listeners;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.service.ServiceRegistry;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;


public class HibernateSessionFactoryListener implements ServletContextListener
{

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent)
    {

        SessionFactory sessionFactory = (SessionFactory) servletContextEvent.getServletContext().getAttribute("SessionFactory");

        if(sessionFactory != null && !sessionFactory.isClosed())
        {
            sessionFactory.close();
        }

    }

    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent)
    {
        Configuration configuration = new Configuration();
        configuration.addAnnotatedClass(todos.Todo.class);

        configuration.configure("hibernate.cfg.xml");

        ServiceRegistry serviceRegistry = new StandardServiceRegistryBuilder()
                .applySettings(configuration.getProperties()).build();

        SessionFactory sessionFactory = configuration.buildSessionFactory(serviceRegistry);

        servletContextEvent.getServletContext().setAttribute("SessionFactory", sessionFactory);

    }


}
