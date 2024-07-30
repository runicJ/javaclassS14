package com.spring.javaclassS14.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS14.dao.OrderDAO;
import com.spring.javaclassS14.vo.CartItem;
import com.spring.javaclassS14.vo.CartVO;
import com.spring.javaclassS14.vo.OrderVO;

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
    public void setOrder(OrderVO orderVO) {
        orderDAO.setOrder(orderVO);
    }

    @Override
    public void setCartDeleteAll(int orderProductIdx) {
        orderDAO.setCartDeleteAll(orderProductIdx);
    }

    @Override
    public void setDelivery(OrderVO orderVO) {
        orderDAO.setDelivery(orderVO);
    }

    @Override
    public void setUserPointPlus(int point, String userId) {
        orderDAO.setUserPointPlus(point, userId);
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
	public List<OrderVO> getMyOrderList(int startIndexNo, int pageSize, String mid) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<OrderVO> getMyOrderStatus(int startIndexNo, int pageSize, String mid, String startJumun,
			String endJumun, String conditionOrderStatus) {
		// TODO Auto-generated method stub
		return null;
	}

    @Override
    public List<CartItem> getCartItemsByCartIdx(int cartIdx) {
        return orderDAO.getCartItemsByCartIdx(cartIdx);
    }

	@Override
	public OrderVO getOrderCheck(String userId, int productIdx) {
        return orderDAO.getOrderCheck(userId, productIdx);
	}
}
