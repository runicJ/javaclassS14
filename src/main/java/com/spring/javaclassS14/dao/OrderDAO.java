package com.spring.javaclassS14.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS14.vo.CartItem;
import com.spring.javaclassS14.vo.CartVO;
import com.spring.javaclassS14.vo.OrderVO;
import com.spring.javaclassS14.vo.PaymentVO;

public interface OrderDAO {
	
    public OrderVO getOrderMaxIdx();
    public CartVO getCartIdx(@Param("cartIdx") int cartIdx);
    public void setOrder(@Param("orderVO") OrderVO orderVO);
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
    public List<OrderVO> getMyOrderStatus(int startIndexNo, int pageSize, int userIdx, String startOrder, String endOrder, String conditionOrderStatus);

}
