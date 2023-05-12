#!/bin/bash

kubectl exec -i service/mysql -- mysql -u root -p1234 -e "\
    CREATE DATABASE IF NOT EXISTS ddd_test; \
    USE ddd_test; \
    CREATE TABLE IF NOT EXISTS test_table (id INT PRIMARY KEY, name VARCHAR(50)); \
    INSERT IGNORE INTO test_table (id, name) VALUES (1, 'Mondy'), (2, 'Dude'), (3, 'GCP'); \
    Show databases;"


