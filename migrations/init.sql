CREATE TABLE IF NOT EXISTS sample_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50)
);
INSERT INTO sample_table(name) VALUES ('Alice'), ('Bob'), ('Charlie');
