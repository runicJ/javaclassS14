show tables;

create product_qna (
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

create qna (
	qnaIdx int not null auto_increment primary key,
	userId varchar(20) not null,
	qnaTitle varchar(100) not null,
	qnaContent text not null,
	qnaDate datetime defualt now(),
	qnaAnswerFlag enum('y','n') default 'n',
	qnaAnswerContent text,
	qnaAnswerDate datetime default null,
	qnaCategory varchar(30) not null,
	foreign key (userId) references users(userId)
);