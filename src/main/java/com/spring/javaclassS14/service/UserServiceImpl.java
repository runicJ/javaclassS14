package com.spring.javaclassS14.service;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS14.common.AllProvide;
import com.spring.javaclassS14.dao.UserDAO;
import com.spring.javaclassS14.vo.DeliveryAddressVO;
import com.spring.javaclassS14.vo.OrderVO;
import com.spring.javaclassS14.vo.SaveInterestVO;
import com.spring.javaclassS14.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserDAO userDAO;
	
	@Autowired
	AllProvide allProvide;
	
	@Override
	public UserVO getUserIdCheck(String userId) {
		return userDAO.getUserIdCheck(userId);
	}

	@Override
	public UserVO getUserNickCheck(String nickName) {
		return userDAO.getUserNickCheck(nickName);
	}
	
	@Override
	public UserVO getUserCheck(String name, String email) {
		return userDAO.getUserCheck(name, email);
	}

	@Override
	public String fileUpload(MultipartFile fName, String userId, String userImage) {
		UUID uid = UUID.randomUUID();
		String sFileName = userId + "_" + uid.toString().substring(0,8) + "_" + fName.getOriginalFilename();
		
		try {
			allProvide.writeFile(fName, sFileName, "user");
			
			if(!userImage.equals("noImage.png")) allProvide.deleteFile(userImage, "user");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sFileName;
	}

	@Override
	public int setUserRegisterOk(UserVO vo) {
		return userDAO.setUserRegisterOk(vo);
	}

	@Override
	public UserVO getUserNickNameEmailCheck(String nickName, String email) {
		return userDAO.getUserNickNameEmailCheck(nickName, email);
	}

	@Override
	public void setKakaoUserInput(String userId, String pwd, String nickName, String email) {
		userDAO.setKakaoUserInput(userId, pwd, nickName, email);
		
	}

	@Override
	public void setUserPwdUpdate(String userId, String tempPwd) {
		userDAO.setUserPwdUpdate(userId, tempPwd);
	}

    @Override
    @Transactional
    public int setUserDelete(int userIdx, String email, String deleteReason) {
        int res = userDAO.setUserDelete(userIdx, deleteReason);
        if (res != 0) {
            userDAO.insertDeletedUser(userIdx, email, deleteReason);
        }
        return res;
    }


	@Override
	public void setUserLog(Integer userIdx, String hostIp) {
		if (!isLoggedIn(userIdx)) {
			userDAO.setUserLog(userIdx, hostIp);
			System.out.println("로그 기록중...");
		} else {
			System.out.println("이미 로그인 되었습니다.");
		}
	}
	
	@Override
	public boolean isLoggedIn(Integer userIdx) {
		if (userIdx == null) {
			return false;
		}
		return userDAO.recentLog(userIdx) > 0;
	}

    @Override
    public void updateDeletedUser(String userId) {
        userDAO.updateDeletedUser(userId);
    }

    @Override
    public void cancelUserDelete(String userId) {
        userDAO.cancelUserDelete(userId);
    }

	@Override
	public int setUserUpdate(UserVO vo) {
		return userDAO.setUserUpdate(vo);
	}
	
	@Override
	public int setUpdateUser(UserVO vo) {
		return userDAO.setUpdateUser(vo);
	}

	@Override
	public int getUserEmailCheck(String email) {
		return userDAO.getUserEmailCheck(email);
	}

	@Override
	public List<OrderVO> getRecentOrders(Integer userIdx) {
		return userDAO.getRecentOrders(userIdx);
	}

	@Override
	public List<SaveInterestVO> getLikedProducts(Integer userIdx) {
		return userDAO.getLikedProducts(userIdx);
	}

	@Override
	public List<Map<String, Object>> getRecentViewProduct(Integer userIdx) {
        return userDAO.getRecentViewProduct(userIdx);
	}

	@Override
	public Integer getUserCouponCnt(Integer userIdx) {
        return userDAO.getUserCouponCnt(userIdx);
	}

	@Override
	public Integer getUserPointCnt(Integer userIdx) {
        return userDAO.getUserPointCnt(userIdx);
	}

	@Override
	public Integer getLikedCnt(Integer userIdx) {
		return userDAO.getLikedCnt(userIdx);
	}

	@Override
	public List<DeliveryAddressVO> getUserDeliveryAddresses(int userIdx) {
		return userDAO.getUserDeliveryAddresses(userIdx);
	}

	@Override
	public int insertAddress(DeliveryAddressVO address) {
		return userDAO.insertAddress(address);
	}

}
