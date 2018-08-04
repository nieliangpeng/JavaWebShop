package com.sky.common;
import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.sky.Bean.Admin;


/**
 * Servlet Filter implementation class adminIndexFilter
 */
@WebFilter("/*")
public class adminIndexFilter implements Filter {

    /**
     * Default constructor. 
     */
    public adminIndexFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		Admin admin = (Admin)req.getSession().getAttribute("admin");
		String requestUrl = req.getRequestURL().toString();
		if (requestUrl.contains("adminIndex")) {
			//已经登录
			if(admin==null) {
				request.setAttribute("notLogigMsgInAdmin","<script>alert('您还没有登录,不能进入后台，请先登录');</script>");
				request.getRequestDispatcher("/admin/adminLogin.jsp").forward(req,res);
			}else {
				chain.doFilter(request, response);
			}
		}else {
			chain.doFilter(request, response);
		} 
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
