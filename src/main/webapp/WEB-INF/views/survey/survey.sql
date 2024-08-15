queshow tables;

CREATE TABLE survey (	
	surveyIdx INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	surveyTitle VARCHAR(100) NOT NULL,
	surveyDesc TEXT,
	surveyThumb VARCHAR(255) DEFAULT 'noImage.png',
	useFlag ENUM('y','n') DEFAULT 'y',
	delFlag ENUM('y','n') DEFAULT 'n',
	userIdx INT,
	createDate DATETIME DEFAULT NOW(),
	modDate DATETIME DEFAULT NOW(),
	FOREIGN KEY (userIdx) REFERENCES users(userIdx) ON DELETE SET NULL
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
	answerIdx INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	questIdx INT,
	userIdx INT,
	answerContent VARCHAR(100),
	answerLong TEXT,
	answerDate DATETIME DEFAULT NOW(),
	FOREIGN KEY (questIdx) REFERENCES surveyQuest(questIdx) ON DELETE CASCADE,
	FOREIGN KEY (userIdx) REFERENCES users(userIdx) ON DELETE SET NULL
);
drop table surveyAnswer;