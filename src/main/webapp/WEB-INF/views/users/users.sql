show tables;

create table users (
	userIdx 	int auto_increment primary key,
	userId     varchar(20) not null,
	userPwd    varchar(255) not null,
	name        varchar(50) not null,
	nickName    varchar(30) not null,
	gender      enum('n','m','f') default 'n' not null,
	email       varchar(60) not null,
	tel         varchar(20) not null,
	userImage  varchar(255) default 'noImage.jpg' not null,
	registerWay varchar(50) default '미선택',
	point       int default 1000 not null,
	policyFlag enum('y','n') default 'y' not null,
	createDate datetime default now() not null,
	updateDate datetime default null,
	level  int default 3 not null
);

drop table users;
select * from users;

ALTER TABLE users AUTO_INCREMENT=1;
SET @COUNT = 0;
UPDATE users SET userIdx = @COUNT:=@COUNT+1;

create table user_log (
	log_idx    int auto_increment primary key,
	user_idx   int not null,
	login_time datetime default now() not null,
	host_ip    varchar(255) not null
);