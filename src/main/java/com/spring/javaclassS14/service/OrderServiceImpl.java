package com.spring.javaclassS14.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS14.dao.OrderDAO;
import com.spring.javaclassS14.vo.CartItem;
import com.spring.javaclassS14.vo.CartVO;
import com.spring.javaclassS14.vo.OrderVO;
import com.spring.javaclassS14.vo.PaymentVO;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	OrderDAO orderDAO;

    @Override
    public OrderVO getOrderMaxIdx() {
        return orderDAO.getOrderMaxIdx();
    }
    
    @Override
    public CartVO getCartIdx(int cartIdx) {
        return orderDAO.getCartIdx(cartIdx);
    }

    @Override
    public int setOrder(OrderVO orderVO) {
    	return orderDAO.setOrder(orderVO);
    }
	 

    @Override
    public void setCartDeleteAll(int cartIdx) {
        orderDAO.setCartDeleteAll(cartIdx);
    }

    @Override
    public void setDelivery(OrderVO orderVO) {
        orderDAO.setDelivery(orderVO);
    }

    @Override
    public void setUserPointPlus(int point, int userIdx) {
        orderDAO.setUserPointPlus(point, userIdx);
    }

    @Override
    public List<OrderVO> getOrderDelivery(String orderIdx) {
        return orderDAO.getOrderDelivery(orderIdx);
    }

    @Override
    public int getTotalDeleveryOrder(int orderIdx) {
        return orderDAO.getTotalDeleveryOrder(orderIdx);
    }

    @Override
    public List<CartItem> getCartItemsByCartIdx(int cartIdx) {
        return orderDAO.getCartItemsByCartIdx(cartIdx);
    }

	@Override
	public OrderVO getOrderCheck(String userId, int productIdx) {
        return orderDAO.getOrderCheck(userId, productIdx);
	}

	@Override
	public List<OrderVO> getOrderList() {
        return orderDAO.getOrderList();
	}

	@Override
	public void setOrderProduct(OrderVO vo) {
		orderDAO.setOrderProduct(vo);
	}

	@Override
	public PaymentVO getPaymentByOrderIdx(String orderIdx) {
		return orderDAO.getPaymentByOrderIdx(orderIdx);
	}

	@Override
	public List<OrderVO> getMyOrderStatus(int startIndexNo, int pageSize, int userIdx, String startOrder,
			String endOrder, String conditionOrderStatus) {
		return orderDAO.getMyOrderStatus(startIndexNo, pageSize, userIdx, startOrder, endOrder, conditionOrderStatus);
	}
}
