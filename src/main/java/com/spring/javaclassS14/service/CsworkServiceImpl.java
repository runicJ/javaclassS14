package com.spring.javaclassS14.service;

import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.imageio.ImageIO;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.expression.ParseException;
import org.springframework.stereotype.Service;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.spring.javaclassS14.common.AllProvide;
import com.spring.javaclassS14.dao.CsworkDAO;
import com.spring.javaclassS14.vo.AirVO;
import com.spring.javaclassS14.vo.BranchVO;
import com.spring.javaclassS14.vo.CsworkVO;
import com.spring.javaclassS14.vo.SaveInterestVO;

@Service
public class CsworkServiceImpl implements CsworkService {

	@Autowired
	CsworkDAO csworkDAO;
	
	@Autowired
	AllProvide allProvide;

	@Override
	public List<BranchVO> getBranchList() {
		return csworkDAO.getBranchList();
	}

	@Override
	public List<SaveInterestVO> findTopNews(int limit) {
        return csworkDAO.findTopNews(limit);
	}

	@Override
	public List<String> getMenuOptions() {
        return csworkDAO.getMenuOptions();
	}

	@Override
	public List<AirVO> getAirInfo() {
		List<AirVO> airVOS = new ArrayList<AirVO>();
		StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty");
		try {
	        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=otJChM%2F2%2FlhEU46DhF2TXCxo%2FN9BNwpNNkd7XGrlrOdggtMr%2FDciosXbEvJ4D4KWcS5sjYmneyYHiQSWh%2ByUMQ%3D%3D"); /*Service Key*/
	        urlBuilder.append("&" + URLEncoder.encode("returnType","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*xml 또는 json*/
	        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한 페이지 결과 수*/
	        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
	        urlBuilder.append("&" + URLEncoder.encode("stationName","UTF-8") + "=" + URLEncoder.encode("종로구", "UTF-8")); /*측정소 이름*/
	        urlBuilder.append("&" + URLEncoder.encode("dataTerm","UTF-8") + "=" + URLEncoder.encode("DAILY", "UTF-8")); /*요청 데이터기간(1일: DAILY, 1개월: MONTH, 3개월: 3MONTH)*/
	        urlBuilder.append("&" + URLEncoder.encode("ver","UTF-8") + "=" + URLEncoder.encode("1.0", "UTF-8"));
	        urlBuilder.append("&" + URLEncoder.encode("dataTime","UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /*버전별 상세 결과 참고*/
	        urlBuilder.append("&" + URLEncoder.encode("so2Value","UTF-8") + "=" + URLEncoder.encode("", "UTF-8"));
	        urlBuilder.append("&" + URLEncoder.encode("coValue","UTF-8") + "=" + URLEncoder.encode("", "UTF-8"));
	        urlBuilder.append("&" + URLEncoder.encode("o3Value","UTF-8") + "=" + URLEncoder.encode("", "UTF-8"));
	        urlBuilder.append("&" + URLEncoder.encode("no2Value","UTF-8") + "=" + URLEncoder.encode("", "UTF-8"));
	        urlBuilder.append("&" + URLEncoder.encode("pm10Value","UTF-8") + "=" + URLEncoder.encode("", "UTF-8"));
	        //urlBuilder.append("&" + URLEncoder.encode("pm10Value24","UTF-8") + "=" + URLEncoder.encode("", "UTF-8"));
	        urlBuilder.append("&" + URLEncoder.encode("pm25Value","UTF-8") + "=" + URLEncoder.encode("", "UTF-8"));
	        //urlBuilder.append("&" + URLEncoder.encode("pm25Value24","UTF-8") + "=" + URLEncoder.encode("", "UTF-8"));
	        urlBuilder.append("&" + URLEncoder.encode("khaiValue","UTF-8") + "=" + URLEncoder.encode("", "UTF-8"));
	        //urlBuilder.append("&" + URLEncoder.encode("khaiGrade","UTF-8") + "=" + URLEncoder.encode("", "UTF-8"));
	        //urlBuilder.append("&" + URLEncoder.encode("so2Grade","UTF-8") + "=" + URLEncoder.encode("", "UTF-8"));
	        //urlBuilder.append("&" + URLEncoder.encode("coGrade","UTF-8") + "=" + URLEncoder.encode("", "UTF-8"));
	        //urlBuilder.append("&" + URLEncoder.encode("o3Grade","UTF-8") + "=" + URLEncoder.encode("", "UTF-8"));
	        //urlBuilder.append("&" + URLEncoder.encode("no2Grade","UTF-8") + "=" + URLEncoder.encode("", "UTF-8"));
	        //urlBuilder.append("&" + URLEncoder.encode("pm10Grade","UTF-8") + "=" + URLEncoder.encode("", "UTF-8"));
	        //urlBuilder.append("&" + URLEncoder.encode("pm25Grade","UTF-8") + "=" + URLEncoder.encode("", "UTF-8"));
	        //urlBuilder.append("&" + URLEncoder.encode("pm10Grade1h","UTF-8") + "=" + URLEncoder.encode("", "UTF-8"));
	        //urlBuilder.append("&" + URLEncoder.encode("pm25Grade1h","UTF-8") + "=" + URLEncoder.encode("", "UTF-8"));
	        URL url = new URL(urlBuilder.toString());
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Content-type", "application/json");
	        //System.out.println("Response code: " + conn.getResponseCode());
	        BufferedReader rd;
	        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }
	        
	        StringBuilder sb = new StringBuilder();
	        
	        String line;
	        while ((line = rd.readLine()) != null) {
	            sb.append(line);
	        }
	        rd.close();
	        conn.disconnect();
	        //System.out.println("toString" + sb.toString());
	        
	        String str = sb.substring(sb.indexOf("["));
	        JSONArray jsonArray = new JSONArray(str);  // 넘어오는 값들을 JSON배열로 담기위해 선언
		    for (int i = 0; i < jsonArray.length(); i++) {  // 배열안의 개수만큼 vos객체에 담아준다.
		      JSONObject jsonObject = jsonArray.getJSONObject(i);
		      AirVO airVO = new AirVO();
		      airVO.setDataTime(jsonObject.getString("dataTime"));
		      airVO.setSo2Value(jsonObject.getString("so2Value"));
		      airVO.setCoValue(jsonObject.getString("coValue"));
		      airVO.setO3Value(jsonObject.getString("o3Value"));
		      airVO.setNo2Value(jsonObject.getString("no2Value"));
		      airVO.setPm10Value(jsonObject.getString("pm10Value"));
		      //airVO.setPm10Value24(jsonObject.getString("pm10Value24"));
		      airVO.setPm25Value(jsonObject.getString("pm25Value"));
		      //airVO.setPm25Value24(jsonObject.getString("pm25Value24"));
		      airVO.setKhaiValue(jsonObject.getString("khaiValue"));
		      //airVO.setKhaiGrade(jsonObject.getString("khaiGrade"));
		      //airVO.setSo2Grade(jsonObject.getString("so2Grade"));
		      //airVO.setCoGrade(jsonObject.getString("coGrade"));
		      //airVO.setO3Grade(jsonObject.getString("o3Grade"));
		      //airVO.setNo2Grade(jsonObject.getString("no2Grade"));
		      //airVO.setPm10Grade(jsonObject.getString("pm10Grade"));
		      //airVO.setPm25Grade(jsonObject.getString("pm25Grade"));
		      //airVO.setPm10Grade1h(jsonObject.getString("pm10Grade1h"));
		      //airVO.setPm25Grade1h(jsonObject.getString("pm25Grade1h"));
		      airVOS.add(airVO);
		    }
		} catch (UnsupportedEncodingException e) {e.printStackTrace();
		} catch (MalformedURLException e) {e.printStackTrace();
		} catch (IOException e) {e.printStackTrace();} catch (ParseException e) {e.printStackTrace();}
		return airVOS;
    }

	@Override
	public List<CsworkVO> getNoticeList() {
        return csworkDAO.getNoticeList();
	}

	@Override
	public CsworkVO getNoticeInfo(int noticeIdx) {
        return csworkDAO.getNoticeInfo(noticeIdx);
	}

	@Override
	public BranchVO getBranchSearch(String branchName) {
        return csworkDAO.getBranchSearch(branchName);
	}

	@Override
	public int setQnaInput(CsworkVO qnaVO, String sUid) {
	    if (sUid == null || sUid.isEmpty()) {
	        return csworkDAO.insertQnaForGuest(qnaVO);  // 비회원용 SQL 호출
	    } else {
	        qnaVO.setUserId(sUid);
	        return csworkDAO.insertQnaForMember(qnaVO);  // 회원용 SQL 호출
	    }
	}

	@Override
	public int setFaqInput(CsworkVO csworkVO) {
        return csworkDAO.setFaqInput(csworkVO);
	}

	@Override
	public List<CsworkVO> getFaqList() {
        return csworkDAO.getFaqList();
	}

	@Override
	public List<CsworkVO> getFaqTopList() {
        return csworkDAO.getFaqTopList();
	}

	@Override
	public List<CsworkVO> getFaqSearchList(String category, String keyword) {
        return csworkDAO.getFaqSearchList(category, keyword);
	}

    @Override
    public int setBranchInput(String realPath, BranchVO vo) {
    	String qrCodeName = allProvide.newNameCreate(2);
		String qrCodeImage = "";
		
		try {
	        if (vo.getCreateDate() == null) {
	            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	            vo.setCreateDate(sdf.format(new Date()));
	        }
	        
			// QRCode 안의 한글 인코딩
			qrCodeName += vo.getBranchName() + "_" + vo.getCreateDate();
			qrCodeImage = "지점명 : " + vo.getBranchName() + "\n";
			qrCodeImage += "연락처 : " + vo.getBranchTel() + "\n";
			qrCodeImage += "상세주소 : " + vo.getBranchLocation() + "\n";
			qrCodeImage += "위도 : " + vo.getLatitude() + "\n";
			qrCodeImage += "경도 : " + vo.getLongitude() + "\n";
			qrCodeImage += "생성일 : " + vo.getCreateDate().substring(0,10);
			qrCodeImage = new String(qrCodeImage.getBytes("UTF-8"), "ISO-8859-1");
			
			// qr 코드 만들기
			QRCodeWriter qrCodeWriter = new QRCodeWriter();
			BitMatrix bitMatrix = qrCodeWriter.encode(qrCodeImage, BarcodeFormat.QR_CODE, 200, 200); // 점의 밀도 형식  // 바코드 만드는 형식과 똑같이 만듦(구글에서 제공 BarcodeFormat)  // 크기(폭, 높이)
			
			//MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig();  // 기본컬러(글자색:검정,배경색:흰색) => 색을 바꾸려면 여기서 바꾸면 됨 // 점을 그림으로 바꾸는 class
			int qrCodeColor = 0xFF000000;
			int qrCodeBackColor = 0xFFFFFFFF;
			
			MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrCodeColor, qrCodeBackColor);
			BufferedImage buffredImage = MatrixToImageWriter.toBufferedImage(bitMatrix, matrixToImageConfig);  // 랜더링 처리한 qr코드 이미지를 실제 그림으로 꺼냄 // 이미지로 만들어 주겠다 // buffer 이용하는 것이 안정적이라 함
			
			// 랜더링된 QR코드 이미지를 실제 그림파일로 만들어낸다.
			ImageIO.write(buffredImage, "png", new File(realPath + qrCodeName + ".png") );
			
			// QR코드 생성후, 생성된 정보를 DB에 저장시켜준다.
			vo.setQrCode(qrCodeName);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (WriterException e) {
			e.printStackTrace();
		}
		
		return csworkDAO.setBranchInput(vo);
    }

	@Override
	public List<AirVO> getAirStation() {
        return csworkDAO.getAirStation();
	}

	@Override
	public List<AirVO> getAirQuality(String stationName) {
	    List<AirVO> airVOS = new ArrayList<AirVO>();
	    StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty");
	    try {
	        urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=otJChM%2F2%2FlhEU46DhF2TXCxo%2FN9BNwpNNkd7XGrlrOdggtMr%2FDciosXbEvJ4D4KWcS5sjYmneyYHiQSWh%2ByUMQ%3D%3D");
	        urlBuilder.append("&" + URLEncoder.encode("returnType", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"));
	        urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("10", "UTF-8"));
	        urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8"));
	        urlBuilder.append("&" + URLEncoder.encode("stationName", "UTF-8") + "=" + URLEncoder.encode(stationName, "UTF-8"));
	        urlBuilder.append("&" + URLEncoder.encode("dataTerm", "UTF-8") + "=" + URLEncoder.encode("DAILY", "UTF-8"));
	        urlBuilder.append("&" + URLEncoder.encode("ver", "UTF-8") + "=" + URLEncoder.encode("1.0", "UTF-8"));

	        URL url = new URL(urlBuilder.toString());
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Content-type", "application/json");

	        BufferedReader rd;
	        if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }

	        StringBuilder sb = new StringBuilder();
	        String line;
	        while ((line = rd.readLine()) != null) {
	            sb.append(line);
	        }
	        rd.close();
	        conn.disconnect();

	        String str = sb.substring(sb.indexOf("["));
	        JSONArray jsonArray = new JSONArray(str);
	        for (int i = 0; i < jsonArray.length(); i++) {
	            JSONObject jsonObject = jsonArray.getJSONObject(i);
	            AirVO airVO = new AirVO();
	            airVO.setDataTime(jsonObject.getString("dataTime"));
	            airVO.setSo2Value(jsonObject.getString("so2Value"));
	            airVO.setCoValue(jsonObject.getString("coValue"));
	            airVO.setO3Value(jsonObject.getString("o3Value"));
	            airVO.setNo2Value(jsonObject.getString("no2Value"));
	            airVO.setPm10Value(jsonObject.getString("pm10Value"));
	            airVO.setPm25Value(jsonObject.getString("pm25Value"));
	            airVO.setKhaiValue(jsonObject.getString("khaiValue"));
	            airVOS.add(airVO);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return airVOS;
	}

	@Override
	public List<CsworkVO> getQnaList() {
        return csworkDAO.getQnaList();
	}

   @Override
    public void sendQnaResponse(int qnaIdx, String qnaAnswerContent) throws Exception {
        CsworkVO qna = csworkDAO.findById(qnaIdx);

        if (qna == null) {
            throw new Exception("Q&A entry not found.");
        }

        qna.setQnaAnswerContent(qnaAnswerContent);
        qna.setQnaAnswerFlag("y");
        csworkDAO.updateQna(qna);

        // Send response email
        allProvide.mailSend(qna.getEmail(), "안녕하세요 '괄호 안 쉼표'에서 답변드립니다.", qnaAnswerContent);
    }

@Override
public List<BranchVO> getPurchaseList() {
    return csworkDAO.getPurchaseList();
}
}
