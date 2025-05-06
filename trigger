CREATE DATABASE trigerLOGIT
use trigerLOGIT

CREATE TABLE toode(
toodeID int PRIMARY KEY identity(1,1),
toodeNimetus varchar(25),
toodeHind decimal(5,2))
--taabel logi, mis täidab triger
CREATE TABLE logi(
id int primary key identity(1,1),
tegevus varchar(25),
kuupaev datetime,
andmed TEXT)
;
--INSERT triger, mis jälgib andmete lisamine toode-tabelis
CREATE TRIGGER toodeUuendamine
ON toode
FOR UPDATE
AS
INSERT INTO logi(tegevus, kuupaev, andmed)
SELECT 'toode on lisatud',
GETDATE(),
CONCAT('Vanad andmed - ', deleted.toodeNimetus, ', ', deleted.toodeHind, 'Uued andmed - ' inserted.toodeNimetus,', ',inserted,tooseHind, ' | tegi kasutaja ', SYSTEM_USER)
FROM deleted INNER KOIN inserted
ON deleted.tooseID=insterted.tooseID
from deleted;

DROP TRIGGER toodeLisamine
DELETE FROM toode
WHERE toodeID=3;
INSERT INTO toode(toodeNimetus, toodeHind)
VALUES ('Coca-Cola', 999)
SELECT * FROM toode;
SELECT * FROM logi;


UPDATE toode SET toodeHind=4.00
WHERE toodeNimetus='Fanta'
SELECT * FROM toode;
SELECT * FROM logi;

CREATE TABLE products(
    product_id INT IDENTITY PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    model_year SMALLINT NOT NULL,
    list_price DEC(10,2) NOT NULL,
);
CREATE TABLE product_audits(
    change_id INT IDENTITY PRIMARY KEY,
    product_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    model_year SMALLINT NOT NULL,
    list_price DEC(10,2) NOT NULL,
    updated_at DATETIME NOT NULL,
    operation CHAR(3) NOT NULL,
    CHECK(operation = 'INS' or operation='DEL')
);
drop trigger trg_product_audit;
CREATE TRIGGER trg_product_audit
ON products
AFTER INSERT, DELETE
AS
BEGIN
SET NOCOUNT ON;
INSERT INTO product_audits(
        product_id,
        product_name,
        brand_id,
        category_id,
        model_year,
        list_price,
        updated_at,
        operation
    )
    SELECT
        i.product_id,
        product_name,
        brand_id,
        category_id,
        model_year,
        i.list_price,
        GETDATE(),
        'INS'
    FROM
        inserted i
    UNION ALL
    SELECT
        d.product_id,
        product_name,
        brand_id,
        category_id,
        model_year,
        d.list_price,
        GETDATE(),
        'DEL'
    FROM
        deleted d;
END
INSERT INTO products(
    product_name,
    brand_id,
    category_id,
    model_year,
    list_price
)
VALUES (
    'Test product',
    1,
    1,
    2018,
    599
);
SELECT
    *
FROM
    product_audits;
DELETE FROM
   products
WHERE
    product_id = 2;
SELECT
    *
FROM
    product_audits;

SELECT
    *
FROM
    products;
