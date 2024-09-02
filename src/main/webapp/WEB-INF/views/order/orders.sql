show tables;

/* 주문 */
CREATE TABLE orders_p (
    orderIdx INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    userIdx INT NOT NULL,
    totalPrice INT NOT NULL,
    couponIdx INT DEFAULT NULL,
    pointUse INT DEFAULT 0 NOT NULL,
    orderStatus ENUM('주문', '배송', '완료', '취소') DEFAULT '주문' NOT NULL,
    orderDate DATETIME DEFAULT NOW() NOT NULL,
    FOREIGN KEY (userIdx) REFERENCES users(userIdx),
    FOREIGN KEY (couponIdx) REFERENCES userCoupon(userCouponIdx)
);

/* 주문 정보 */
CREATE TABLE order_product (
    orderProductIdx INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    orderIdx INT NOT NULL,
    productIdx INT NOT NULL,
    orderQuantity INT NOT NULL,
    price INT NOT NULL,
    optionIdx INT DEFAULT NULL,
    FOREIGN KEY (orderIdx) REFERENCES orders_p(orderIdx),
    FOREIGN KEY (productIdx) REFERENCES product(productIdx)
);

/* 주문 배송지 정보 */
CREATE TABLE order_delivery (
    deliveryIdx INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    orderIdx INT NOT NULL,
    recieverName VARCHAR(50) NOT NULL,
    recieverTel VARCHAR(20) NOT NULL,
    recieverAddress VARCHAR(255) NOT NULL,
    country VARCHAR(100) NOT NULL,
    FOREIGN KEY (orderIdx) REFERENCES orders_p(orderIdx)
);

/* 주문 취소 테이블 */
CREATE TABLE order_cancel (
    cancelIdx INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    orderIdx INT NOT NULL,
    userIdx INT NOT NULL,
    cancelReason TEXT,
    cancelDate DATETIME DEFAULT NOW() NOT NULL,
    status ENUM('신청','승인','반려') DEFAULT '신청' NOT NULL,
    cancel_msg TEXT DEFAULT NULL,
    FOREIGN KEY (orderIdx) REFERENCES orders_p(orderIdx),
    FOREIGN KEY (userIdx) REFERENCES users(userIdx)
);

/* 주문 반품 테이블 */
CREATE TABLE order_return (
    returnIdx INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    orderIdx INT NOT NULL,
    userIdx INT NOT NULL,
    productIdx INT NOT NULL,
    returnReason TEXT,
    returnDate DATETIME DEFAULT NOW() NOT NULL,
    status ENUM('신청','승인','반려') DEFAULT '신청' NOT NULL,
    responsibility ENUM('구매자','판매자') DEFAULT '구매자' NOT NULL,
    FOREIGN KEY (orderIdx) REFERENCES orders_p(orderIdx),
    FOREIGN KEY (userIdx) REFERENCES users(userIdx),
    FOREIGN KEY (productIdx) REFERENCES product(productIdx)
);

/* 환불 테이블 */
CREATE TABLE refund (
    refundIdx INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    orderIdx INT NOT NULL,
    userIdx INT NOT NULL,
    refund_amount INT DEFAULT 1 NOT NULL,
    refundDate DATETIME DEFAULT NOW() NOT NULL,
    paymentMethod ENUM('card','bank','point') NOT NULL,
    responsibility ENUM('신청','승인','반려') DEFAULT '신청' NOT NULL,
    deliveryFee INT DEFAULT 0 NOT NULL,
    FOREIGN KEY (orderIdx) REFERENCES orders_p(orderIdx),
    FOREIGN KEY (userIdx) REFERENCES users(userIdx)
);
