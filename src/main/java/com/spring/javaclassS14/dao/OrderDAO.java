package com.spring.javaclassS14.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS14.vo.CartItem;
import com.spring.javaclassS14.vo.CartVO;
import com.spring.javaclassS14.vo.OrderVO;
import com.spring.javaclassS14.vo.PaymentVO;

public interface OrderDAO {
	
    public OrderVO getOrderMaxIdx();
    public CartVO getCartIdx(@Param("cartIdx") int cartIdx);
    public int setOrder(OrderVO orderVO);
    public void setCartDeleteAll(@Param("cartIdx") int cartIdx);
    public void setDelivery(@Param("orderVO") OrderVO orderVO);
    public void setUserPointPlus(@Param("point") int point, @Param("userIdx") int userIdx);
    public List<OrderVO> getOrderDelivery(@Param("orderIdx") String orderIdx);
    public int getTotalDeleveryOrder(@Param("orderIdx") int orderIdx);
    public List<CartItem> getCartItemsByCartIdx(@Param("cartIdx") int cartIdx);
	public OrderVO getOrderCheck(@Param("userId") String userId, int productIdx);
	public List<OrderVO> getOrderList();
    public PaymentVO getPaymentByOrderIdx(@Param("orderIdx") String orderIdx);
	public int totRecCntMyOrder(@Param("userIdx") int userIdx);
    public List<OrderVO> getMyOrderStatus(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("userIdx") int userIdx, @Param("startOrder") String startOrder, @Param("endOrder") String endOrder, @Param("conditionOrderStatus") String conditionOrderStatus);
	public void setOrderProduct(@Param("orderVO") OrderVO orderVO);
	public Integer getUserOrderCnt(@Param("userIdx") int userIdx);
	public String getOrderStatus(@Param("orderIdx") Integer orderIdx);
	public String getOrderStatusByNumber(@Param("orderNumber") String orderNumber);
    public int updateOrderStatus(@Param("orderIdx") Integer orderIdx, @Param("nextStatus") String nextStatus);
    public int updateOrderStatusByNumber(@Param("orderNumber") String orderNumber, @Param("nextStatus") String nextStatus);
}
