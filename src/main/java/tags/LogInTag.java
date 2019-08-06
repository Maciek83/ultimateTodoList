package tags;

import managers.Manager;

import javax.servlet.jsp.JspContext;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;

public class LogInTag extends SimpleTagSupport
{
    @Override
    public void doTag() throws JspException, IOException
    {
        Manager manager = (Manager) getJspContext().getAttribute("loggedManager");

        if (manager == null)
        {

        }

    }
}
