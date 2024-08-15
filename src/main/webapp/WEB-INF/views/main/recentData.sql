show tables;

CREATE TABLE recent_view_product (
    viewIdx INT AUTO_INCREMENT PRIMARY KEY,
    userIdx INT NOT NULL,
    productIdx INT NOT NULL,
    viewDate DATETIME DEFAULT NOW(),
    FOREIGN KEY (userIdx) REFERENCES users(userIdx) ON DELETE CASCADE,
    FOREIGN KEY (productIdx) REFERENCES product(productIdx) ON DELETE CASCADE
);

CREATE TABLE recent_search (
    searchIdx INT AUTO_INCREMENT PRIMARY KEY,
    userIdx INT NOT NULL,
    search_term VARCHAR(255) NOT NULL,
    searchDate DATETIME DEFAULT NOW(),
    FOREIGN KEY (userIdx) REFERENCES users(userIdx) ON DELETE CASCADE
);