package com.spring.javaclassS14.controller;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mysql.fabric.Response;
import com.spring.javaclassS14.common.AllProvide;
import com.spring.javaclassS14.pagination.PageProcess;
import com.spring.javaclassS14.service.OrderService;
import com.spring.javaclassS14.service.ShopService;
import com.spring.javaclassS14.service.UserService;
import com.spring.javaclassS14.vo.DeliveryAddressVO;
import com.spring.javaclassS14.vo.OrderVO;
import com.spring.javaclassS14.vo.PageVO;
import com.spring.javaclassS14.vo.SaveInterestVO;
import com.spring.javaclassS14.vo.ShopVO;
import com.spring.javaclassS14.vo.UserVO;

@Controller
@RequestMapping("/users")
public class UserController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	ShopService shopService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	AllProvide allProvide;
	
	@Autowired
	OrderService orderService;
	
    @Autowired
    PageProcess pageProcess;
	
	// 아이디 중복확인 / 찾기
	@ResponseBody
	@RequestMapping(value="/uidCheck", method=RequestMethod.GET)
	public String uidCheckGet(String userId) {
		UserVO vo = userService.getUserIdCheck(userId);
		return vo != null ? "1" : "0";
	}
	
	// 닉네임 중복확인 / 찾기
	@ResponseBody
	@RequestMapping(value="/nickCheck", method=RequestMethod.GET)
	public String nickCheckGet(String nickName) {
		UserVO vo = userService.getUserNickCheck(nickName);
		return vo != null ? "1" : "0";
	}
	
	// 이메일 중복확인 / 찾기
	@ResponseBody
	@RequestMapping(value="/emailCheck", method=RequestMethod.GET)
	public String emailCheckGet(String email, HttpSession session) throws MessagingException {
	    int res = userService.getUserEmailCheck(email);
	    if(res != 0) return "1";
	    else {
	        // 이메일 인증 코드 생성 및 세션에 저장
	        UUID uuid = UUID.randomUUID();
	        String emailKey = uuid.toString().substring(0, 6);
	        session.setAttribute("sEmailKey", emailKey);

	        // 디버깅용(인증 코드 출력)
	        System.out.println("생성된 이메일 인증 코드: " + emailKey);
	        
	        // 이메일로 인증 코드 전송
	        allProvide.mailSend(email, "이메일 인증 코드", "인증 코드: " + emailKey);
	        return "0";
	    }
	}
	
	// 이메일 인증코드 확인하기
	@ResponseBody
	@RequestMapping(value = "/confirmCodeCheck", method = RequestMethod.POST)
	public String emailConfirmCheckPost(@RequestParam("checkKey") String checkKey, HttpSession session) {
	    String emailKey = (String) session.getAttribute("sEmailKey");

	    if (emailKey == null || emailKey.isEmpty()) {
	        return "0";  // 세션이 만료되었거나 인증 코드 없음
	    }

	    return checkKey.equals(emailKey) ? "1" : "0"; // 인증 코드 일치 여부 확인
	}

	//return checkKey.trim().equals(emailKey) ? "1" : "0";
	
	@RequestMapping(value = "/userPolicy", method = RequestMethod.GET)
	public String userPolicyGet() {
		return "users/userPolicy";
	}
	
	// 약관동의(세션 저장)
	@RequestMapping(value="/userPolicy", method=RequestMethod.POST)
	public String userPolicyPost(HttpSession session,
	                             @RequestParam(name="agreeRequired", defaultValue="false") boolean agreeRequired,
	                             @RequestParam(name="agreeOptional", defaultValue="false") boolean agreeOptional) {
	    if (!agreeRequired) {
	        return "redirect:/users/userPolicy?error=required";
	    }

	    session.setAttribute("agreeRequired", agreeRequired);
	    session.setAttribute("agreeOptional", agreeOptional);
	    return "redirect:/users/userRegister";
	}
	
	// 회원가입 페이지로 이동
	@RequestMapping(value="/userRegister", method=RequestMethod.GET)
	public String userRegisterGet(Model model, HttpSession session) {
	    Boolean agreeRequired = (Boolean) session.getAttribute("agreeRequired");

	    if (agreeRequired == null || !agreeRequired) {
	    	return "redirect:/msg/agreeRequiredNo";
	    }

	    Boolean agreeOptional = (Boolean) session.getAttribute("agreeOptional");
	    model.addAttribute("agreeOptional", agreeOptional);

	    return "users/userRegister";
	}
	
	// 회원가입 처리
	@RequestMapping(value="/userRegister", method=RequestMethod.POST)
	public String userRegisterPost(UserVO vo, MultipartFile fName, HttpSession session) {
		if(userService.getUserIdCheck(vo.getUserId()) != null) return "redirect:/msg/uidCheckNo";
		if(userService.getUserNickCheck(vo.getNickName()) != null) return "redirect:/msg/nickCheckNo";

		int emailRes = userService.getUserEmailCheck(vo.getEmail());
	    if (emailRes != 0) {
	        return "redirect:/msg/emailCheckNo";
	    }

		vo.setUserPwd(passwordEncoder.encode(vo.getUserPwd()));
		
		if(!fName.getOriginalFilename().equals("")) vo.setUserImage(userService.fileUpload(fName, vo.getUserId(), ""));
		else vo.setUserImage("noImage.jpg");
		
		// 선택 약관 동의 정보 설정
        boolean agreeOptional = (boolean) session.getAttribute("agreeOptional");
        String policyFlag = (agreeOptional ? "y" : "n");
        vo.setPolicyFlag(policyFlag);
		
		int res = userService.setUserRegisterOk(vo);
		
        if (res != 0) {
            session.removeAttribute("agreeRequired");
            session.removeAttribute("agreeOptional");
            return "redirect:/msg/userRegisterOk";
        } else {
            return "redirect:/msg/userRegisterNo";
        }
	}
	
	// 로그인 페이지로 이동(쿠키에 아이디 저장)
	@RequestMapping(value="/userLogin", method=RequestMethod.GET)
	public String userLoginGet(HttpServletRequest request) {
		
		Cookie[] cookies = request.getCookies();
		
		if(cookies != null) {
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("cUid")) {
					request.setAttribute("userId", cookies[i].getValue());
					break;
				}
			}
		}
		return "users/userLogin";
	}
	
	// 로그인 처리
	@RequestMapping(value="/userLogin", method=RequestMethod.POST)
	public String userLoginPost(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@RequestParam(name="userId", required = false) String userId,
			@RequestParam(name="userPwd", required = false) String userPwd,
			@RequestParam(name="idSave", defaultValue="off", required = false) String idSave,
			RedirectAttributes redirectAttributes) {
		UserVO vo = userService.getUserIdCheck(userId);
		
		// 탈퇴한 상태인지 확인
		if(vo != null && "delete".equals(vo.getUserStatus())) {
			redirectAttributes.addFlashAttribute("error", "이 계정은 탈퇴된 계정입니다.");
			return "redirect:/users/userLogin";
		}
		
		if(vo != null && passwordEncoder.matches(userPwd, vo.getUserPwd())) {
	        // 탈퇴 요청 상태 확인
	        if (vo.isDeleteRequested()) {
	            // 탈퇴 요청 해제
	            userService.cancelUserDelete(vo.getUserId());
	        }
			
			String strLevel = "";
			if(vo.getLevel() == 0) strLevel = "관리자";
			else if(vo.getLevel() == 0.5) strLevel = "귀한분";
			else if(vo.getLevel() == 1) strLevel = "전문가";
			else if(vo.getLevel() == 2) strLevel = "숙련자";
			else if(vo.getLevel() == 3) strLevel = "지식인";
			
			session.setAttribute("sUidx", vo.getUserIdx());
			session.setAttribute("sUid", userId);
			session.setAttribute("sNickName", vo.getNickName());
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("strLevel", strLevel);
			session.setAttribute("sImage", vo.getUserImage());
			
			if(idSave.equals("on")) {
				Cookie cookieUid = new Cookie("cUid", userId);
				cookieUid.setPath("/");
				cookieUid.setMaxAge(60 * 60 * 24 * 7);
				response.addCookie(cookieUid);
			}
			else {
				Cookie[] cookies = request.getCookies();
				if(cookies != null) {
					for(int i=0; i<cookies.length; i++) {
						if(cookies[i].getName().equals("cUid")) {
							cookies[i].setMaxAge(0);
							response.addCookie(cookies[i]);
							break;
						}
					}
				}
			}
			
			// 회원 로그
			Integer userIdx = (Integer) session.getAttribute("sUidx");
			String hostIp = request.getRemoteAddr();
			userService.setUserLog(userIdx, hostIp);
			
			return "redirect:/msg/userLoginOk?uid="+userId;
		}
		else {
			return "redirect:/msg/userLoginNo";
		}
	}
	
	//카카오 로그인
	@RequestMapping(value = "/userKakaoLogin", method = RequestMethod.GET)
	public String kakaoLoginGet(String nickName , String email, String accessToken,
			HttpServletRequest request,
			HttpSession session
		) throws MessagingException {
		
		// 카카오 로그아웃을 위한 카카오앱키를 세션에 저장시켜둔다.
		session.setAttribute("sAccessToken", accessToken);
		
		// 카카오 로그인한 회원인 경우에는 우리 회원인지를 조사한다.(넘어온 이메일을 @를 기준으로 아이디와 분리해서 기존 memeber2테이블의 아이디와 비교한다.)
		UserVO vo = userService.getUserNickNameEmailCheck(nickName, email);
		
		// 현재 카카오로그인에의한 우리회원이 아니였다면, 자동으로 우리회원에 가입처리한다.
		// 필수입력:아이디, 닉네임, 이메일, 성명(닉네임으로 대체), 비밀번호(임시비밀번호 발급처리)
		String newMember = "NO"; // 신규회원인지에 대한 정의(신규회원:OK, 기존회원:NO)
		if(vo == null) {
			// 아이디 결정하기
			String userId = email.substring(0, email.indexOf("@"));
			
			// 만약에 기존에 같은 아이디가 존재한다면 가입처리 불가...
			UserVO vo2 = userService.getUserIdCheck(userId);
			if(vo2 != null) return "redirect:/msg/uidSameSearch";
			
			// 비밀번호(임시비밀번호 발급처리)
			UUID uuid = UUID.randomUUID();
			String pwd = uuid.toString().substring(0,8);
			session.setAttribute("sImsiPwd", pwd);
			
			// 새로 발급된 비밀번호를 암호화 시켜서 db에 저장처리한다.(카카오 로그인한 신입회원은 바로 정회원으로 등업 시켜준다.)
			userService.setKakaoUserInput(userId, passwordEncoder.encode(pwd), nickName, email);
			
			// 새로 발급받은 임시비밀번호를 메일로 전송한다.
			allProvide.mailSend(email, "임시 비밀번호를 발급하였습니다.", pwd);
			
			// 새로 가입처리된 회원의 정보를 다시 vo에 담아준다.
			vo = userService.getUserIdCheck(userId);
			
			// 비밀번호를 새로 발급처리했을때 sLogin세션을 발생시켜주고, memberMain창에 비밀번호 변경메세지를 지속적으로 뿌려준다.
			session.setAttribute("sLogin", "OK");
			
			newMember = "OK";
		}
		
		// 로그인 인증완료시 처리할 부분(1.세션, 3.기타 설정값....)
		// 1.세션처리
		String strLevel = "";
		if(vo.getLevel() == 0) strLevel = "관리자";
		else if(vo.getLevel() == 0.5) strLevel = "귀한분";
		else if(vo.getLevel() == 1) strLevel = "전문가";
		else if(vo.getLevel() == 2) strLevel = "숙련자";
		else if(vo.getLevel() == 3) strLevel = "지식인";
		
		session.setAttribute("sUid", vo.getUserId());
		session.setAttribute("sNickName", vo.getNickName());
		session.setAttribute("sLevel", vo.getLevel());
		session.setAttribute("strLevel", strLevel);
		
		// 로그인 완료후 모든 처리가 끝나면 필요한 메세지처리후 memberMain으로 보낸다.
		if(newMember.equals("NO")) return "redirect:/msg/userLoginOk?uid="+vo.getUserId();
		else return "redirect:/msg/userLoginNewOk?uid="+vo.getUserId();
	}
	
	// 로그아웃 처리
	@RequestMapping(value="/userLogout", method=RequestMethod.GET)
	public String userLogoutGet(HttpSession session) {
		String uid = (String) session.getAttribute("sUid");
		session.invalidate();
		
		return "redirect:/msg/userLogout?uid="+uid;
	}
	
	// 아이디 찾기 팝업 띄우기
	@RequestMapping(value="/userFindId", method=RequestMethod.GET)
	public String userFindIdGet() {
		return "users/userFindId";
	}
	
    // 아이디 찾기
    @ResponseBody
    @RequestMapping(value="/userFindId", method=RequestMethod.POST)
    public Map<String, String> userFindIdPost(String name, String email) {
        Map<String, String> resMap = new HashMap<>();
        UserVO vo = userService.getUserCheck(name, email);
        if(vo != null) {
            resMap.put("res", "1");
            resMap.put("userId", vo.getUserId());
            resMap.put("createDate", vo.getCreateDate().toString().substring(0,10));
        }
        else {
            resMap.put("res", "0");
        }
        return resMap;
    }
	
	// 비밀번호 찾기 팝업 띄우기
	@RequestMapping(value="/userFindPw", method=RequestMethod.GET)
	public String userFindPwGet() {
		return "users/userFindPw";
	}
	
	// 이메일로 임시 비밀번호 발급
	@ResponseBody
	@RequestMapping(value = "/userFindPw", method = RequestMethod.POST)
	public String userTempPwdPost(@RequestParam String userId, @RequestParam String email, HttpSession session) throws MessagingException {
		UserVO vo = userService.getUserIdCheck(userId);
		if(vo != null && vo.getEmail().equals(email)) {
			// 정보 확인 후 정보가 맞으면 임시 비밀번호를 발급 받아서 메일로 전송 처리한다.
			UUID uuid = UUID.randomUUID();
			String tempPwd = uuid.toString().substring(0,8);
			
			userService.setUserPwdUpdate(userId, passwordEncoder.encode(tempPwd));
			
			String today = LocalDateTime.now().toString().substring(0,10) + " " + LocalDateTime.now().toString().substring(11,19);
			// 발급받은 비밀번호를 메일로 전송처리한다.
			String title = vo.getName() + "님 '괄호안쉼표'에서 '"+ today +"'에 임시 비밀번호를 발급받으셨습니다.\n 본인이 아니실 경우 빠른 문의 부탁드립니다.";
			String mailFlag = "임시 비밀번호 : " + tempPwd;
			String res = allProvide.mailSend(email, title, mailFlag);
			
			session.setAttribute("sLogin", "OK");  // 새비밀번호 왔을때만 세션이 생성 -> 다 끝나고 세션 지워버림
			
			if(res == "1") return "1";
		}
		return "0";
	}
	
	// 회원정보 페이지로 이동
	@RequestMapping(value="/userMain", method=RequestMethod.GET)
	public String userMainGet(HttpSession session, Model model) {
		Integer userIdx = (Integer) session.getAttribute("sUidx");
		
		List<OrderVO> orderVOS = userService.getRecentOrders(userIdx);
		List<SaveInterestVO> likedVOS = userService.getLikedProducts(userIdx);
		List<Map<String, Object>> recentProducts = userService.getRecentViewProduct(userIdx);
		
		model.addAttribute("orderVOS", orderVOS);
		model.addAttribute("likedVOS", likedVOS);
		model.addAttribute("recentProducts", recentProducts);
		
		return "users/userMain";
	}
	
	// 회원정보 수정 폼 띄우기
	@RequestMapping(value="/userUpdate", method=RequestMethod.GET)
	public String userUpdateGet(HttpSession session, Model model) {
		String userId = (String) session.getAttribute("sUid");
		UserVO vo = userService.getUserIdCheck(userId);
		
		model.addAttribute("vo", vo);
		
		return "users/userUpdate";
	}
	
	// 회원정보 수정 처리
	@RequestMapping(value="/userUpdate", method=RequestMethod.POST)
	public String userUpdatePost(UserVO vo, MultipartFile fName, HttpSession session,
	        @RequestParam(value="pwdNew", required=false) String pwdNew,
            @RequestParam(value="pwdNewCheck", required=false) String pwdNewCheck,
            @RequestParam(value="nameNew", required=false) String nameNew,
            @RequestParam(value="nickNameNew", required=false) String nickNameNew,
            @RequestParam("policyFlag") String policyFlag) {
		
	    // 세션에서 사용자 아이디를 가져옵니다.
	    String userId = (String) session.getAttribute("sUid");
	    UserVO voBasic = userService.getUserIdCheck(userId);
	    
	    // 닉네임 체크
	    String nickName = (String) session.getAttribute("sNickName");
	    if (nickNameNew != null && !nickNameNew.isEmpty()) {
		    if(userService.getUserNickCheck(nickNameNew) != null && !nickName.equals(nickNameNew)) {
		        return "redirect:/msg/nickCheckNo";
		    }
		    else vo.setNickName(nickNameNew);
	    }
	    else vo.setNickName(null);
	    

	    // 비밀번호 체크
	    if (!passwordEncoder.matches(vo.getUserPwd(), voBasic.getUserPwd())) {
	        return "redirect:/msg/pwdCheckNo";
	    }

	    // 새로운 비밀번호가 있으면 업데이트
	    if (pwdNew != null && !pwdNew.isEmpty()) {
	        if (!pwdNew.equals(pwdNewCheck)) {
	            return "redirect:/msg/pwdNewCheckNo";
	        }
	        vo.setUserPwd(passwordEncoder.encode(pwdNew));
	    } 
	    else {
	        vo.setUserPwd(null); // 기존 비밀번호 유지
	    }
	    
	    if (nameNew != null && !nameNew.isEmpty()) {
	    	vo.setName(nameNew);
	    } else {
	    	vo.setName(null);
	    }
		
		if(fName.getOriginalFilename() != null && !fName.getOriginalFilename().equals("")) {
			vo.setUserImage(userService.fileUpload(fName, vo.getUserId(), vo.getUserImage()));
		}
		
	    vo.setPolicyFlag(policyFlag);

		int res = userService.setUserUpdate(vo);
		if(res != 0) {
			session.setAttribute("sNickName", vo.getNickName());
			session.setAttribute("sImage", vo.getUserImage());
			return "redirect:/msg/userUpdateOk";
		}
		else return "redirect:/msg/userUpdateNo";
	}
	
	// 회원탈퇴 페이지로 이동
	@RequestMapping(value="/userDelete", method=RequestMethod.GET)
	public String userDeleteGet(HttpSession session, Model model) {
		String userId = (String) session.getAttribute("sUid");  // 세션에서 로그인한 사용자 ID 가져오기
		UserVO vo = userService.getUserIdCheck(userId);
		
		if(vo == null) {
			session.invalidate();  // 세션 초기화 (자동 로그아웃)
			
			return "redirect:/msg/userNotFound";  // 사용자가 존재하지 않는 경우 리다이렉트
		}
		
		model.addAttribute("vo", vo);
		return "users/userDelete";
	}
	
	// 회원탈퇴 신청
	@RequestMapping(value="/userDelete", method=RequestMethod.POST)
	public String userDeletePost(HttpSession session, 
			@RequestParam("userPwd") String userPwd,
								@RequestParam("deleteReason") String deleteReason,
								RedirectAttributes redirectAttributes) {
	    String userId = (String) session.getAttribute("sUid");
	    UserVO userVO = userService.getUserIdCheck(userId);
	    
	    if (userVO == null) {
	    	return "redirect:/msg/userNotFound";  // 사용자가 존재하지 않는 경우
	    }
		
	    // 비밀번호 검증
	    if (!passwordEncoder.matches(userPwd, userVO.getUserPwd())) {
	    	//redirectAttributes.addFlashAttribute("error", "비밀번호가 일치하지 않습니다.");
	    	return "0";
	    }
	    
	    // 탈퇴 처리
	    int res = userService.setUserDelete(userVO.getUserIdx(), deleteReason);
		
	    if(res != 0) {
	    	sendDeleteConfirmationEmail(userVO.getEmail());
	    }
	    
		//return res != 0 ? "redirect:/msg/userDeleteOk" : "redirect:/msg/userDeleteNo";
	    return res != 0 ? "1" : "0";
	}
	
	private void sendDeleteConfirmationEmail(String email) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(email);
		message.setSubject("회원 탈퇴 신청 완료 안내");
		message.setText("안녕하세요.\n\n회원님의 탈퇴 신청이 완료되었습니다.\n"
				+ "30일 이내에 로그인하면 탈퇴 신청이 자동으로 취소됩니다.\n"
				+ "30일 후에는 회원 정보가 영구적으로 삭제됩니다.\n\n"
				+ "감사합니다.");
		mailSender.send(message);
	}
	
	// 회원 배송지 리스트
	@RequestMapping(value="/userAddress", method=RequestMethod.GET)
	public String userAddressGet(HttpSession session, Model model) {
		String userId = (String) session.getAttribute("sUid");
		
		// 회원 정보 가져오기
		UserVO userVO = userService.getUserIdCheck(userId);
		
		// 배송지 목록 가져오기
		List<DeliveryAddressVO> addressList = userService.getUserDeliveryAddresses(userVO.getUserIdx());
		
		model.addAttribute("userVO", userVO);
		model.addAttribute("addressList", addressList);
		
		return "users/userAddress";
	}
	
	// 배송지 추가하기
	@PostMapping("/userAddressInput")
	public ResponseEntity<Map<String, String>> addUserAddress(@RequestBody DeliveryAddressVO addressVO, HttpSession session) {
		String userId = (String) session.getAttribute("sUid");
	    UserVO userVO = userService.getUserIdCheck(userId);
		
	    if(userVO == null) {
	    	return ResponseEntity.badRequest().body(Map.of("msg", "로그인이 필요합니다."));
	    }
	    
	    addressVO.setUserIdx(userVO.getUserIdx());
	    
	    // 로그 출력해서 확인 (디버깅)
	    System.out.println("받은 데이터: userIdx=" + addressVO.getUserIdx() + ", address=" + addressVO.getAddress() + ", defaultAddress=" + addressVO.getDefaultAddress());
	    
		boolean success = userService.addAddress(addressVO);
		if(!success) {
			return ResponseEntity.badRequest().body(Map.of("msg", "최대 3개의 주소만 저장할 수 있습니다."));
		}
		return ResponseEntity.ok(Map.of("msg", "배송지가 저장되었습니다."));
	}
	
	// 배송지 삭제
	@PostMapping("/deleteAddress/{id}")
	public ResponseEntity<Map<String, String>> deleteUserAddress(@PathVariable int id) {
		boolean res = userService.deleteAddress(id);
		System.out.println("삭제된 행 수 : " + res);
		
		if (!res) {
			return ResponseEntity.badRequest().body(Map.of("msg", "배송지 삭제 실패"));
		}
		return ResponseEntity.ok(Map.of("msg", "삭제되었습니다."));
	}
	
	// 대표 배송지 설정
	@PostMapping("/setDefaultAddress/{id}")
	public ResponseEntity<Map<String, String>> setDefaultAddress(@PathVariable int id) {
		boolean success = userService.setDefaultAddress(id);
		if(!success) {
			return ResponseEntity.badRequest().body(Map.of("msg", "대표 배송지 설정 실패"));
		}
		return ResponseEntity.ok(Map.of("msg", "대표 배송지가 설정되었습니다."));
	}

    // 나의 주문 내역 및 상태 보기
    @RequestMapping(value = "/myOrderList", method = RequestMethod.GET)
    public String getMyOrder(Model model, HttpServletRequest request, HttpSession session,
                             @RequestParam(required = false) String startOrder,
                             @RequestParam(required = false) String endOrder,
                             @RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
                             @RequestParam(name = "pageSize", defaultValue = "5", required = false) int pageSize,
                             @RequestParam(name = "conditionOrderStatus", defaultValue = "전체", required = false) String conditionOrderStatus) {

        Integer userIdx = (Integer) session.getAttribute("sUidx");
        if (userIdx == null) {
            model.addAttribute("msg", "로그인이 필요합니다. 다시 로그인 해주세요.");
            return "redirect:/user/login";
        }

        // 조건을 '@'로 연결하여 검색 조건으로 사용
        String searchString = (startOrder != null ? startOrder : "") + "@" + 
                              (endOrder != null ? endOrder : "") + "@" + 
                              conditionOrderStatus;

        // 총 레코드 수 및 페이징 정보 계산
        //PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "myOrder", userIdx, searchString);

        // 주문 목록 조회
        //List<OrderVO> vos = orderService.getMyOrderStatus(pageVO.getStartIndexNo(), pageSize, userIdx, startOrder, endOrder, conditionOrderStatus);
        
        // 모델에 조회된 결과 추가
        //model.addAttribute("vos", vos);
        model.addAttribute("startOrder", startOrder);
        model.addAttribute("endOrder", endOrder);
        model.addAttribute("conditionOrderStatus", conditionOrderStatus);
        //model.addAttribute("pageVO", pageVO);

        return "users/userOrderList";
    }
    
    @GetMapping("/userActivity")
    public String getUserActivity(HttpSession session, Model model) {
        Integer userIdx = (Integer) session.getAttribute("sUidx");
        if (userIdx == null) {
			return "redirect:/msg/userLoginNo";
        }

        // 회원 활동 내역 조회 (Map으로 데이터를 전달)
        List<Map<String, Object>> activities = userService.getUserActivity(userIdx);
        model.addAttribute("activities", activities);
        return "users/userActivity";
    }
    
    @GetMapping("/userOrderList")
    public String getOrderList(
        @RequestParam(value = "pag", defaultValue = "1") int pag,
        @RequestParam(name = "pageSize", defaultValue = "5", required = false) int pageSize,
        @RequestParam(name = "conditionOrderStatus", required = false) String conditionOrderStatus,
        //@RequestParam(value = "startOrder", required = false) String startOrder,
        //@RequestParam(value = "endOrder", required = false) String endOrder,
        Model model, HttpSession session) {

        Integer userIdx = (Integer) session.getAttribute("sUidx");
        if (userIdx == null) {
            return "redirect:/msg/userLoginNo";
        }

        // 날짜 기본값 설정
		/*
		 * if (startOrder == null || startOrder.isEmpty()) { startOrder = new
		 * SimpleDateFormat("yyyy-MM-dd").format(new Date()); } if (endOrder == null ||
		 * endOrder.isEmpty()) { endOrder = new
		 * SimpleDateFormat("yyyy-MM-dd").format(new Date()); }
		 */

        PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "myOrder", userIdx, "");

        //List<OrderVO> orderList = orderService.getUserOrderList(userIdx, startOrder, endOrder, conditionOrderStatus, pageVO);
        List<OrderVO> orderList = orderService.getUserOrderList(userIdx, conditionOrderStatus, pageVO);

        model.addAttribute("orderList", orderList);
        model.addAttribute("pageVO", pageVO);
        //model.addAttribute("startOrder", startOrder);
        //model.addAttribute("endOrder", endOrder);
        return "users/userOrderList";
    }

    
    // 유저가 좋아요한 상품 목록 조회
    @GetMapping("/userLiked")
    public String getLikedProducts(HttpSession session, Model model) {
        Integer userIdx = (Integer) session.getAttribute("sUidx");
        if (userIdx == null) {
            return "redirect:/users/userLogin";
        }

        List<ShopVO> likedProducts = shopService.getLikedProducts(userIdx);
        model.addAttribute("likedProducts", likedProducts);
        return "users/userLiked";
    }

    // 좋아요 취소
    @GetMapping("/removeLike")
    public String removeLike(@RequestParam("productIdx") int productIdx, HttpSession session) {
        Integer userIdx = (Integer) session.getAttribute("sUidx");
        int result = shopService.removeLike(userIdx, productIdx);

        if (result > 0) {
            return "users/userMain";
        } else {
            return "users/userLiked"; // 실패 시 에러 페이지
        }
    }
}
