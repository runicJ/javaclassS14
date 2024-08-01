queshow tables;

CREATE TABLE survey (	
	surveyIdx int auto_increment NOT NULL PRIMARY KEY,
	surveyTitle VARCHAR(100) NOT NULL,
	surveyDesc TEXT,
	surveyThumb varchar(255) default 'noImage.jpg',
	useFlag enum('y','n') default 'y',
	delFlag enum('y','n') default 'n',
	userId VARCHAR(20),
	createDate datetime default now(),
	modDate datetime default now(),
	FOREIGN KEY (userId) REFERENCES users(userId) on delete set null
);
drop table survey;

CREATE TABLE surveyQuest (	
	questIdx int auto_increment NOT NULL PRIMARY KEY,
	surveyIdx int,
	questContent VARCHAR(200),
	questType VARCHAR(10),
	questOrder int,
	FOREIGN KEY (surveyIdx) REFERENCES survey(surveyIdx) on delete cascade
);
drop table surveyQuest;

CREATE TABLE surveytOption (	
	optionIdx int auto_increment NOT NULL PRIMARY KEY,
	questIdx int,
	optContent VARCHAR(100) NOT NULL,
	optOrder int,
	FOREIGN KEY (questIdx) REFERENCES surveyQuest(questIdx) on delete cascade
);
drop table surveytOption;

CREATE TABLE surveyAnswer (	
	answerIdx int auto_increment NOT NULL PRIMARY KEY,
	questIdx int,
	userId VARCHAR(20),
	answerContent VARCHAR(100),
	answerLong TEXT,
	answerDate datetime default now(),
	FOREIGN KEY (questIdx) REFERENCES surveyQuest(questIdx) on delete cascade,
	FOREIGN KEY (userId) REFERENCES users(userId) on delete set null
);
drop table surveyAnswer;