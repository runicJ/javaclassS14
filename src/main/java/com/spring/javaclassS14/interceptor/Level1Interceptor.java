package com.spring.javaclassS14.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class Level1Interceptor extends HandlerInterceptorAdapter {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		HttpSession session = request.getSession();
		double level = session.getAttribute("sLevel")==null ? 99 : (double) session.getAttribute("sLevel");
		
		if(level > 1) {
			RequestDispatcher dispatcher;
			if(level == 99) {
				dispatcher = request.getRequestDispatcher("/msg/userNo");
			}
			else {
				dispatcher = request.getRequestDispatcher("/msg/userLevelNo");
			}
			dispatcher.forward(request, response);
			return false;
		}
		
		return true;
	}
}
