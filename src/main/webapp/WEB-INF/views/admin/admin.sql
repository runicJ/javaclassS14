/* 쿠폰 */
CREATE TABLE coupon (
    couponIdx INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    couponCode VARCHAR(50) NOT NULL,
    discountPercent DECIMAL(10,2) NOT NULL,
    expirationDate DATETIME NOT NULL,
    isActive ENUM('y', 'n') DEFAULT 'n' NOT NULL
);