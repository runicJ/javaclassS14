package com.spring.javaclassS14.vo;

import lombok.Data;

@Data
public class DeliveryAddressVO {

    private int deliveryAddressIdx;
    private int userIdx;
    private String address;
    private String defaultAddress;

}
