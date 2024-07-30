package com.spring.javaclassS14.service;

import java.util.List;

import com.spring.javaclassS14.vo.CartItem;
import com.spring.javaclassS14.vo.CartVO;
import com.spring.javaclassS14.vo.OrderVO;

public interface OrderService {

    public OrderVO getOrderMaxIdx();
    public CartVO getCartIdx(int cartIdx);
    public void setOrder(OrderVO orderVO);
    public void setCartDeleteAll(int orderProductIdx);
    public void setDelivery(OrderVO orderVO);
    public void setUserPointPlus(int point, String userId);
    public List<OrderVO> getOrderDelivery(String orderIdx);
    public int getTotalDeleveryOrder(int orderIdx);
	public List<OrderVO> getMyOrderList(int startIndexNo, int pageSize, String mid);
	public List<OrderVO> getMyOrderStatus(int startIndexNo, int pageSize, String mid, String startJumun, String endJumun, String conditionOrderStatus);
	public List<CartItem> getCartItemsByCartIdx(int cartIdx);
	public OrderVO getOrderCheck(String userId, int productIdx);
	
}
