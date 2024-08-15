show tables;

CREATE TABLE photoReview (
  idx         INT NOT NULL AUTO_INCREMENT PRIMARY KEY,  /* 고유번호 */
  userIdx     INT NOT NULL,                             /* 포토갤러리에 올린이의 고유번호 */
  part        VARCHAR(10) NOT NULL,                     /* 분류(풍경/인물/학습/사물/기타) */
  title       VARCHAR(100) NOT NULL,                    /* 제목 */
  content     TEXT NOT NULL,                            /* 포토갤러리 상세내역-사진 List(CKEDITOR사용) */
  thumbnail   VARCHAR(100) NOT NULL,                    /* 썸네일 이미지(ckeditor에 올린 첫번째 사진으로 처리) */
  photoCount  INT NOT NULL,                             /* 업로드 사진 수량 */
  hostIp      VARCHAR(30) NOT NULL,                     /* 접속 IP */
  pDate       DATETIME NOT NULL DEFAULT NOW(),          /* 올린 날짜 */
  goodCount   INT NOT NULL DEFAULT 0,                   /* 좋아요수 */
  readNum     INT NOT NULL DEFAULT 0,                   /* 조회수 */
  FOREIGN KEY(userIdx) REFERENCES users(userIdx)
);

CREATE TABLE photoReply (
  idx      INT NOT NULL AUTO_INCREMENT PRIMARY KEY,     /* 댓글 고유번호 */
  userIdx  INT NOT NULL,                                /* 포토갤러리에 댓글 올린이의 고유번호 */
  photoIdx INT NOT NULL,                                /* 포토갤러리 고유번호 */
  content  TEXT NOT NULL,                               /* 포토갤러리 댓글 내용 */
  prDate   DATETIME DEFAULT NOW(),                      /* 댓글 입력일자 */
  FOREIGN KEY(photoIdx) REFERENCES photoReview(idx),
  FOREIGN KEY(userIdx) REFERENCES users(userIdx)
);

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
