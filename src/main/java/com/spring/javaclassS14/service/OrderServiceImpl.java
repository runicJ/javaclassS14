package com.spring.javaclassS14.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.javaclassS14.dao.OrderDAO;
import com.spring.javaclassS14.vo.CartItem;
import com.spring.javaclassS14.vo.CartVO;
import com.spring.javaclassS14.vo.OrderProductVO;
import com.spring.javaclassS14.vo.OrderVO;
import com.spring.javaclassS14.vo.PageVO;
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
    	orderDAO.setOrder(orderVO);
        System.out.println("🛠 생성된 orderIdx: " + orderVO.getOrderIdx()); // 디버깅 로그 추가
        return orderVO.getOrderIdx();
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
	public void setOrderProduct(OrderProductVO vo) {
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

	@Override
	public Integer getUserOrderCnt(Integer userIdx) {
		return orderDAO.getUserOrderCnt(userIdx);
	}

	@Transactional
	@Override
	public boolean updateOrderStatus(Integer orderIdx, String orderNumber) {
	    String currentStatus;
	    
	    // orderIdx 또는 orderNumber 중 하나를 기준으로 상태 조회
	    if (orderIdx != null) {
	        currentStatus = orderDAO.getOrderStatus(orderIdx);
	    } else if (orderNumber != null) {
	        currentStatus = orderDAO.getOrderStatusByNumber(orderNumber);
	    } else {
	        throw new IllegalArgumentException("orderIdx 또는 orderNumber 둘 중 하나는 필요합니다.");
	    }

	    if (currentStatus == null) {
	        throw new IllegalArgumentException("해당 주문이 존재하지 않습니다.");
	    }

	    String nextStatus = getNextStatus(currentStatus);
	    if (nextStatus == null) {
	        throw new IllegalStateException("현재 상태에서는 더 이상 변경할 수 없습니다.");
	    }
		
	    // DAO 호출 주문 상태 업데이트
	    int updatedRows;
	    if(orderIdx != null) {
	    	updatedRows = orderDAO.updateOrderStatus(orderIdx, nextStatus);
	    }
	    else {
	    	updatedRows = orderDAO.updateOrderStatusByNumber(orderNumber, nextStatus);
	    }
	    
	    return updatedRows > 0;
	}
	
	// 주문 상태 변경 흐름
	private String getNextStatus(String currentStatus) {
		switch(currentStatus) {
			case "주문":
				return "배송 준비 중";
			case "배송 준비 중":
				return "배송 중";
			case "배송 중":
				return "배송 완료";
			case "배송 완료":
				return "구매 확정";
			default:
				return null;
		}
	}

	@Transactional
	@Override
	public boolean cancelOrder(Integer orderIdx) {
		String currentStatus = orderDAO.getOrderStatus(orderIdx);
		
		if(currentStatus == null) {
			throw new IllegalArgumentException("해당 주문이 존재하지 않습니다.");
		}
		
		// 취소 가능한 상태인지 확인
		if (!isCancellable(currentStatus)) {
			throw new IllegalStateException("현재 상태에서는 주문을 취소할 수 없습니다.");
		}
		
		// 주문 취소 (orderStatus = "취소됨"으로 변경)
		int updateRows = orderDAO.cancelOrder(orderIdx);
		
		return updateRows > 0;  // 변경된 행이 1개 이상이면 true 반환
	}
	
	// 취소 가능한 상태인지 확인하는 메서드
	private boolean isCancellable(String currentStatus) {
		return currentStatus.equals("주문") || currentStatus.equals("배송 준비 중");
	}

	@Override
	public List<OrderVO> getOrderDetail(int orderIdx) {
		return orderDAO.getOrderDetail(orderIdx);
	}

	@Override
    public List<OrderVO> getUserOrderList(int userIdx, String startOrder, String endOrder, String conditionOrderStatus, PageVO pageVO) {
        // **DAO에서 주문 목록 가져오기**
        List<OrderVO> orders = orderDAO.getUserOrders(userIdx, startOrder, endOrder, conditionOrderStatus, pageVO.getStartIndexNo(), pageVO.getPageSize());

        // **각 주문에 대한 상품 목록 추가**
        for (OrderVO order : orders) {
            List<OrderProductVO> orderProducts = orderDAO.getOrderProducts(order.getOrderIdx());
            order.setOrderProducts(orderProducts);
        }

        return orders;
    }

	@Override
	public List<OrderVO> getOrderByUserIdx(int userIdx) {
		return orderDAO.getOrderByUserIdx(userIdx);
	}

	@Override
	public List<OrderVO> getRecentOrders(int userIdx, int limit) {
		return orderDAO.getRecentOrders(userIdx, limit);
	}

	@Override
	public OrderVO getOrderDetails(String orderNumber, int userIdx) {
		return orderDAO.getOrderDetails(orderNumber, userIdx);
	}

	@Override
	public List<OrderProductVO> getOrderItems(String orderNumber) {
		return orderDAO.getOrderItems(orderNumber);
	}
}
