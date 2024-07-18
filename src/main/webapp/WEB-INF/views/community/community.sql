show tables;

CREATE TABLE hospital_info (
	hospitalIdx INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	hospitalName VARCHAR(30),
	hospitalCategory VARCHAR(30),
	hospitalRegion VARCHAR(30)
);

CREATE TABLE hospital_comment (
	hospitalCommentIdx INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	hospitalIdx INT NOT NULL,
	userId INT NOT NULL,
	hospitalCommentTitle VARCHAR(50) NOT NULL,
	hospitalComment TEXT NOT NULL,
	FOREIGN KEY (hospitalIdx) REFERENCES hospital_info(hospitalIdx),
	FOREIGN KEY (userId) REFERENCES users(userId)
);
