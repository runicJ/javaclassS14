package com.spring.javaclassS14.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS14.vo.CartVO;
import com.spring.javaclassS14.vo.OrderVO;

public interface OrderDAO {
	
    public OrderVO getOrderMaxIdx();
    public CartVO getCartIdx(@Param("cartIdx") int cartIdx);
    public void setOrder(@Param("orderVO") OrderVO orderVO);
    public void setCartDeleteAll(@Param("orderProductIdx") int orderProductIdx);
    public void setDelivery(@Param("orderVO") OrderVO orderVO);
    public void setUserPointPlus(@Param("userId") int points, String userId);
    public List<OrderVO> getOrderDelivery(@Param("orderIdx") String orderIdx);
    public int getTotalDeleveryOrder(@Param("orderIdx") int orderIdx);
    
}
