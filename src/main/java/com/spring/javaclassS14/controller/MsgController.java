package com.spring.javaclassS14.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MsgController {

	@RequestMapping(value = "/msg/{msgFlag}", method = RequestMethod.GET)
	public String getMessage(Model model,
			@PathVariable String msgFlag,
			@RequestParam(name="uid", defaultValue="", required=false) String uid,
			@RequestParam(name="tempFlag", defaultValue = "", required = false) String tempFlag,
			@RequestParam(name="idx", defaultValue = "", required = false) String idx,
			@RequestParam(name="pag", defaultValue = "1", required = false) String pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) String pageSize
		) {
		if(msgFlag.equals("uidCheckNo")) {
			model.addAttribute("msg", "이미 사용중인 아이디 입니다.");
			model.addAttribute("url", "/users/userRegister");
		}
		else if(msgFlag.equals("nickCheckNo")) {
			model.addAttribute("msg", "이미 사용중인 닉네임입니다.");
			model.addAttribute("url", "/users/userRegister");
		}
		else if(msgFlag.equals("pwdCheckNo")) {
			model.addAttribute("msg", "비밀번호가 올바르지 않습니다. 확인 후에 다시 시도해주세요!");
			model.addAttribute("url", "/users/userUpdate");
		}
		else if(msgFlag.equals("pwdCheckNo")) {
			model.addAttribute("msg", "입력하신 새 비밀번호를 확인해주세요.");
			model.addAttribute("url", "/users/userUpdate");
		}
		else if(msgFlag.equals("emailCheckNo")) {
			model.addAttribute("msg", "이미 사용중인 이메일입니다.");
			model.addAttribute("url", "/users/userRegister");
		}
		else if(msgFlag.equals("agreeRequiredNo")) {
			model.addAttribute("msg", "잘못된 접근입니다! 필수 조항에 동의 후 회원가입이 가능합니다.");
			model.addAttribute("url", "/users/userPolicy");
		}
		else if(msgFlag.equals("userRegisterOk")) {
			model.addAttribute("msg", "회원가입이 완료되었습니다. 로그인 페이지로 이동합니다!");
			model.addAttribute("url", "/users/userLogin");
		}
		else if(msgFlag.equals("userRegisterNo")) {
			model.addAttribute("msg", "회원가입에 실패하였습니다.");
			model.addAttribute("url", "/users/userRegister");
		}
		else if(msgFlag.equals("userLoginOk")) {
			model.addAttribute("msg", uid+" 님 환영합니다!");
			model.addAttribute("url", "/main");
		}
		else if(msgFlag.equals("userLoginNo")) {
			model.addAttribute("msg", "아이디 또는 비밀번호를 확인해 주세요!");
			model.addAttribute("url", "/users/userLogin");
		}
		else if(msgFlag.equals("userUpdateOk")) {
			model.addAttribute("msg", "회원정보 수정이 완료되었습니다. \\n로그인 페이지로 이동합니다!");
			model.addAttribute("url", "/users/userLogin");
		}
		else if(msgFlag.equals("userUpdateNo")) {
			model.addAttribute("msg", "회원정보 수정에 실패하였습니다. \\n 확인 후에 다시 시도해 주세요.");
			model.addAttribute("url", "/users/userUpdate");
		}
		else if(msgFlag.equals("userDeleteOk")) {
			model.addAttribute("msg", "회원탈퇴가 완료되었습니다. \\n 저희 사이트를 이용해 주셔서 감사합니다.");
			model.addAttribute("url", "/main");
		}
		else if(msgFlag.equals("userDeleteNo")) {
			model.addAttribute("msg", "회원탈퇴 실패! \\n 확인 후에 다시 시도해 주세요.");
			model.addAttribute("url", "/users/userDelete");
		}
		else if(msgFlag.equals("userNotFound")) {
			model.addAttribute("msg", "회원 정보를 찾을 수 없습니다. \\n 다시 로그인해 주세요.");
			model.addAttribute("url", "/users/userLogin");
		}
		else if(msgFlag.equals("userLogout")) {
			model.addAttribute("msg", uid+" 님 로그아웃이 정상적으로 처리되었습니다.");
			model.addAttribute("url", "/users/userLogin");
		}
		else if(msgFlag.equals("uidSameSearch")) {
			model.addAttribute("msg", "같은 아이디를 가진 회원이 존재합니다. \\n아이디 확인 후 다시 회원가입을 시도해 주세요.");
			model.addAttribute("url", "/users/userLogin");
		}
		else if(msgFlag.equals("userLoginNewOk")) {
			model.addAttribute("msg", uid+" 님 로그인 되셨습니다.\\n신규 비밀번호가 발급되었습니다. 확인 후 회원정보를 변경해주세요.");
			model.addAttribute("url", "users/userMain");
		}
		else if(msgFlag.equals("adminNo")) {
			model.addAttribute("msg", "관리자만 접속하실 수 있습니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("userNo")) {
			model.addAttribute("msg", "회원 로그인 후 이용가능합니다.");
			model.addAttribute("url", "/users/userLogin");
		}
		else if(msgFlag.equals("userLevelNo")) {
			model.addAttribute("msg", "회원 등급을 확인하세요.");
			model.addAttribute("url", "/users/userMain");
		}
		else if(msgFlag.equals("userAdminNo")) {
			model.addAttribute("msg", "오직 관리자만 접근 가능한 페이지입니다. 계정을 확인해 주세요!");
			model.addAttribute("url", "/users/userLogout");
		}
		else if(msgFlag.equals("productInputOk")) {
			model.addAttribute("msg", "상품이 등록되었습니다.");
			model.addAttribute("url", "/admin/shop/productList");
		}
		else if(msgFlag.equals("productInputNo")) {
			model.addAttribute("msg", "상품 등록 실패~~");
			model.addAttribute("url", "/admin/shop/productInput");
		}
		else if(msgFlag.equals("optionGroupInputOk")) {
			model.addAttribute("msg", "해당 상품의 옵션그룹 항목이 등록되었습니다.");
			model.addAttribute("url", "/admin/shop/productOption?productName="+tempFlag);
		}
		else if(msgFlag.equals("optionGroupInputNo")) {
			model.addAttribute("msg", "옵션그룹 등록 실패~~");
			model.addAttribute("url", "/admin/shop/productOption?productName="+tempFlag);
		}
		else if(msgFlag.equals("optionGroupSame")) {
			model.addAttribute("msg", "해당 상품에 동일한 옵션그룹이 있습니다. 확인 후 다시 시도해주세요!");
			model.addAttribute("url", "/admin/shop/productOption");
		}
		else if(msgFlag.equals("optionInputOk")) {
			model.addAttribute("msg", "해당 옵션그룹의 항목이 등록되었습니다.");
			model.addAttribute("url", "/admin/shop/productOption?productName="+tempFlag);
		}
		else if(msgFlag.equals("optionInputNo")) {
			model.addAttribute("msg", "옵션 등록 실패~~");
			model.addAttribute("url", "/admin/shop/productOption?productName="+tempFlag);
		}
		else if(msgFlag.equals("cartOrderOk")) {
			model.addAttribute("msg", "장바구니에 상품이 등록되었습니다.\\n주문창으로 이동합니다.");
			model.addAttribute("url", "/shop/productCart");
		}
		else if(msgFlag.equals("cartOrderNo")) {
			model.addAttribute("msg", "장바구니에 상품 등록실패");
			model.addAttribute("url", "/shop/productCart");
		}
		else if(msgFlag.equals("cartInputOk")) {
			model.addAttribute("msg", "장바구니에 상품이 등록되었습니다.\\n즐거운 쇼핑되세요.");
			model.addAttribute("url", "/shop/productList");
		}
		else if(msgFlag.equals("cartEmpty")) {
			model.addAttribute("msg", "장바구니가 비어있습니다.");
			model.addAttribute("url", "/shop/productList");
		}
		else if(msgFlag.equals("paymentResultOk")) {
			model.addAttribute("msg", "결제가 성공적으로 완료되었습니다.");
			model.addAttribute("url", "/order/paymentResultOk");
		}
		else if(msgFlag.equals("noticeInputOk")) {
			model.addAttribute("msg", "공지사항이 등록되었습니다.");
			model.addAttribute("url", "/admin/adminMain");
		}
		else if(msgFlag.equals("noticeInputNo")) {
			model.addAttribute("msg", "공지 등록 실패!");
			model.addAttribute("url", "/admin/info/noticeInput");
		}
		else if(msgFlag.equals("surveyAnswerOk")) {
			model.addAttribute("msg", "설문응답이 완료되었습니다. 이벤트에 응모하시려면 댓글을 남겨주세요!");
			model.addAttribute("url", "/survey/surveyList");
		}
		else if(msgFlag.equals("surveyAnswerNo")) {
			model.addAttribute("msg", "설문응답 등록 실패했습니다. 다시 시도해 주세요..");
			model.addAttribute("url", "/survey/surveyList");
		}
		else if(msgFlag.equals("branchInputOk")) {
			model.addAttribute("msg", "지점등록이 완료되었습니다!");
			model.addAttribute("url", "/cswork/branchMap");
		}
		else if(msgFlag.equals("branchInputNo")) {
			model.addAttribute("msg", "지점 등록 실패!");
			model.addAttribute("url", "/admin/info/branchInput");
		}
		else if(msgFlag.equals("qnaInputOk")) {
			model.addAttribute("msg", "문의사항이 접수되었습니다.");
			model.addAttribute("url", "/main");
		}
		else if(msgFlag.equals("qnaInputNo")) {
			model.addAttribute("msg", "문의 접수에 실패하였습니다 다시 시도해주세요.");
			model.addAttribute("url", "/cswork/qna/qnaApply");
		}
		else if(msgFlag.equals("adminUserUpdateOK")) {
			model.addAttribute("msg", "회원정보 수정이 완료되었습니다. 관리자님.");
			model.addAttribute("url", "/admin/user/userList");
		}
		else if(msgFlag.equals("adminUserUpdateNO")) {
			model.addAttribute("msg", "회원정보 수정 실패! 다시 시도해 주세요!");
			model.addAttribute("url", "/admin/user/userList");
		}
		else if(msgFlag.equals("productCartEmpty")) {
			model.addAttribute("msg", "선택된 주문 상품이 없습니다.");
			model.addAttribute("url", "/shop/productList");
		}
		else if(msgFlag.equals("paymentError")) {
			model.addAttribute("msg", "유효하지 않은 결제 정보입니다.");
			model.addAttribute("url", "/shop/productList");
		}
		else if(msgFlag.equals("photoReviewInputOk")) {
		    model.addAttribute("msg", "포토리뷰가 정상적으로 등록되었습니다!");
		    model.addAttribute("url", "/photoReview/photoReviewList");
		}
		else if(msgFlag.equals("photoReviewInputNo")) {
		    model.addAttribute("msg", "포토리뷰 등록에 실패하였습니다. 다시 시도해주세요.");
		    model.addAttribute("url", "/photoReview/photoReviewInput");
		}
		
	return "include/msg";
	}
}