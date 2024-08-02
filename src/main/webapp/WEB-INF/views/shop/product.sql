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

select * from product_top order by productTopIdx;
select t.*, m.productMidIdx, m.productMidName from product_top t left join product_mid m on t.productTopIdx = m.productTopIdx;
select t.*, m.productMidIdx, m.productMidName from product_top t left join product_mid m on t.productTopIdx = m.productTopIdx order by productTopIdx;
select t.*, m.productMidIdx, m.productMidName from product_top t left join product_mid m on t.productTopIdx = m.productTopIdx group by productTopIdx;

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
    productThumb VARCHAR(255) DEFAULT 'noImage.png' NOT NULL,
    shipAddress VARCHAR(255) NOT NULL,
    returnFee INT DEFAULT 0 NOT NULL,
    productTags VARCHAR(255) NOT NULL,
    storeIdx int NOT NULL,
    favoriteCount INT DEFAULT 0 NOT NULL,
    createdDate DATETIME DEFAULT NOW() NOT NULL,
    updatedDate DATETIME DEFAULT NOW() NOT NULL,
    productTopIdx INT NOT NULL,
    productMidIdx INT NOT NULL,
    content TEXT NOT NULL,
    FOREIGN KEY (productTopIdx) REFERENCES product_top(productTopIdx),
    FOREIGN KEY (productMidIdx) REFERENCES product_mid(productMidIdx)
);
select *,datediff(createdDate, now()) as createDiff from product order by createdDate desc limit 6;
drop table product;
select *, (select count(*) from product) as productCnt from product order by productIdx desc;
select *, (select count(*) from product where productMidIdx = 7) as productCnt from product where productMidIdx = 7 order by productIdx desc;
select t.*, m.productMidIdx, m.productMidName, (select count(*) from product p where p.productMidIdx = m.productMidIdx) as productCnt from product_top t left join product_mid m on t.productTopIdx = m.productTopIdx;

/* 제품 그룹명 */
CREATE TABLE product_option_group (
    optionGroupIdx INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    productIdx INT NOT NULL,
    optionGroupName VARCHAR(50) NOT NULL,
    FOREIGN KEY (productIdx) REFERENCES product(productIdx)
);

desc product_option_group;
select * from product_option_group;

/* 제품 그룹의 옵션 */
CREATE TABLE product_option (
    optionIdx INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    optionGroupIdx INT NOT NULL,
    optionName VARCHAR(50) NOT NULL,
    addPrice INT DEFAULT 0 NOT NULL,
    FOREIGN KEY (optionGroupIdx) REFERENCES product_option_group(optionGroupIdx)
);
select g.optionGroupName, o.* from product_option_group as g, product_option as o where g.optionGroupIdx=o.optionGroupIdx and g.productIdx = 9 order by g.optionGroupIdx, o.optionIdx;
select g.optiongroupIdx, g.optionGroupName, o.optionIdx, o.optionName from product_option_group as g left join product_option as o on g.optionGroupIdx=o.optionGroupIdx where g.productIdx=9 order by g.optionGroupIdx, o.optionIdx;
desc product_option;

/* 장바구니 */
CREATE TABLE cart (
    cartIdx INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    userId VARCHAR(20) NOT NULL,
    productIdx INT NOT NULL,
    quantity INT DEFAULT 1 NOT NULL,
    addedDate DATETIME DEFAULT NOW() NOT NULL,
    isSoldOut ENUM('y','n') DEFAULT 'n' NOT NULL,
    optionIdx INT DEFAULT NULL,
    FOREIGN KEY (userId) REFERENCES users(userId),
    FOREIGN KEY (productIdx) REFERENCES product(productIdx),
    FOREIGN KEY (optionIdx) REFERENCES product_option(optionIdx)
);

desc cart;