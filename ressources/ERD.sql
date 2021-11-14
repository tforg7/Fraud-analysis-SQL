-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "card_holder" (
    "cardholder_ID" int   NOT NULL,
    "name" varchar(50)   NOT NULL,
    CONSTRAINT "pk_card_holder" PRIMARY KEY (
        "cardholder_ID"
     )
);

CREATE TABLE "credit_card" (
    "card" varchar(20)   NOT NULL,
    "cardholder_ID" int   NOT NULL,
    CONSTRAINT "pk_credit_card" PRIMARY KEY (
        "card"
     )
);

CREATE TABLE "merchant" (
    "id_merchant" int   NOT NULL,
    "name" varchar(50)   NOT NULL,
    "id_merchant_category" int   NOT NULL,
    CONSTRAINT "pk_merchant" PRIMARY KEY (
        "id_merchant"
     )
);

CREATE TABLE "merchant_category" (
    "id_merchant_category" int   NOT NULL,
    "name" varchar(200)   NOT NULL,
    CONSTRAINT "pk_merchant_category" PRIMARY KEY (
        "id_merchant_category"
     )
);

CREATE TABLE "transaction" (
    "id" int   NOT NULL,
    "date" timestamp   NOT NULL,
    "amount" int   NOT NULL,
    "card" varchar(20)   NOT NULL,
    "id_merchant" int   NOT NULL,
    CONSTRAINT "pk_transaction" PRIMARY KEY (
        "id"
     )
);

ALTER TABLE "credit_card" ADD CONSTRAINT "fk_credit_card_cardholder_ID" FOREIGN KEY("cardholder_ID")
REFERENCES "card_holder" ("");

ALTER TABLE "merchant" ADD CONSTRAINT "fk_merchant_id_merchant_category" FOREIGN KEY("id_merchant_category")
REFERENCES "merchant_category" ("");

ALTER TABLE "transaction" ADD CONSTRAINT "fk_transaction_card" FOREIGN KEY("card")
REFERENCES "credit_card" ("");

ALTER TABLE "transaction" ADD CONSTRAINT "fk_transaction_id_merchant" FOREIGN KEY("id_merchant")
REFERENCES "merchant" ("");

