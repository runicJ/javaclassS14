/* 쿠폰 */
CREATE TABLE coupon (
    couponIdx INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    couponCode VARCHAR(50) NOT NULL,
    discountPercent DECIMAL(10,2) NOT NULL,
    expirationDate DATETIME NOT NULL,
    isActive ENUM('y', 'n') DEFAULT 'y' NOT NULL
);
desc coupon

CREATE TABLE userCoupon (
    userCouponIdx INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    userId varchar(20) NOT NULL,
    couponIdx INT NOT NULL,
    issuedDate DATETIME NOT NULL,
    isUsed ENUM('y', 'n') DEFAULT 'n' NOT NULL,
    FOREIGN KEY (userId) REFERENCES users(userId),
    FOREIGN KEY (couponIdx) REFERENCES coupon(couponIdx)
);

/* 광고 */
CREATE TABLE ad (
	adIdx INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	adTitle VARCHAR(100) NOT NULL,
	adContent TEXT,
	adImage VARCHAR(255) NOT NULL,
	adApplyDate DATETIME DEFAULT NOW() NOT NULL,
	startDate DATETIME DEFAULT NULL,
	endDate DATETIME DEFAULT NULL,
	createDate DATETIME DEFAULT NOW() NOT NULL,
	adStatus enum('대기','게시','마감') default '대기'
);

CREATE TABLE event (
    eventIdx INT AUTO_INCREMENT PRIMARY KEY,
    eventTitle VARCHAR(100) NOT NULL,
    eventContent TEXT NOT NULL,
    eventImage VARCHAR(255) NULL,
    startDate DATETIME DEFAULT NULL,
    endDate DATETIME DEFAULT NULL,
    createDate DATETIME DEFAULT NOW(),
    eventStatus ENUM('y', 'n') DEFAULT 'y'
);

/* 알람 */
CREATE TABLE alarm (
	alarmIdx INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	receiveIdx INT NOT NULL,
	sendIdx INT NOT NULL,
	alarmPart varchar(30) NOT NULL,
	alarmPartIdx varchar(30) NOT NULL,
	alarmDate DATETIME NOT NULL,
	alarmCheckFlag ENUM('y','n') default 'n' NOT NULL,
	foreign key (receiveIdx) references users(userIdx) on delete cascade,
	foreign key (receiveIdx) references users(userIdx) on delete cascade
);