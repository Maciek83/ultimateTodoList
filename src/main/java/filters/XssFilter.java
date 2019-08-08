package filters;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import java.io.IOException;
import java.util.*;

public class XssFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        filterChain.doFilter(new FilteredRequest(servletRequest), servletResponse);
    }

    @Override
    public void destroy() {

    }
}

class FilteredRequest extends HttpServletRequestWrapper {

    private Map<String, String[]> copyOfParameterMap = new HashMap<>();

    FilteredRequest(ServletRequest request) {
        super((HttpServletRequest) request);

        Map<String, String[]> parameterMap = request.getParameterMap();

        for (Map.Entry<String, String[]> entry : parameterMap.entrySet()) {
            copyOfParameterMap.put(entry.getKey(), entry.getValue());
        }

        for (Map.Entry<String, String[]> entry : copyOfParameterMap.entrySet()) {
            String key = entry.getKey();
            String[] value = entry.getValue();

            List<String> paramsList = new ArrayList<>();

            Arrays.stream(value).forEach(s ->
            {
                StringBuilder builder = new StringBuilder();

                for (char c : s.toCharArray()) {

                    if (c == '<') {
                        builder.append("&lt;");
                    } else if (c == '>') {
                        builder.append("&gt;");
                    } else {
                        builder.append(c);
                    }
                }

                paramsList.add(builder.toString());

            });

            String[] stockArr = new String[paramsList.size()];

            stockArr = paramsList.toArray(stockArr);

            copyOfParameterMap.replace(key, stockArr);
        }
    }

    @Override
    public String getParameter(String name) {

        if (copyOfParameterMap.get(name) == null) {
            return null;
        } else {
            return copyOfParameterMap.get(name)[0];
        }

    }

    @Override
    public Enumeration<String> getParameterNames() {

        return Collections.enumeration(getParameterMap().keySet());
    }

    @Override
    public String[] getParameterValues(String name) {
        return copyOfParameterMap.get(name);
    }

    @Override
    public Map<String, String[]> getParameterMap() {
        return copyOfParameterMap;
    }

}
