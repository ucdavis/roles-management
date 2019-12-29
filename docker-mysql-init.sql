-- Create dev / test databases for user 'roles'
CREATE USER 'roles'@'%' IDENTIFIED BY 'roles';

CREATE DATABASE IF NOT EXISTS roles;
CREATE DATABASE IF NOT EXISTS roles_test;

GRANT ALL PRIVILEGES ON roles.* TO 'roles'@'%';
GRANT ALL PRIVILEGES ON roles_test.* TO 'roles'@'%';

-- Disable remote root logins
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
