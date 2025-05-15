-- Valid user 1
INSERT INTO [User] (Username, Password, ConfirmPassword, Age, Gender)
VALUES ('john_doe', 'password123', 'password123', 25, 'M');

-- Valid user 2
INSERT INTO [User] (Username, Password, ConfirmPassword, Age, Gender)
VALUES ('jane_smith', 'abcDEF456', 'abcDEF456', 32, 'F');

-- Will fail: passwords do not match
INSERT INTO [User] (Username, Password, ConfirmPassword, Age, Gender)
VALUES ('mismatch_user', 'pass123', 'pass124', 22, 'M');

-- Will fail: age too low
INSERT INTO [User] (Username, Password, ConfirmPassword, Age, Gender)
VALUES ('young_kid', 'abc123', 'abc123', 10, 'F');

-- Will fail: age too high
INSERT INTO [User] (Username, Password, ConfirmPassword, Age, Gender)
VALUES ('old_timer', 'safePass', 'safePass', 120, 'M');

-- Will fail: missing password (NOT NULL)
INSERT INTO [User] (Username, ConfirmPassword, Age, Gender)
VALUES ('no_password', 'no_password', 30, 'M');

-- Will fail: username 'john_doe' already used above
INSERT INTO [User] (Username, Password, ConfirmPassword, Age, Gender)
VALUES ('john_doe', 'newpass', 'newpass', 40, 'M');

-- Will fail: invalid gender
INSERT INTO [User] (Username, Password, ConfirmPassword, Age, Gender)
VALUES ('new_user', 'working', 'working', 33, 'X');

SELECT * FROM [User];
