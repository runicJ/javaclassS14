show tables;

/* 회원 */
CREATE TABLE users (
    userIdx INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    userId VARCHAR(20) NOT NULL UNIQUE KEY,
    userPwd VARCHAR(255) NOT NULL,
    name VARCHAR(50) NOT NULL,
    nickName VARCHAR(30) NOT NULL,
    gender ENUM('n','m','f') DEFAULT 'n' NOT NULL,
    email VARCHAR(60) NOT NULL,
    tel VARCHAR(20) NOT NULL,
    userImage VARCHAR(255) DEFAULT 'noImage.png' NOT NULL,
    registerWay VARCHAR(50) DEFAULT '미선택',
    point INT DEFAULT 1000 NOT NULL,
    policyFlag ENUM('y','n') DEFAULT 'y' NOT NULL,
    createDate DATETIME DEFAULT NOW() NOT NULL,
    updateDate DATETIME DEFAULT NULL,
    level DOUBLE DEFAULT 3 NOT NULL,
    userStatus ENUM('on','off','stop','delete') DEFAULT 'on' NOT NULL
);

select * from users where level > 0 AND userStatus = 'on' order by name;

drop table users;
select * from users;

ALTER TABLE users AUTO_INCREMENT=1;
SET @COUNT = 0;
UPDATE users SET userIdx = @COUNT:=@COUNT+1;

/* 회원 로그 */
CREATE TABLE user_log (
    logIdx INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    userIdx INT,
    loginTime DATETIME DEFAULT NOW() NOT NULL,
    hostIp VARCHAR(255) NOT NULL,
    FOREIGN KEY (userIdx) REFERENCES users(userIdx) ON DELETE SET NULL
);

/* 탈퇴 회원 */
CREATE TABLE delete_users (
    deleteIdx INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    userIdx INT NOT NULL,
    deleteDate DATETIME DEFAULT NOW() NOT NULL,
    deleteReason TEXT,
    FOREIGN KEY (userIdx) REFERENCES users(userIdx)
);

/* 배송지 주소 */
CREATE TABLE delivery_address (
    deliveryAddressId INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    userIdx INT NOT NULL,
    address1 VARCHAR(255) NOT NULL,
    address2 VARCHAR(255) DEFAULT NULL,
    address3 VARCHAR(255) DEFAULT NULL,
    FOREIGN KEY (userIdx) REFERENCES users(userIdx) ON DELETE CASCADE
);

/* 포인트 */
CREATE TABLE user_point (
    userPointIdx INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    userIdx INT,
    orderIdx INT DEFAULT NULL,
    pointLog INT NOT NULL,
    pointLogDate DATETIME DEFAULT NOW() NOT NULL,
    pointLogType ENUM('사용', '적립', '환불') NOT NULL,
    FOREIGN KEY (userIdx) REFERENCES users(userIdx) ON DELETE CASCADE,
    FOREIGN KEY (orderIdx) REFERENCES orders_p(orderIdx) ON DELETE CASCADE
);

/* 관심 제품 */
CREATE TABLE liked_product (
    likedIdx INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    userIdx INT NOT NULL,
    productIdx INT NOT NULL,
    likedAddDate DATETIME DEFAULT NOW(),
    FOREIGN KEY (userIdx) REFERENCES users(userIdx),
    FOREIGN KEY (productIdx) REFERENCES product(productIdx)
);

/* 게시글 북마크 */
CREATE TABLE bookmark (
    bookmarkIdx INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    userIdx INT NOT NULL,
    partUrl VARCHAR(255),
    part VARCHAR(30),
    partIdx INT,
    addDate DATETIME DEFAULT NOW(),
    FOREIGN KEY (userIdx) REFERENCES users(userIdx)
);
