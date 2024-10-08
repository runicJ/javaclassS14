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
import com.spring.javaclassS14.service.OrderService;
import com.spring.javaclassS14.service.RecentService;
import com.spring.javaclassS14.service.ShopService;
import com.spring.javaclassS14.service.UserService;
import com.spring.javaclassS14.vo.SaveInterestVO;
import com.spring.javaclassS14.vo.ShopVO;

public class CommonDataInterceptor extends HandlerInterceptorAdapter {

    @Autowired
    private ShopService shopService;
    
    @Autowired
    private OrderService orderService;
    
    @Autowired
    private RecentService recentService;
    
    @Autowired
    private UserService userService;

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

    		List<String> topPickTags = shopService.getTopPickTags();
    		//System.out.println("topPickTags :: " + topPickTags);
    		modelAndView.addObject("topPickTags", topPickTags);
            
            HttpSession session = request.getSession();
            Integer userIdx = (Integer) session.getAttribute("sUidx");  // userIdx를 Integer로 선언
            if (userIdx != null) {
                Integer cartCount = shopService.getUserCartCnt(userIdx);
                Integer orderCount = orderService.getUserOrderCnt(userIdx);
                Integer couponCount = userService.getUserCouponCnt(userIdx);
                Integer pointCount = userService.getUserPointCnt(userIdx);
                modelAndView.addObject("cartCount", cartCount != null ? cartCount : 0);
                modelAndView.addObject("orderCount", orderCount != null ? orderCount : 0);
                modelAndView.addObject("couponCount", couponCount != null ? couponCount : 0);
                modelAndView.addObject("pointCount", pointCount != null ? pointCount : 0);
                
                // 최근 검색어와 최근 본 상품 추가
                List<Map<String, Object>> recentSearch = recentService.getRecentSearch(userIdx, 5); // 최근 검색어 5개
                //List<Map<String, Object>> recentProduct = recentService.getRecentProduct(userIdx, 5); // 최근 본 상품 5개

                modelAndView.addObject("recentSearch", recentSearch);
                //modelAndView.addObject("recentProduct", recentProduct);
            }
    		
        }
    } 
}
