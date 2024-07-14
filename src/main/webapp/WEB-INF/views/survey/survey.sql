show tables;

CREATE TABLE survey (	
	survNo int auto_increment NOT NULL PRIMARY KEY,
	survTitle VARCHAR(100) NOT NULL,
	survDesc TEXT,
	useYn CHAR(1) default 'y',
	delYn CHAR(1) default 'n',
	regId VARCHAR(20),
	regDate datetime default now(),
	modDate datetime default now()
);

CREATE TABLE survQuest (	
	questNo int PRIMARY KEY auto_increment NOT NULL,
	survNo int,
	questContent VARCHAR(200),
	questType VARCHAR(10),
	questOrder int,
	FOREIGN KEY (survNo) REFERENCES survey(survNo) on delete set null
);

CREATE TABLE questOpt (	
	optNo int PRIMARY KEY auto_increment NOT NULL,
	questNo int,
	optContent VARCHAR(100) NOT NULL,
	optOrder int,
	FOREIGN KEY (questNo) REFERENCES survQuest(questNo) on delete set null
);

CREATE TABLE answer (	
	ansNo int PRIMARY KEY auto_increment NOT NULL,
	questNo int,
	userId VARCHAR(20),
	ansContent VARCHAR(100),
	ansLong TEXT,
	ansDate datetime default now(),
	FOREIGN KEY (questNo) REFERENCES survQuest(questNo) on delete set null,
	FOREIGN KEY (userId) REFERENCES users(userId) on delete set null
);
