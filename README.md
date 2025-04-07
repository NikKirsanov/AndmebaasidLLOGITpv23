## Admetüübid
1. **Arvulised** - int, decimal(5,2), kus 2 numbri peale koma, bigint, smallint, real 
2. **Teksti/sümboolid** - varchar(255). CHAR(10), TEXT
Näited: telefoninumbeer, nimi, nimetus, isikukood, aadress
3. **Kuupäeva** - DATE, TIME, data/time
4. **loogilised** - bt.boolean, true/false


## Pirangud - ограничения 
1. Primary key - primaarne võti - первичный ключ - определяет уникальное значение для каждой строки / määrab unikaalne väärtus iga rea kohta
2.UNIQUE
3.NOT NULL - ei luba tühja väärtust
4. FOREIGN KEY - VÕÕRVÕTI/ VÄLINE VÕTI - вторичный ключ
определяет набор значений из другой таблицы
5. CHECK - CHECK(naine, mees) - определяет набор значений 
