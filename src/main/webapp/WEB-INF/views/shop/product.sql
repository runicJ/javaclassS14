show tables;

/* 제품카테고리(대) */
CREATE TABLE product_top (
    productTopIdx INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    productTopName VARCHAR(30) NOT NULL,
    useYn ENUM('y', 'n') DEFAULT 'y' NOT NULL,
    hasMid ENUM('y', 'n') DEFAULT 'n' NOT NULL
);

/* 제품카테고리(중) */
CREATE TABLE product_mid (
    productMidIdx INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    productTopIdx INT NOT NULL,
    productMidName VARCHAR(30) NOT NULL,
    FOREIGN KEY (productTopIdx) REFERENCES product_top(productTopIdx)
);

/* 제품 정보 */
CREATE TABLE product (
    productIdx INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    productCode VARCHAR(20) NOT NULL,
    productName VARCHAR(30) NOT NULL,
    productDetails MEDIUMTEXT NOT NULL,
    productStatus ENUM('active', 'inactive', 'deleted') DEFAULT 'active' NOT NULL,
    productPrice INT NOT NULL,
    productDiscount DECIMAL(10, 2) DEFAULT 0 NOT NULL,
    productPointFlag ENUM('y', 'n') DEFAULT 'y' NOT NULL,
    productStock INT DEFAULT 100 NOT NULL,
    stockDate DATETIME DEFAULT NULL,
    productQuantity INT DEFAULT 0 NOT NULL,
    productOptFlag ENUM('y', 'n') DEFAULT 'n' NOT NULL,
    productBrand VARCHAR(50) NOT NULL,
    productCountry VARCHAR(50) NOT NULL,
    asInfo VARCHAR(50) DEFAULT NULL,
    productThumb VARCHAR(255) DEFAULT 'noImage.jpg' NOT NULL,
    shipAddress VARCHAR(255) NOT NULL,
    returnFee INT DEFAULT 0 NOT NULL,
    productTags VARCHAR(255) NOT NULL,
    storeIdx int NOT NULL,
    favoriteCount INT DEFAULT 0 NOT NULL,
    createdDate DATETIME DEFAULT NOW() NOT NULL,
    updatedDate DATETIME DEFAULT NOW() NOT NULL,
    productTopIdx INT NOT NULL,
    productMidIdx INT NOT NULL,
    productContent TEXT NOT NULL,
    FOREIGN KEY (productTopIdx) REFERENCES product_top(productTopIdx),
    FOREIGN KEY (productMidIdx) REFERENCES product_mid(productMidIdx)
);

drop table product;

/* 제품 그룹명 */
CREATE TABLE product_option_group (
    optionGroupIdx INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    productIdx INT NOT NULL,
    optionGroupName VARCHAR(50) NOT NULL,
    FOREIGN KEY (productIdx) REFERENCES product(productIdx)
);

desc product_option_group;

/* 제품 그룹의 옵션 */
CREATE TABLE product_option (
    optionIdx INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    optionGroupIdx INT NOT NULL,
    optionName VARCHAR(50) NOT NULL,
    addPrice INT DEFAULT 0 NOT NULL,
    FOREIGN KEY (optionGroupIdx) REFERENCES product_option_group(optionGroupIdx)
);

desc product_option;
