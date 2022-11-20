# date dealer

1. integer to date

   [convert sting to Date data type in spark sql](https://learn.microsoft.com/en-us/answers/questions/509162/convert-sting-to-date-data-type-in-spark-sql.html)

   ```sql
    to_date("20220101","yyyyMMdd")
   ```

2. date segements: year month day

   ​	month(to_date("20220101","yyyyMMdd"))

3. dateformat

   date_format(to_date("20220101","yyyyMMdd")， "yyyy-MM")





# Loop sql

```python
sql_list = [f"select * from survey_db.{table}" for table in table_array]
for sql in sql_list:
    df = spark.sql(sql)
    df.show()
```