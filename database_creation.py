import mysql.connector as mysql
import re

db = mysql.connect(host='localhost',user='root',password='root')

cur = db.cursor()



print("-------------------o------------------------")
print("\n[INFO] Executing SQL script file")

statement = ""


with open('database_commands.sql','r') as fp:
    data = fp.readlines()
    
    for line in data:
       

        if re.match(r'--', line):
            continue
        if not re.search(r';$',line):
            statement +=line
        
       
        else:
            statement+=line
            # print(statement)  
            cur.execute(statement)
            statement =""


print("\n[INFO] Successful in creating database\n")
print("-------------------o------------------------")

db.commit()

db.close()