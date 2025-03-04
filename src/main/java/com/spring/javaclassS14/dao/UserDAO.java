package com.spring.javaclassS14.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS14.vo.DeliveryAddressVO;
import com.spring.javaclassS14.vo.OrderVO;
import com.spring.javaclassS14.vo.SaveInterestVO;
import com.spring.javaclassS14.vo.UserVO;

public interface UserDAO {

	public UserVO getUserIdCheck(@Param("userId") String userId);

	public UserVO getUserNickCheck(@Param("nickName") String nickName);

	public UserVO getUserCheck(@Param("name") String name, @Param("email") String email);

	public int setUserRegisterOk(@Param("vo") UserVO vo);

	public UserVO getUserNickNameEmailCheck(@Param("nickName") String nickName, @Param("email") String email);

	public void setKakaoUserInput(@Param("userId") String userId, @Param("userPwd") String pwd, @Param("nickName") String nickName, @Param("email") String email);

	public void setUserPwdUpdate(@Param("userId") String userId, @Param("userPwd") String tempPwd);

	public int setUserDelete(@Param("userIdx") int userIdx, @Param("deleteReason") String deleteReason);

	public int totRecCnt();

	public int recentLog(@Param("userIdx") int userIdx);
	
	public void setUserLog(@Param("userIdx") int userIdx, @Param("hostIp") String hostIp);

	public void insertDeletedUser(@Param("userIdx") int userIdx, @Param("deleteReason") String deleteReason);

	public void updateDeletedUser(@Param("userId") String userId);

	public void cancelUserDelete(@Param("userId") String userId);

	public int setUserUpdate(@Param("vo") UserVO vo);

	public int totRecCntKeyword(@Param("keyword") String keyword);

	public int totRecCntOption(Map<String, Object> paramMap);

	public int getUserEmailCheck(@Param("email") String email);

	public int setUpdateUser(@Param("vo") UserVO vo);

	public List<OrderVO> getRecentOrders(@Param("userIdx") int userIdx);

	public List<SaveInterestVO> getLikedProducts(@Param("userIdx") int userIdx);

	public List<Map<String, Object>> getRecentViewProduct(@Param("userIdx") int userIdx);

	public Integer getUserCouponCnt(@Param("userIdx") int userIdx);

	public Integer getUserPointCnt(@Param("userIdx") int userIdx);

	public Integer getLikedCnt(@Param("userIdx") int userIdx);

	public List<DeliveryAddressVO> getUserDeliveryAddresses(@Param("userIdx") int userIdx);  // 배송지 목록 가져오기

	public int countUserAddresses(int userIdx);  // 배송지 갯수 확인

	public void resetDefaultAddress(int userIdx);  // 기존 대표 배송지 해제

	public boolean insertAddress(DeliveryAddressVO addressVO);  // 배송지 추가

	public DeliveryAddressVO findAddressById(Long addressId);  // 특정 배송지 조회

	public boolean deleteAddress(int addressId);  // 배송지 삭제

	public boolean setDefaultAddress(int addressId);  // 대표 배송지 설정

	public int getUserIdxByAddressId(int addressId);

	public List<DeliveryAddressVO> getUserAddresses(int userIdx);

}
