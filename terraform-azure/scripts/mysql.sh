#!/bin/bash


kubectl exec -i service/mysql -- mysql -u root -p1234 -e "\
    CREATE DATABASE IF NOT EXISTS test_manifest12; \
    USE test_manifest12; \
    CREATE TABLE IF NOT EXISTS my_table (id INT PRIMARY KEY, name VARCHAR(50)); \
    INSERT IGNORE INTO my_table (id, name) VALUES (1, 'John'), (2, 'Jane'), (3, 'Joe'); \
    Show databases;"



