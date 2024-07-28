package com.spring.javaclassS14.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.ModelAndView;

import com.spring.javaclassS14.service.ShopService;
import com.spring.javaclassS14.vo.ShopVO;

import java.util.List;

public class CommonDataInterceptor extends HandlerInterceptorAdapter {

    @Autowired
    private ShopService shopService;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        if (modelAndView != null && !request.getRequestURI().startsWith("/admin")) {
            List<ShopVO> categoryTopVOS = shopService.getCategoryTop();
            List<ShopVO> productTopMidVOS = shopService.getProductTopMidList();
            
            modelAndView.addObject("categoryTopVOS", categoryTopVOS);
            modelAndView.addObject("productTopMidVOS", productTopMidVOS);

            HttpSession session = request.getSession();
            String userId = (String) session.getAttribute("sUid");
            if (userId != null) {
                Integer cartCount = shopService.getUserCartCnt(userId);
                modelAndView.addObject("cartCount", cartCount != null ? cartCount : 0);
            }
        }
    } 
}
