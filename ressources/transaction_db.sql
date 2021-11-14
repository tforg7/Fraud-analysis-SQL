-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.
drop table transaction;
drop table card_holder;
drop table credit_card;
drop table merchant;
drop table merchant_category;

CREATE TABLE card_holder (
    cardholder_ID int   NOT NULL,
    name varchar(50)   NOT NULL,
    CONSTRAINT "pk_card_holder" PRIMARY KEY (cardholder_ID)
	);

CREATE TABLE credit_card (
    card varchar(20)   NOT NULL,
    cardholder_ID int   NOT NULL,
    CONSTRAINT pk_credit_card PRIMARY KEY (card)
	);

CREATE TABLE merchant (
    id_merchant int   NOT NULL,
    name varchar(50)   NOT NULL,
    id_merchant_category int   NOT NULL,
    CONSTRAINT pk_merchant PRIMARY KEY (id_merchant)
	);

CREATE TABLE merchant_category (
    id_merchant_category int   NOT NULL,
    name varchar(200)   NOT NULL,
    CONSTRAINT pk_merchant_category PRIMARY KEY (id_merchant_category)
	);

CREATE TABLE "transaction" (
    id int   NOT NULL,
    date timestamp   NOT NULL,
    amount float   NOT NULL,
    card varchar(20)   NOT NULL,
    id_merchant int   NOT NULL,
    CONSTRAINT pk_transaction PRIMARY KEY (id)
	);

ALTER TABLE credit_card 
	ADD CONSTRAINT fk_credit_card_cardholder_ID FOREIGN KEY(cardholder_ID)
	REFERENCES card_holder;

ALTER TABLE merchant 
	ADD CONSTRAINT fk_merchant_id_merchant_category FOREIGN KEY(id_merchant_category)
	REFERENCES merchant_category;

ALTER TABLE transaction 
	ADD CONSTRAINT fk_transaction_card FOREIGN KEY(card)
	REFERENCES credit_card;

ALTER TABLE transaction 
	ADD CONSTRAINT fk_transaction_id_merchant FOREIGN KEY(id_merchant)
	REFERENCES merchant;

select * 
from card_holder;

select * 
from credit_card;

select * 
from merchant_category;

select * 
from merchant;

select * 
from transaction;


---- group transaction by card holder

CREATE VIEW transaction_by_name as
select h.name, t.id
from card_holder h
left join credit_card c 
on h.cardholder_ID= c.cardholder_ID
	join transaction t 
	on c.card=t.card
	order by h.name ;

---- count transaction under 2$ per cardholder
CREATE VIEW count_small_transaction_cardholder as
select h.name, count(amount)
from transaction t
left join credit_card c on t.card=c.card
join card_holder h on c.cardholder_ID= h.cardholder_ID
	where amount <= 2
	group by h.name
	order by count(amount) Desc;
-------



------- Top 100 transaction between AM 7:00 and AM 9:00
CREATE VIEW top_100_transaction_morning as
select h.name , t.amount
from transaction t
left join credit_card c on t.card = c.card
join card_holder h on c.cardholder_ID= h.cardholder_ID
where extract(hour from date) <= 9
	and extract(hour from date) >= 7
order by t.amount Desc
limit 100;


CREATE VIEW count_small_transaction_early_morning as
----- Transaction smaller than $2 between AM 7:00 and AM 9:00 => 43
select  count(t.amount)
from transaction t
left join credit_card c on t.card = c.card
join card_holder h on c.cardholder_ID= h.cardholder_ID
where extract(hour from date) <= 9
	and extract(hour from date) >= 7
	and amount <=2;


CREATE VIEW count_all_small_transaction as
----- All transactions smaller than $2 => 353
select  count(t.amount)
from transaction t
where amount <=2;





CREATE VIEW top5_risky_merchant as
---- Top 5 merchant prone to being hacked using small transactions, in oder words where average amount is the smallest
select name
from merchant 
where id_merchant in 
	(
	select id_merchant
	 from transaction
	 group by id_merchant
	 order by AVG(amount) Asc
	 limit 5
	);
	
	