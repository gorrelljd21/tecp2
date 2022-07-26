BEGIN TRANSACTION;

DROP TABLE IF EXISTS tenmo_user, account, transaction CASCADE;

DROP SEQUENCE IF EXISTS seq_user_id, seq_account_id;

-- Sequence to start user_id values at 1001 instead of 1
CREATE SEQUENCE seq_user_id
  INCREMENT BY 1
  START WITH 1001
  NO MAXVALUE;

CREATE TABLE tenmo_user (
	user_id int NOT NULL DEFAULT nextval('seq_user_id'),
	username varchar(50) NOT NULL,
	password_hash varchar(200) NOT NULL,
	CONSTRAINT PK_tenmo_user PRIMARY KEY (user_id),
	CONSTRAINT UQ_username UNIQUE (username)
);

-- Sequence to start account_id values at 2001 instead of 1
-- Note: Use similar sequences with unique starting values for additional tables
CREATE SEQUENCE seq_account_id
  INCREMENT BY 1
  START WITH 2001
  NO MAXVALUE;

CREATE TABLE account (
	account_id int NOT NULL DEFAULT nextval('seq_account_id'),
	user_id int NOT NULL,
	balance decimal(13, 2) NOT NULL,
	CONSTRAINT PK_account PRIMARY KEY (account_id),
	CONSTRAINT FK_account_tenmo_user FOREIGN KEY (user_id) REFERENCES tenmo_user (user_id)
);

CREATE TABLE transaction (
	transaction_id serial NOT NULL,
	source_user_id int NOT NULL,
	destination_user_id int NOT NULL,
	transfer_amount decimal (13,2) NOT NULL,
	status varchar(15) NOT NULL,
	CONSTRAINT PK_transaction PRIMARY KEY(transaction_id),
	CONSTRAINT FK_transaction_source_user_id FOREIGN KEY(source_user_id) REFERENCES tenmo_user(user_id),
	CONSTRAINT FK_transaction_destination_user_id FOREIGN KEY(destination_user_id) REFERENCES tenmo_user(user_id),
	CONSTRAINT CK_transaction_user_ids CHECK (source_user_id != destination_user_id) 
);
COMMIT;
