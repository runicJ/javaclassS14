package com.spring.javaclassS14.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.expression.ParseException;
import org.springframework.stereotype.Service;

import com.spring.javaclassS14.dao.IntroDAO;
import com.spring.javaclassS14.vo.AirVO;
import com.spring.javaclassS14.vo.BranchVO;
import com.spring.javaclassS14.vo.SaveMypageVO;

@Service
public class IntroServiceImpl implements IntroService {

	@Autowired
	IntroDAO introDAO;

	@Override
	public List<BranchVO> getBranchList() {
		return introDAO.getBranchList();
	}

	@Override
	public List<SaveMypageVO> findTopNews(int limit) {
        return introDAO.findTopNews(limit);
	}

	@Override
	public List<String> getMenuOptions() {
        return introDAO.getMenuOptions();
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
	
}
