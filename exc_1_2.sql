CREATE SCHEMA DM;


create table dm.lg_messages ( 	
		record_id int not null,
		date_time timestamp not null,
		pid int not null,
		message varchar(4000) not null,
		message_type int not null,
		usename varchar(60), 
		datname varchar(60), 
		client_addr varchar(60),  
		application_name varchar(60),
		backend_start timestamp with time zone
    );
	
select * from dm.lg_messages; 

truncate table dm.lg_messages; 

CREATE SEQUENCE dm.seq_lg_messages START 1;


--------------------------------------------------------------------
CREATE TABLE DM.DM_ACCOUNT_TURNOVER_F(
	on_date date,
	account_rk numeric(23,8),
	credit_amount numeric(23,8),
	credit_amount_rub numeric(23,8),
	debet_amount numeric(23,8),
	debet_amount_rub numeric(23,8)
);

truncate table DM.DM_ACCOUNT_TURNOVER_F;

select * from DM.DM_ACCOUNT_TURNOVER_F;


-----------------------------------------------------------------------

CREATE TABLE DM.DM_F101_ROUND_F(
	FROM_DATE date,
	TO_DATE date,
	CHAPTER varchar(1),
	LEDGER_ACCOUNT varchar(5),
	CHARACTERISTIC varchar(1),
	BALANCE_IN_RUB numeric(23,8),
	R_BALANCE_IN_RUB numeric(23,8),
	BALANCE_IN_VAL numeric(23,8),
	R_BALANCE_IN_VAL numeric(23,8),
	BALANCE_IN_TOTAL numeric(23,8),
	R_BALANCE_IN_TOTAL numeric(23,8),
	TURN_DEB_RUB numeric(23,8),
	R_TURN_DEB_RUB numeric(23,8),
	TURN_DEB_VAL numeric(23,8),
	R_TURN_DEB_VAL numeric(23,8),
	TURN_DEB_TOTAL numeric(23,8),
	R_TURN_DEB_TOTAL numeric(23,8),
	TURN_CRE_RUB numeric(23,8),
	R_TURN_CRE_RUB numeric(23,8),
	TURN_CRE_VAL numeric(23,8),
	R_TURN_CRE_VAL numeric(23,8),
	TURN_CRE_TOTAL numeric(23,8),
	R_TURN_CRE_TOTAL numeric(23,8),
	BALANCE_OUT_RUB numeric(23,8),
	R_BALANCE_OUT_RUB numeric(23,8),
	BALANCE_OUT_VAL numeric(23,8),
	R_BALANCE_OUT_VAL numeric(23,8),
	BALANCE_OUT_TOTAL numeric(23,8),
	R_BALANCE_OUT_TOTAL numeric(23,8)
);

select * from DM.DM_F101_ROUND_F;

truncate table DM.DM_F101_ROUND_F;


call dm.fill_f101_round_f('2018-01-15');



DO $$
DECLARE
    start_date DATE := '2018-01-01';
    end_date DATE := '2018-01-31';
    date_val DATE;
BEGIN
    FOR date_val IN SELECT generate_series(start_date, end_date, '1 day')::DATE LOOP
		call dm.fill_account_turnover_f(date_val); 
		PERFORM pg_sleep(1);
    END LOOP;
END $$;
