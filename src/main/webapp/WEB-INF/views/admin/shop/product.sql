show tables;

/* 상품카테고리(대) */
create table product_top (
	productTopIdx  int not null auto_increment primary key,
	productTopName varchar(30) not null,
	useYn   enum('y','n') default 'y' not null,
	hasMid  enum('y','n') default 'n' not null
);

/* 상품카테고리(중) */
create table product_mid (
	productMidIdx  int not null auto_increment primary key,
	productTopIdx  int not null,
	productMidName varchar(30) not null,
	foreign key(productTopIdx) references productTop(productTopIdx)
);

/* 제품 정보 */
create table product (
	productIdx       int not null auto_increment primary key,
	productCode      varchar(20) not null,
	productName      varchar(30) not null,
	productDetails   mediumtext not null,
	productStatus    enum('active','inactive','deleted') default 'active' not null,
	productPrice     int not null,
	productDiscount  decimal(10,2) default 0 not null,
	productPointFlag enum('y','n') default 'y' not null,
	productStock     int default 50 not null,
	stockDate        datetime default null,
	productQuantity  int default 0 not null,
	productOptFlag   enum('y','n') default 'n' not null,
	productBrand     varchar(50) not null,
	productCountry   varchar(50) not null,
	asInfo           varchar(50) default null,
	productThumb     varchar(255) default 'noImage.jpg' not null,
	shipAddress      varchar(255) not null,
	returnFee        int default 0 not null,
	productTags      varchar(255) not null,
	storeIdx         varchar(20) not null,
	favoriteCount    int default 0 not null,
	createdDate      datetime default now() not null,
	updatedDate      datetime default now() not null,
	productTopIdx    int not null,
	productMidIdx    int not null,
	foreign key(productTopIdx) references productTop(productTopIdx),
	foreign key(productMidIdx) references productMid(productMidIdx)
);

/* 제품 그룹명 */
create table product_option_group (
	optionGroupIdx  int not null auto_increment primary key,
	productIdx      int not null,
	optionGroupName varchar(50) not null,
	foreign key(productIdx) references product(productIdx)
);

/* 제품 그룹의 옵션 */
create table product_option (
	optionIdx      int not null auto_increment primary key,
	optionGroupIdx int not null,
	optionName     varchar(50) not null,
	addPrice       int default 0 not null,
	foreign key(optionGroupIdx) references product_option_group(optionGroupIdx)
);

/* 제품 추가 이미지 */
create product_images (
	imagesIdx   int not null auto_increment primary key,
	productIdx  int not null,
	imageUrl    varchar(255),
	altImage    varchar(255) default null,
	createdDate detetime default now() not null,
	foreign key(productIdx) references product(productIdx)
);


