show tables;

/* 회원 테이블 */
create table users {
	user_idx int auto_increment primary key,
	user_id     varchar(20) not null,
	user_pwd    varchar(255) not null,
	name        varchar(50) not null,
	gender      enum('m','f','n') default 'n' not null,
	email       varchar(60) not null,
	tel         varchar(20) not null,
	user_image  varchar(255) default 'noImage.jpg' not null,
	register_reason varchar(50) default '미선택',
	point       int default 1000 not null,
	policy_flag enum('y','n') default 'n' not null,
	create_date datetime default now() not null,
	update_date datetime default null
}

/* 로그인 기록 테이블 */
create table user_log {
	log_idx    int auto_increment primary key,
	user_idx   int not null,
	login_time datetime default now() not null,
	host_ip    varchar(255) not null
}