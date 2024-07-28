show tables;

CREATE TABLE recent_view_product (
    viewIdx INT AUTO_INCREMENT PRIMARY KEY,
    userId varchar(20) NOT NULL,
    productIdx INT NOT NULL,
    viewDate DATETIME DEFAULT NOW(),
    FOREIGN KEY (userId) REFERENCES users(userId),
    FOREIGN KEY (productIdx) REFERENCES product(productIdx)
);

CREATE TABLE recent_search (
    searchIdx INT AUTO_INCREMENT PRIMARY KEY,
    userId varchar(20) NOT NULL,
    search_term VARCHAR(255) NOT NULL,
    searchDate DATETIME DEFAULT NOW(),
    FOREIGN KEY (userId) REFERENCES users(userId)
);