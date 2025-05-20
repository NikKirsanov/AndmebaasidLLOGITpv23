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







FOORUM: kasutajate / trigerite loomine / mariaDB / SQL Server /Oma ülesanne

CREATE DATABASE nikita;
USE nikita;

CREATE TABLE oigused (
    id INT IDENTITY(1,1) PRIMARY KEY,
    muuda BIT DEFAULT 0,
    kustuta BIT DEFAULT 0,
    lisa BIT DEFAULT 0
);

CREATE TABLE kasutajad (
    id INT IDENTITY(1,1) PRIMARY KEY,
    login VARCHAR(50) NOT NULL,
    parool VARCHAR(100) NOT NULL,
    oigus_id INT,
    FOREIGN KEY (oigus_id) REFERENCES oigused(id)
);

CREATE TABLE logi (
    id INT IDENTITY(1,1) PRIMARY KEY,
    tegevus VARCHAR(10),
    andmed NVARCHAR(MAX),
    kasutaja NVARCHAR(50),
    aeg DATETIME DEFAULT GETDATE()
);
INSERT INTO oigused (muuda, kustuta, lisa) VALUES (1, 1, 1); 

INSERT INTO kasutajad (login, parool, oigus_id) VALUES ('nikita', '123', 1);

CREATE TRIGGER kasutaja_insert ON kasutajad
AFTER INSERT
AS
BEGIN
    INSERT INTO logi(tegevus, andmed, kasutaja)
    SELECT 'INSERT', CONCAT('ID:', inserted.id, ', Login:', inserted.login), SYSTEM_USER
    FROM inserted;
END;

drop trigger trg_kasutajad_insert;

CREATE TRIGGER trg_kasutajad_update ON kasutajad
AFTER UPDATE
AS
BEGIN
    INSERT INTO logi(tegevus, andmed, kasutaja)
    SELECT 'UPDATE', CONCAT('ID:', inserted.id, ', Login:', inserted.login), SYSTEM_USER
    FROM inserted;
END;

CREATE TRIGGER trg_kasutajad_delete ON kasutajad
AFTER DELETE
AS
BEGIN
    INSERT INTO logi(tegevus, andmed, kasutaja)
    SELECT 'DELETE', CONCAT('ID:', deleted.id, ', Login:', deleted.login), SYSTEM_USER
    FROM deleted;
END;

CREATE TRIGGER trg_oigused_insert ON oigused
AFTER INSERT
AS
BEGIN
    INSERT INTO logi(tegevus, andmed, kasutaja)
    SELECT 'INSERT', CONCAT('ID:', inserted.id), SYSTEM_USER
    FROM inserted;
END;


CREATE TRIGGER trg_oigused_update ON oigused
AFTER UPDATE
AS
BEGIN
    INSERT INTO logi(tegevus, andmed, kasutaja)
    SELECT 'UPDATE', CONCAT('ID:', inserted.id), SYSTEM_USER
    FROM inserted;
END;


CREATE TRIGGER trg_oigused_delete ON oigused
AFTER DELETE
AS
BEGIN
    INSERT INTO logi(tegevus, andmed, kasutaja)
    SELECT 'DELETE', CONCAT('ID:', deleted.id), SYSTEM_USER
    FROM deleted;
END;
























