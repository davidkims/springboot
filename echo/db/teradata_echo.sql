-- Teradata echo table used to store installation details
CREATE TABLE IF NOT EXISTS echo_installation (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    step VARCHAR(255),
    status VARCHAR(32),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Example query to list installation steps
SELECT * FROM echo_installation ORDER BY created_at;
