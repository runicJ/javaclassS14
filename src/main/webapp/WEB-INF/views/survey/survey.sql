show tables;

CREATE TABLE survey (	
	survNo int auto_increment NOT NULL PRIMARY KEY,
	survTitle VARCHAR(100) NOT NULL,
	survDesc TEXT,
	useYn CHAR(1) default 'y',
	delYn CHAR(1) default 'n',
	userId VARCHAR(20),
	createDate datetime default now(),
	modDate datetime default now(),
	FOREIGN KEY (userId) REFERENCES users(userId) on delete set null
);
drop table survey;

CREATE TABLE survQuest (	
	questNo int auto_increment NOT NULL PRIMARY KEY,
	survNo int,
	questContent VARCHAR(200),
	questType VARCHAR(10),
	questOrder int,
	FOREIGN KEY (survNo) REFERENCES survey(survNo) on delete cascade
);
drop table survQuest;

CREATE TABLE questOpt (	
	optNo int auto_increment NOT NULL PRIMARY KEY,
	questNo int,
	optContent VARCHAR(100) NOT NULL,
	optOrder int,
	FOREIGN KEY (questNo) REFERENCES survQuest(questNo) on delete cascade
);
drop table questOpt;

CREATE TABLE answer (	
	ansNo int auto_increment NOT NULL PRIMARY KEY,
	questNo int,
	userId VARCHAR(20),
	ansContent VARCHAR(100),
	ansLong TEXT,
	ansDate datetime default now(),
	FOREIGN KEY (questNo) REFERENCES survQuest(questNo) on delete cascade,
	FOREIGN KEY (userId) REFERENCES users(userId) on delete set null
);
drop table answer;