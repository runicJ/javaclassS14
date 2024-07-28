package com.spring.javaclassS14.vo;

import lombok.Data;

@Data
public class Pagination {
    // 현재 페이지
    private int currentPage;
    // 페이지당 출력할 데이터 수
    private int cntPerPage;
    // 하단 페이지 사이즈 1~10, 11~20, 21~30 ...
    private int pageSize;
    // 전체 데이터 개수 
    private int totalRecordCount;
    // 전체 페이지 개수 
    private int totalPageCount;
    // 페이지 리스트의 첫 페이지 번호
    private int firstPage;
    // 페이지 리스트의 마지막 페이지 번호
    private int lastPage;
    // SQL 조건절에 사용되는 첫 RNUM
    private int firstRecordIndex;
    // SQL 조건절에 사용되는 마지막 RNUM
    private int lastRecordIndex;
    // 이전 페이지 존재 여부 
    private boolean hasPreviousPage;
    // 다음 페이지 존재 여부
    private boolean hasNextPage;

    public Pagination(int currentPage, int cntPerPage, int pageSize) {
        if (currentPage < 1) {
            currentPage = 1;
        }
        if (cntPerPage != 10 && cntPerPage != 20 && cntPerPage != 30) {
            cntPerPage = 10;
        }
        this.currentPage = currentPage;
        this.cntPerPage = cntPerPage;
        this.pageSize = pageSize;
    }

    public void setTotalRecordCount(int totalRecordCount) {
        this.totalRecordCount = totalRecordCount;
        if (totalRecordCount > 0) {
            calculation();
        }
    }

    private void calculation() {
        // 전체 페이지 수 계산
        totalPageCount = ((totalRecordCount - 1) / this.getCntPerPage()) + 1;
        if (this.getCurrentPage() > totalPageCount) {
            this.setCurrentPage(totalPageCount);
        }

        // 페이지 리스트의 첫 페이지 번호 계산
        firstPage = ((this.getCurrentPage() - 1) / this.getPageSize()) * this.getPageSize() + 1;

        // 페이지 리스트의 마지막 페이지 번호 계산
        lastPage = firstPage + this.getPageSize() - 1;
        if (lastPage > totalPageCount) {
            lastPage = totalPageCount;
        }

        // SQL 조건절에 사용되는 첫 RNUM 계산
        firstRecordIndex = (this.getCurrentPage() - 1) * this.getCntPerPage() + 1;

        // SQL 조건절에 사용되는 마지막 RNUM 계산
        lastRecordIndex = this.getCurrentPage() * this.getCntPerPage();

        // 이전 페이지 존재 여부 계산
        hasPreviousPage = firstPage > 1 || currentPage != firstPage;

        // 다음 페이지 존재 여부 계산
        hasNextPage = (lastPage * this.getCntPerPage()) < totalRecordCount || currentPage != lastPage;
    }
}
