package com.spring.javaclassS14.pagination;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS14.dao.ShopDAO;
import com.spring.javaclassS14.dao.UserDAO;
import com.spring.javaclassS14.vo.PageVO;

@Service
public class PageProcess {

    @Autowired
    UserDAO userDAO;
    
    @Autowired
    ShopDAO shopDAO;

    public PageVO totRecCnt(int pag, int pageSize, String section, String sortOption, String keyword) {
        PageVO pageVO = new PageVO();
        int totRecCnt = 0;
        Map<String, Object> paramMap = prepareSortOption(sortOption, keyword);

        if (section.equals("user")) {
            if (!keyword.equals("")) {
                totRecCnt = userDAO.totRecCntKeyword(keyword);
            } 
            else if (!paramMap.isEmpty()) {
                totRecCnt = userDAO.totRecCntOption(paramMap);
            } 
            else {
                totRecCnt = userDAO.totRecCnt();
            }
        } else if (section.equals("product")) {
            if (!keyword.equals("")) {
                totRecCnt = shopDAO.totRecCntKeyword(keyword);
            } else {
                totRecCnt = shopDAO.totRecCnt();
            }
        }

        int totPage = (totRecCnt % pageSize) == 0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
        int startIndexNo = (pag - 1) * pageSize;
        int curScrStartNo = totRecCnt - startIndexNo;

        int blockSize = 5; // Number of pages in a block
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

        pageVO.setPart(sortOption);
        pageVO.setSearchString(keyword);

        return pageVO;
    }

    private Map<String, Object> prepareSortOption(String sortOption, String keyword) {
        Map<String, Object> paramMap = new HashMap<>();
        if (keyword != null && !keyword.isEmpty()) {
            paramMap.put("keyword", keyword);
        }

        try {
            Double numericSortOption = Double.valueOf(sortOption);
            paramMap.put("numericOption", numericSortOption);
        } catch (NumberFormatException e) {
            paramMap.put("stringOption", sortOption);
        }
        // Include the sortOption itself
        paramMap.put("sortOption", sortOption);

        return paramMap;
    }
}
