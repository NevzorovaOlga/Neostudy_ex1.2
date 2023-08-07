CREATE SCHEMA DS;

CREATE TABLE DS.FT_BALANCE_F(
	ON_DATE date not null,
	ACCOUNT_RK int not null,
	CURRENCY_RK int,
	BALANCE_OUT float,
	CONSTRAINT ds_ft_balance_f_PK PRIMARY KEY (ON_DATE, ACCOUNT_RK)
);

truncate table DS.FT_BALANCE_F;

select * from  DS.FT_BALANCE_F;

select *
from DS.FT_BALANCE_F
where on_date = '2017-01-31' AND account_rk = 13905;

insert into logs.load_logs (source, action_datetime, action) values ('ALL', current_date, 'START');
insert into logs.load_logs (source, action_datetime, action) values ('ft_balance_f', current_date, 'END');

-----------------------------------------------------------------------

CREATE TABLE DS.FT_POSTING_F(
	oper_date date not null,
	credit_account_rk bigint not null,
	debet_account_rk bigint not null,
	credit_amount float8,
	debet_amount float8,
	CONSTRAINT ds_ft_posting_f_PK PRIMARY KEY (oper_date, credit_account_rk, debet_account_rk)
);

truncate table DS.FT_POSTING_F;

select * from  DS.FT_POSTING_F;

insert into logs.load_logs (source, action_datetime, action) values ('ft_posting_f', current_date, 'END');

--------------------------------------------------------------------------

CREATE TABLE DS.MD_ACCOUNT_D(
	data_actual_date date not null,
	data_actual_end_date date not null,
	account_rk bigint not null,
	account_number varchar(20) not null,
	char_type varchar(1) not null,
	currency_rk int not null,
	currency_code varchar(3) not null,
	CONSTRAINT ds_md_account_d_PK PRIMARY KEY (data_actual_date, data_actual_end_date, account_rk)
);

truncate table DS.MD_ACCOUNT_D;

select * from DS.MD_ACCOUNT_D;


insert into logs.load_logs (source, action_datetime, action) values ('md_account_d', current_date, 'END');
--------------------------------------------------

CREATE TABLE DS.MD_CURRENCY_D(
	currency_rk int not null,
	data_actual_date date not null,
	data_actual_end_date date,
	currency_code varchar(3),
	code_iso_char varchar(3),
	CONSTRAINT ds_md_currency_d_PK PRIMARY KEY (currency_rk, data_actual_date)
);

truncate table DS.MD_CURRENCY_D;

select * from DS.MD_CURRENCY_D;

insert into  DS.MD_CURRENCY_D value (99, );

insert into logs.load_logs (source, action_datetime, action) values ('md_currency_d', current_date, 'END');

------------------------------------------------------------------

CREATE TABLE DS.MD_EXCHANGE_RATE_D(
	data_actual_date date not null,
	data_actual_end_date date,
	currency_rk int not null,
	reduced_cource double precision,
	code_iso_num varchar(3),
	CONSTRAINT ds_md_exchange_rate_d PRIMARY KEY (data_actual_date, currency_rk)
);

truncate table DS.MD_EXCHANGE_RATE_D;

select * from DS.MD_EXCHANGE_RATE_D;


insert into logs.load_logs (source, action_datetime, action) values ('md_exchange_rate_d', current_date, 'END');

-------------------------------------------------
CREATE TABLE DS.MD_LEDGER_ACCOUNT_S(
	chapter char(1),
	chapter_name varchar(16),
	section_number int,
	section_name varchar(22),
	subsection_name varchar(21),
	ledger1_account int,
	ledger1_account_name varchar(47),
	ledger_account int not null,
	ledger_account_name varchar(153),
	characteristic char(1),
	is_resident int,
	is_reserve int,
	is_reserved int,
	is_loan int,
	is_reserved_assets int,
	is_overdue int,
	is_interest int,
	pair_account varchar(5),
	start_date date not null,
	end_date date,
	is_rub_only int,
	min_term varchar(1),
	min_term_measure varchar(1),
	max_term varchar(1),
	max_term_measure varchar(1),
	ledger_acc_full_name_translit varchar(1),
	is_revaluation varchar(1),
	is_correct varchar(1),
	CONSTRAINT ds_md_ledger_account_s_PK PRIMARY KEY (ledger_account, start_date)
);

truncate table DS.MD_LEDGER_ACCOUNT_S;

select * from DS.MD_LEDGER_ACCOUNT_S;

insert into logs.load_logs (source, action_datetime, action) values ('md_ledger_account_s', current_date, 'END');


-------------------------------------------------------------------------------
--Схема для  логирования

CREATE SCHEMA LOGS;

--Логирование процесса загрузки данных из файлов
CREATE TABLE LOGS.LOAD_LOGS(
	row_change_time timestamp default current_timestamp,
	source varchar(50),
	action_datetime date,
	action varchar(50)
);

truncate table LOGS.LOAD_LOGS;

select * from logs.load_logs;


---------------------------------------------------------------------
--Сбор ошибок

CREATE SCHEMA DDER;

CREATE TABLE DDER.FT_POSTING_F(
	oper_date varchar,
	credit_account_r varchar,
	debet_account_rk varchar,
	credit_amount varchar,
	debet_amount varchar,
	"errorCode" varchar,
	"errorMessage" varchar
);

truncate table DDER.FT_POSTING_F;

select * from  DDER.FT_POSTING_F;

------------------------------------------------------------

CREATE TABLE DDER.FT_BALANCE_F(
	ON_DATE varchar,
	ACCOUNT_RK varchar,
	CURRENCY_RK varchar,
	BALANCE_OUT varchar,
	"errorCode" varchar,
	"errorMessage" varchar
);

truncate table DDER.FT_BALANCE_F;

select * from  DDER.FT_BALANCE_F;

---------------------------------------------------------------


CREATE TABLE DDER.MD_ACCOUNT_D(
	data_actual_date varchar,
	data_actual_end_date varchar,
	account_rk varchar,
	account_number varchar,
	char_type varchar,
	currency_rk varchar,
	currency_code varchar,
	"errorCode" varchar,
	"errorMessage" varchar
);

truncate table DDER.MD_ACCOUNT_D;

select * from DDER.MD_ACCOUNT_D;

--------------------------------------------------


CREATE TABLE DDER.MD_CURRENCY_D(
	currency_rk varchar,
	data_actual_date varchar,
	data_actual_end_date varchar,
	currency_code varchar,
	code_iso_char varchar,
	"errorCode" varchar,
	"errorMessage" varchar
);

truncate table DDER.MD_CURRENCY_D;

select * from DDER.MD_CURRENCY_D;

-----------------------------------------

CREATE TABLE DDER.MD_EXCHANGE_RATE_D(
	data_actual_date varchar,
	data_actual_end_date varchar,
	currency_rk int,
	reduced_cource varchar,
	code_iso_num varchar,
	"errorCode" varchar,
	"errorMessage" varchar
);

truncate table DDER.MD_EXCHANGE_RATE_D;

select * from DDER.MD_EXCHANGE_RATE_D;

-----------------------------------------

-------------------------------------------------

CREATE TABLE DDER.MD_LEDGER_ACCOUNT_S(
	chapter varchar,
	chapter_name varchar,
	section_number varchar,
	section_name varchar,
	subsection_name varchar,
	ledger1_account varchar,
	ledger1_account_name varchar,
	ledger_account varchar,
	ledger_account_name varchar,
	characteristic varchar,
	is_resident varchar,
	is_reserve varchar,
	is_reserved varchar,
	is_loan varchar,
	is_reserved_assets varchar,
	is_overdue varchar,
	is_interest varchar,
	pair_account varchar,
	start_date varchar,
	end_date varchar,
	is_rub_only varchar,
	min_term varchar,
	min_term_measure varchar,
	max_term varchar,
	max_term_measure varchar,
	ledger_acc_full_name_translit varchar,
	is_revaluation varchar,
	is_correct varchar,
	"errorCode" varchar,
	"errorMessage" varchar
);

truncate table DDER.MD_LEDGER_ACCOUNT_S;

select * from DDER.MD_LEDGER_ACCOUNT_S;


select * from DM.DM_ACCOUNT_TURNOVER_F;