package com.spring.javaclassS14.interceptor;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.spring.javaclassS14.service.CsworkService;
import com.spring.javaclassS14.service.RecentService;
import com.spring.javaclassS14.service.ShopService;
import com.spring.javaclassS14.vo.SaveInterestVO;
import com.spring.javaclassS14.vo.ShopVO;

public class CommonDataInterceptor extends HandlerInterceptorAdapter {

    @Autowired
    private ShopService shopService;
    
    @Autowired
    private CsworkService introService;
    
    @Autowired
    private RecentService recentService;

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
                
                // 최근 검색어와 최근 본 상품 추가
                //List<Map<String, Object>> recentSearch = recentService.getRecentSearch(userId, 5); // 최근 검색어 5개
                //List<Map<String, Object>> recentProduct = recentService.getRecentProduct(userId, 5); // 최근 본 상품 5개

                //modelAndView.addObject("recentSearch", recentSearch);
                //modelAndView.addObject("recentProduct", recentProduct);
            }
    		
        }
    } 
}
