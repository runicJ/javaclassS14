package com.spring.javaclassS14.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS14.vo.DeliveryAddressVO;
import com.spring.javaclassS14.vo.OrderVO;
import com.spring.javaclassS14.vo.SaveInterestVO;
import com.spring.javaclassS14.vo.UserVO;

public interface UserService {

	public UserVO getUserIdCheck(String userId);

	public UserVO getUserNickCheck(String nickName);

	public String fileUpload(MultipartFile fName, String userId, String userImage);

	public int setUserRegisterOk(UserVO vo);

	public UserVO getUserCheck(String name, String email);

	public UserVO getUserNickNameEmailCheck(String nickName, String email);

	public void setUserPwdUpdate(String userId, String tempPwd);

	public int setUserDelete(int userIdx, String deleteReason);

	public void setUserLog(Integer userIdx, String hostIp);
	
	public void updateDeletedUser(String userIdx);
	
	public void cancelUserDelete(String userId);

	public int setUserUpdate(UserVO vo);

	public int getUserEmailCheck(String email);

	public int setUpdateUser(UserVO userVO);

	boolean isLoggedIn(Integer userIdx);

	public List<OrderVO> getRecentOrders(Integer userIdx);

	public List<SaveInterestVO> getLikedProducts(Integer userIdx);

	public List<Map<String, Object>> getRecentViewProduct(Integer userIdx);

	public Integer getUserCouponCnt(Integer userIdx);

	public Integer getUserPointCnt(Integer userIdx);

	public Integer getLikedCnt(Integer userIdx);

	public List<DeliveryAddressVO> getUserDeliveryAddresses(int userIdx);

	public boolean addAddress(DeliveryAddressVO addressVO);

	public boolean deleteAddress(int id);

	public boolean setDefaultAddress(int id);

	public List<Map<String, Object>> getUserActivity(int userIdx);

	public UserVO handleKakaoLogin(String code, HttpSession session);

	public UserVO handleNaverLogin(String naverId, String email, String nickname);
}
