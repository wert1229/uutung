package com.sist.erp.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception
	{
		if(request.getSession().getAttribute("loginSeq")==null)
		{
			String prev=request.getRequestURI();
			prev=prev.substring(prev.indexOf(request.getContextPath())+request.getContextPath().length());
			request.getSession().setAttribute("prevPage", prev);
			
			response.sendRedirect(request.getContextPath()+"/login");
			
			return false;
		}
		
		return true;
	}
	
	
}