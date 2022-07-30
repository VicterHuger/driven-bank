--CUSTOMERS COLUMN
CREATE TABLE customers (
	id SERIAL PRIMARY KEY,
	"fullName" VARCHAR(250) NOT NULL,
	cpf VARCHAR(11) NOT NULL UNIQUE,
	email TEXT NOT NULL UNIQUE,
	password TEXT NOT NULL
);
--STATES COLUMN
CREATE TABLE states (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL UNIQUE
);
--CITIES COLUMN 
CREATE TABLE cities (
	id SERIAL PRIMARY KEY,
	name VARCHAR(250) NOT NULL UNIQUE,
	"stateId" INTEGER NOT NULL REFERENCES states(id)
);

--CUSTOMERADDRESSES COLUMN

CREATE TABLE "customerAddresses" (
	id SERIAL PRIMARY KEY,
	"customerId" INTEGER NOT NULL REFERENCES customers(id),
	street TEXT NOT NULL,
	number INTEGER NOT NULL DEFAULT 0,
	complement TEXT,
	"postalCode" VARCHAR(8) NOT NULL,
	"cityId" INTEGER NOT NULL REFERENCES cities(id)
);

--BANKACCOUNT COLUMN
CREATE TABLE "bankAccount" (
    id SERIAL PRIMARY KEY,
    "customerId" INTEGER NOT NULL REFERENCES customers(id),
    "accountNumber" VARCHAR(12) NOT NULL UNIQUE,
    agency VARCHAR(50) NOT NULL,
    "openDate" DATE NOT NULL DEFAULT NOW(),
    "closeDate" DATE NOT NULL CHECK("closeDate">="openDate")
);
--CREDITCARDS COLUMN
CREATE TABLE "creditCards" (
    id SERIAL PRIMARY KEY,
    "bankAccountId" INTEGER NOT NULL REFERENCES "bankAccount"(id),
    name VARCHAR(50) NOT NULL,
    number VARCHAR(50) NOT NULL,
    "securityCode" TEXT NOT NULL,
    "expirationMonth" VARCHAR(2) NOT NULL,
    "expirationYear" INTEGER NOT NULL,
    password TEXT NOT NULL, 
    "limit" INTEGER NOT NULL DEFAULT 0
);
--PHONE TYPE
create type phones_t as enum('landline', 'mobile');
-- CUSTOMERPHONES TYPE
CREATE TABLE "customerPhones"(
    id SERIAL PRIMARY KEY,
    "customerId" INTEGER NOT NULL REFERENCES customers(id),
    number INTEGER NOT NULL UNIQUE,
    type phones_t
);
-- TRANSACTION TYPE
create type transaction_t as enum('deposit', 'withdraw');
--TRANSACTION COLUMN
CREATE TABLE transactions (
    id SERIAL PRIMARY KEY,
    "bankAccountId" INTEGER NOT NULL REFERENCES "bankAccount"(id),
    amount INTEGER NOT NULL CHECK(amount>0),
    type transaction_t,
    time TIMESTAMP NOT NULL DEFAULT NOW(),
    description TEXT,
    cancelled BOOLEAN NOT NULL DEFAULT false
);











