package com.spring.javaclassS14.service;

import java.util.List;

import com.spring.javaclassS14.vo.CartItem;
import com.spring.javaclassS14.vo.CartVO;
import com.spring.javaclassS14.vo.OrderProductVO;
import com.spring.javaclassS14.vo.OrderVO;
import com.spring.javaclassS14.vo.PageVO;
import com.spring.javaclassS14.vo.PaymentVO;

public interface OrderService {

    public OrderVO getOrderMaxIdx();
    public CartVO getCartIdx(int cartIdx);
    public int setOrder(OrderVO orderVO);
    public void setCartDeleteAll(int cartIdx);
    public void setDelivery(OrderVO orderVO);
    public void setUserPointPlus(int point, int userIdx);
    public List<OrderVO> getOrderDelivery(String orderIdx);
    public int getTotalDeleveryOrder(int orderIdx);
	public List<OrderVO> getMyOrderStatus(int startIndexNo, int pageSize, int userIdx, String startOrder, String endOrder, String conditionOrderStatus);
	public List<CartItem> getCartItemsByCartIdx(int cartIdx);
	public OrderVO getOrderCheck(String userId, int productIdx);
	public List<OrderVO> getOrderList();
	public void setOrderProduct(OrderProductVO vo);
	public PaymentVO getPaymentByOrderIdx(String orderIdx);
	public Integer getUserOrderCnt(Integer userIdx);
	public boolean updateOrderStatus(Integer orderIdx, String orderNumber);
	public boolean cancelOrder(Integer orderIdx);
	public List<OrderVO> getOrderDetail(int orderIdx);
    public List<OrderVO> getUserOrderList(int userIdx, String startOrder, String endOrder, String conditionOrderStatus, PageVO pageVO);
	public List<OrderVO> getOrderByUserIdx(int userIdx);
	public List<OrderVO> getRecentOrders(int userIdx, int limit);
	public OrderVO getOrderDetails(String orderNumber, int userIdx);
	public List<OrderProductVO> getOrderItems(String orderNumber);
}
