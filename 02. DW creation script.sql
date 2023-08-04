CREATE TABLE Users (
    user_id SMALLINT PRIMARY KEY UNIQUE,
    dem_id SMALLINT UNIQUE,
    psy_id SMALLINT UNIQUE,
    med_id SMALLINT UNIQUE,
    fin_id SMALLINT UNIQUE,
    brow_id SMALLINT UNIQUE
)

COPY Users(user_id, dem_id, psy_id, med_id, fin_id, brow_id)
FROM 'C:\Users\Public\DW\___USERS\Users_FT.csv'
DELIMITER ','
CSV HEADER;


CREATE TABLE demographics (
    dem_id INT PRIMARY KEY UNIQUE REFERENCES Users (dem_id),
    age SMALLINT,
    gender VARCHAR(6),
    workclass VARCHAR(20),
    education VARCHAR(20),
    occupation VARCHAR(30),
    salary VARCHAR(10),
    marital_status VARCHAR(20),
    race VARCHAR(30),
    zipcode INT,
    user_id SMALLINT UNIQUE
)

COPY demographics(dem_id, age, gender, workclass, education, occupation, salary, marital_status, race, zipcode, user_id)
FROM 'C:\Users\Public\DW\___DEMOGRAPHICS\demographics.csv'
DELIMITER ','
CSV HEADER;


CREATE TABLE browser(
    brow_id SMALLINT UNIQUE REFERENCES Users (brow_id),
    log_id SMALLINT UNIQUE,
    cookie_id SMALLINT UNIQUE,
    hist_id SMALLINT UNIQUE,
    ads_id SMALLINT UNIQUE,
    ip_address VARCHAR(30)
)

COPY browser(brow_id, log_id, cookie_id, hist_id, ads_id, ip_address)
FROM 'C:\Users\Public\DW\____BROWSER\browser_fact_table.csv'
DELIMITER ','
CSV HEADER;


CREATE TABLE cookies(
    cookie_id SMALLINT UNIQUE REFERENCES browser (cookie_id),
    manufacturer_name VARCHAR(100),
    model_name VARCHAR(50),
    url_host VARCHAR(50),
    cpe_type VARCHAR(50),
    model_os_type VARCHAR(15),
    date DATE,
    part_of_day VARCHAR(20),
    request_cnt INT,
    user_id INT UNIQUE
);

COPY cookies(cookie_id, manufacturer_name, model_name, url_host, cpe_type, model_os_type, date, part_of_day, request_cnt, user_id)
FROM 'C:\Users\Public\DW\____BROWSER\cookies\cookies.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE history(
    hist_id INT UNIQUE UNIQUE REFERENCES browser (hist_id),
    url TEXT,
    first_visit TIMESTAMP,
    last_visit TIMESTAMP,
    click_count INT,
    frequency INT,
    user_id SMALLINT
);

COPY history(hist_id, url, first_visit, last_visit, click_count, frequency, user_id)
FROM 'C:\Users\Public\DW\____BROWSER\web_history\p_history\web_history.csv'
DELIMITER ','
CSV HEADER;


CREATE TABLE logs(
    log_id SMALLINT REFERENCES browser (log_id),
    date TIMESTAMP,
    url TEXT,
    status INT,
    user_id SMALLINT
);

COPY logs(log_id, date, url, status, user_id)
FROM 'C:\Users\Public\DW\____BROWSER\logs\logs.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE click_ads(
    ads_id SMALLINT UNIQUE REFERENCES browser (ads_id),
    click CHAR(1),
    user_id SMALLINT
);

COPY click_ads(ads_id, click, user_id)
FROM 'C:\Users\Public\DW\____BROWSER\click on add prediction\click_ads.csv'
DELIMITER ','
CSV HEADER;


CREATE TABLE financial (
    fin_id SMALLINT PRIMARY KEY UNIQUE REFERENCES Users (fin_id),
    ctransaction_id SMALLINT UNIQUE,
    loan_id SMALLINT UNIQUE,
    olshop_id SMALLINT UNIQUE
)

COPY financial(fin_id, ctransaction_id, loan_id, olshop_id)
FROM 'C:\Users\Public\DW\____FINANCIAL\FT\fin_fact_table.csv'
DELIMITER ','
CSV HEADER;



CREATE TABLE credit_card(
    ctransaction_id SMALLINT PRIMARY KEY UNIQUE REFERENCES financial(ctransaction_id),
    user_id SMALLINT,
    credit_card_no VARCHAR(20),
    transaction_date DATE,
    amount_withdrawn INT
)

COPY credit_card(ctransaction_id, user_id, credit_card_no, transaction_date, amount_withdrawn)
FROM 'C:\Users\Public\DW\____FINANCIAL\credit_card\credit_card.csv'
DELIMITER ','
CSV HEADER;


CREATE TABLE bank_loan(
    loan_id SMALLINT PRIMARY KEY UNIQUE REFERENCES financial (loan_id),
    user_id SMALLINT,
    housing VARCHAR(5),
    saving_accounts VARCHAR(20),
    checking_account VARCHAR(20),
    credit_amount INT,
    duration SMALLINT,
    purpose VARCHAR(30)
)

COPY bank_loan(loan_id, user_id, housing, saving_accounts, checking_account, credit_amount,	duration, purpose)
FROM 'C:\Users\Public\DW\____FINANCIAL\bank_loan\bank_loan.csv'
DELIMITER ','
CSV HEADER;



CREATE TABLE online_shopping(
    olshop_id SMALLINT PRIMARY KEY UNIQUE REFERENCES financial (olshop_id),
    user_id SMALLINT,
    transaction_time DATE,
    item VARCHAR(120),
    no_items_purchased VARCHAR(10),
    cost_per_item NUMERIC
)

COPY online_shopping(olshop_id, user_id, transaction_time, item, no_items_purchased, cost_per_item)
FROM 'C:\Users\Public\DW\____FINANCIAL\online_retail\online_retail.csv'
DELIMITER ','
CSV HEADER;

CREATE psychographics(
	psy_id SMALLINT PRIMARY KEY UNIQUE REFERENCES Users (psy_id),
	dating_id SMALLINT UNIQUE,
	review_id SMALLINT UNIQUE,
	sl_id SMALLINT UNIQUE
);

COPY psychographics (psy_id, dating_id, review_id, sl_id)
FROM 'C:\Users\Public\DW\___PSYCHOGRAPHICS\stress_level___\stress_level.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE dating_ap(
	dating_id SMALLINT PRIMARY KEY UNIQUE REFERENCES psychographics (dating_id),
	uer_id SMALLINT,
	status VARCHAR(30),
	orientation VARCHAR(30),
	body_type VARCHAR(30,
	diet VARCHAR(30),
	drinks VARCHAR(30),
	drugs VARCHAR(30),
	height SMALLINT,
	pets VACHAR(80),
	religion VARCHAR(80),
	sign VARCHAR(80),
	essay TEXT
);

COPY dating_app (dating_id, user_id, status, orientation, body_type, diet, drinks, drugs, height, pets, religion, sign, essay)
FROM 'C:\Users\Public\DW\___PSYCHOGRAPHICS\dating_app\dating_app.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE reviews(
	review_id SMALLINT PRIMARY KEY UNIQUE REFERENCES psychographics (review_id),
	user_id SMALLINT, 
	profie_name VARCHAR(100),
	timestamp timestamp,
	summary VARCHAR(250),
	review TEXT
)

COPY dating_app (dating_id, user_id, status, orientation, body_type, diet, drinks, drugs, height, pets, religion, sign, essay)
FROM 'C:\Users\Public\DW\___PSYCHOGRAPHICS\dating_app\dating_app.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE stress_level(
    sl_id SMALLINT PRIMARY KEY UNIQUE REFERENCES psychographics (sl_id),
    user_id SMALLINT,
    sr numeric,
    rr numeric,
    t numeric,
    lm numeric,
    bo numeric,
    rem numeric,
    srr numeric,
    hr numeric,
    stress_level VARCHAR(20)
)

COPY stress_level (sl_id, user_id, sr, rr, t, lm, bo, rem, srr, hr, stress_level)
FROM 'C:\Users\Public\DW\___PSYCHOGRAPHICS\stress_level___\stress_level.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE medical(
    med_id SMALLINT PRIMARY KEY UNIQUE REFERENCES Users (med_id),
    sm_id SMALLINT UNIQUE,
    search_id SMALLINT UNIQUE,
    mh_id SMALLINT UNIQUE,
    rate_id SMALLINT UNIQUE
)

COPY medical (med_id, sm_id, search_id, mh_id, rate_id)
FROM 'C:\Users\Public\DW\___MEDICAL\FT\med_fact_table.csv'
DELIMITER ','
CSV HEADER;
CREATE TABLE smartwatch (
    sm_id SMALLINT PRIMARY KEY UNIQUE REFERENCES medical (sm_id),
    user_id SMALLINT,
    activity_date DATE,
    total_steps INT,
    total_distance NUMERIC,
    active_minutes INT,
    lightly_active_minutes INT,
    sedentary_minutes INT,
    calories INT,
    minutes_asleep INT,
    minutes_in_bed INT
)

COPY smartwatch (sm_id, user_id, activity_date, total_steps, total_distance, active_minutes, lightly_active_minutes, sedentary_minutes, calories, minutes_asleep, minutes_in_bed)
FROM 'C:\Users\Public\DW\___MEDICAL\smart_watch\smart_watch.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE heart_rate(
    rate_id SMALLINT PRIMARY KEY UNIQUE REFERENCES medical (rate_id),
    user_id SMALLINT,
    datetime timestamp,
    rate SMALLINT
)

COPY heart_rate (rate_id, user_id, datetime, rate)
FROM 'C:\Users\Public\DW\___MEDICAL\heart_rate\heart_rate.csv'
DELIMITER ','
CSV HEADER;


CREATE TABLE searched_symptoms(
    search_id SMALLINT PRIMARY KEY UNIQUE REFERENCES medical (search_id),
    user_id SMALLINT,
    symptoms TEXT
)


COPY searched_symptoms (search_id, user_id, symptoms)
FROM 'C:\Users\Public\DW\___MEDICAL\searched_symptoms\symptoms.csv'
DELIMITER ','
CSV HEADER;

CREATE TABLE mental_health(
    mh_id SMALLINT PRIMARY KEY UNIQUE REFERENCES medical (mh_id),
    user_id SMALLINT,
    text TEXT
)

COPY mental_health (mh_id, user_id, text)
FROM 'C:\Users\Public\DW\___MEDICAL\mental_health_corpus\mental_health.csv'
DELIMITER ','
CSV HEADER;

