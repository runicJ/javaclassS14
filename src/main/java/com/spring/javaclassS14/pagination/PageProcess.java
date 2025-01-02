package com.spring.javaclassS14.pagination;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS14.dao.OrderDAO;
import com.spring.javaclassS14.dao.ShopDAO;
import com.spring.javaclassS14.dao.UserDAO;
import com.spring.javaclassS14.vo.PageVO;

@Service
public class PageProcess {

    @Autowired
    UserDAO userDAO;
    
    @Autowired
    ShopDAO shopDAO;
    
    @Autowired
    OrderDAO orderDAO;

    public PageVO totRecCnt(int pag, int pageSize, String section, Object parameter, String searchString) {
        PageVO pageVO = new PageVO();
        int totRecCnt = 0;
        Map<String, Object> paramMap = prepareSortOption(parameter, searchString);

        switch (section) {
            case "user":
                if (searchString != null && !searchString.isEmpty()) {
                    totRecCnt = userDAO.totRecCntKeyword(searchString);
                } 
                else if (!paramMap.isEmpty()) {
                    totRecCnt = userDAO.totRecCntOption(paramMap);
                } 
                else {
                    totRecCnt = userDAO.totRecCnt();
                }
                break;

            case "product":
                if (searchString != null && !searchString.isEmpty()) {
                    totRecCnt = shopDAO.totRecCntKeyword(searchString);
                }
                else if (!paramMap.isEmpty()) {
                    totRecCnt = shopDAO.totRecCntOption(paramMap);
                }
                else {
                    totRecCnt = shopDAO.totRecCnt();
                }
                break;

            case "myOrder":
                totRecCnt = orderDAO.totRecCntMyOrder((Integer) parameter);
                break;
                
            case "qna":
            	break;

            default:
                throw new IllegalArgumentException("Invalid section: " + section);
        }

        int totPage = (totRecCnt % pageSize) == 0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
        int startIndexNo = (pag - 1) * pageSize;
        int curScrStartNo = totRecCnt - startIndexNo;

        int blockSize = 5;
        int curBlock = (pag - 1) / blockSize;
        int lastBlock = (totPage - 1) / blockSize;

        pageVO.setPag(pag);
        pageVO.setPageSize(pageSize);
        pageVO.setTotRecCnt(totRecCnt);
        pageVO.setTotPage(totPage);
        pageVO.setStartIndexNo(startIndexNo);
        pageVO.setCurScrStartNo(curScrStartNo);
        pageVO.setBlockSize(blockSize);
        pageVO.setCurBlock(curBlock);
        pageVO.setLastBlock(lastBlock);

        pageVO.setPart((String) parameter);
        pageVO.setSearchString(searchString);

        return pageVO;
    }

    private Map<String, Object> prepareSortOption(Object parameter, String keyword) {
        Map<String, Object> paramMap = new HashMap<>();
        
        if (keyword != null && !keyword.isEmpty()) {
            paramMap.put("keyword", keyword);
        }

        if (parameter instanceof String && !"전체".equals(parameter)) {
            paramMap.put("part", parameter);
        }

        return paramMap;
    }
}