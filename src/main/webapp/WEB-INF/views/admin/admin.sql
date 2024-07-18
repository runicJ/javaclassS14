/* 쿠폰 */
CREATE TABLE coupon (
    couponIdx INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    couponCode VARCHAR(50) NOT NULL,
    discountPercent DECIMAL(10,2) NOT NULL,
    expirationDate DATETIME NOT NULL,
    isActive ENUM('y', 'n') DEFAULT 'n' NOT NULL
);

/* 광고 */
CREATE TABLE ad (
	adIdx INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	adTitle VARCHAR(100) NOT NULL,
	adContent TEXT,
	adImage VARCHAR(255) NOT NULL,
	startDate DATETIME DEFAULT NOW() NOT NULL,
	endDate DATETIME NOT NULL,
	createDate DATETIME DEFAULT NOW() NOT NULL
);

/* 광고 게시 로그 */
CREATE TABLE ad_log (
	adLogIdx INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	adIdx INT NOT NULL,
	userIdx INT NOT NULL,
	adDate DATETIME DEFAULT NOW()
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