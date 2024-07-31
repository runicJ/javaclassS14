show tables;

create table product_qna (
	productQnaIdx int not null auto_increment primary key,
	userId varchar(20) not null,
	productIdx int not null,
	qnaContent text,
	qnaOpenFlag enum('y','n') default 'y',
	qnaPwd varchar(255),
	qnaDate datetime default now(),
	answerFlag enum('y','n') default 'n',
	answerContent text,
	answerDate datetime default null,
	deleteFlag enum('y','n') default 'n',
	foreign key (userId) references users(userId),
	foreign key (productIdx) references product(productIdx)
);

create table qna (
	qnaIdx int not null auto_increment primary key,
	userId varchar(20) not null,
	qnaTitle varchar(100) not null,
	qnaContent text not null,
	qnaDate datetime default now(),
	qnaAnswerFlag enum('y','n') default 'n',
	qnaAnswerContent text,
	qnaAnswerDate datetime default null,
	qnaCategory varchar(30) not null,
	foreign key (userId) references users(userId)
);

/* 광고 신청 */
CREATE TABLE ad_apply (
	adApplyIdx INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	adApplyTitle VARCHAR(100) NOT NULL,
	adApplyContent TEXT,
	adApplyImage VARCHAR(255) NOT NULL,
	adApplyDate DATETIME DEFAULT NOW() NOT NULL,
	adApplyCompany VARCHAR(255) NOT NULL,
	adApplyStatus enum('신청','승인','반려') default '신청'
);

create table branch_store (
	branchStoreIdx int not null auto_increment primary key,
	branchName varchar(30) not null,
	branchTel varchar(20) not null,
	branchLocation varchar(255) not null,
	latitude double not null,
	longitude double not null,
	createDate datetime default now() not null,
	qrCode varchar(255)
);

desc branch_store;

insert into branch_store values(default, '괄호 안 쉼표 신촌점', '02-1111-1111', '서울특별시 서대문구 창천동 4-55', 37.55776266190928, 126.94006436689432 , default, null);

/* 세종, 강릉, 청주, 대구, 신촌, 전주 */
