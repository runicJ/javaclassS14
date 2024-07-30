show tables;

create table photoGallery (
  idx   int not null auto_increment,	/* 고유번호 */
  userId   varchar(20) not null,					/* 포토갤러리에 올린이 아이디 */
  part  varchar(10)  not null,				/* 분류(풍경/인물/학습/사물/기타) */		
  title varchar(100) not null,				/* 제목 */
  content     text   not null,				/* 포토갤러리 상세내역-사진 List(CKEDITOR사용) */
  thumbnail   varchar(100) not null,	/* 썸네일 이미지(ckeditor에 올린 첫번째 사진으로 처리) */
  photoCount 	int not null,						/* 업로드 사진 수량 */
  hostIp			varchar(30)	not null,		/* 접속 IP */
  pDate				datetime not null default now(),	/* 올린 날짜 */
  goodCount  	int not null default 0, /* 좋아요수 */
  readNum			int not null default 0,	/* 조회수 */
  primary key(idx),
  foreign key(userId) references users(userId)
);
drop table photoGallery;
desc photoGallery

create table photoReply (
  idx  int not null auto_increment,
  userId   varchar(20) not null,				/* 포토갤러리에 댓글 올린이 아이디 */
  photoIdx int not null,						/* 포토갤러리 고유번호 */
  content  text not null,						/* 포토갤러리 댓글 내용 */
  prDate   datetime default now(),	/* 댓글 입력일자 */
  primary key(idx),
  foreign key(photoIdx) references photoGallery(idx),
  foreign key(userId) references users(userId)
);
drop table photoReply;
desc photoReply;
select * from photoReply;
select pg.*,(select count(*) from photoReply where photoIdx = 9) as replyCnt from photoGallery pg where idx = 9;

create table photoSingle (
  photo  varchar(50) not null
);

create table productReview (
	reviewIdx int not null auto_increment primary key,
	productIdx int not null,
	userId varchar(20) not null,
	nickName varchar(30) not null,
	orderIdx  int not null,
	re_step int not null,
	re_order int not null,
	star int default 0,
	reviewContent text,
	reviewDate datetime default now(),
	foreign key(productIdx) references product(productIdx)
	on update cascade
	on delete restrict
);
