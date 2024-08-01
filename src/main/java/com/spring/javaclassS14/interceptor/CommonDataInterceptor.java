package com.spring.javaclassS14.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.spring.javaclassS14.service.CsworkService;
import com.spring.javaclassS14.service.ShopService;
import com.spring.javaclassS14.vo.SaveMypageVO;
import com.spring.javaclassS14.vo.ShopVO;

public class CommonDataInterceptor extends HandlerInterceptorAdapter {

    @Autowired
    private ShopService shopService;
    
    @Autowired
    private CsworkService introService;

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
    		
            List<SaveMypageVO> topNewsVOS = introService.findTopNews(3); // 상위 3개의 기사 가져오기
            modelAndView.addObject("topNewsVOS", topNewsVOS);
        }
    } 
}
