show tables;

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
