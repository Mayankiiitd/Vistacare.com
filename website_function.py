
import re
from flask import *
from flask_mysqldb import *
import MySQLdb.cursors
import mysql.connector as mysql










app=Flask(__name__)
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'mayank@1947'
app.config['MYSQL_DB'] = 'vistacare'


db = MySQL(app)

nonFlaskDB = mysql.connect(host='localhost',user='root',password='mayank@1947',database='vistacare')
nonFlaskCursor = nonFlaskDB.cursor()
# with open('database_creation.py') as fp:
#    exec(fp.read())

# nonFlaskCursor.execute('select * from customer')
# val = nonFlaskCursor.fetchall()
# print(val)




app.config['SECRET_KEY'] = 'VG05VUlGUm9OSFFnTXpSVFdRbz0K'
@app.route('/')  
@app.route('/login',methods=['GET','POST'])  
def login():
   msg=''
   
   if request.method == 'POST' and 'email' in request.form and 'passwd' in request.form:
      # print(request.form)

      usr = request.form['email']
      password = request.form['passwd']
      cursor = db.connection.cursor(MySQLdb.cursors.DictCursor)
      cursor.execute('select * from user where email = %s \
                     and passwd = %s',(usr,password,))
      
      acct = cursor.fetchone()
      # print(acct)
      cursor.execute('select * from admin')
      admin = cursor.fetchall()

      # print(admin)
      if acct:
         session['loggedin'] = True
         session['userID'] = acct['userID']
         session['email'] = acct['email']
         msg = 'Login Successful !'

         for i in admin:
            if i['email'] == acct['email'] and i['passwd'] == acct['passwd']:
               return redirect('/admin') 
         
         # return render_template('home.html',msg=msg)
         return redirect('/home')

      else:
         msg = 'Try Again .. Incorrect Email or Password'

   return render_template("login.html",msg=msg)



         



   

@app.route('/profile')
def profile():
   return render_template("profile.html")


@app.route('/salon_at_home')
def salon_at_home():
   return render_template("salon_at_home.html")



@app.route('/login_options')
def login_options():
   return render_template('options_for_login.html')


@app.route('/home')
def main_home():
   return render_template('home.html')



# REGS
@app.route('/register',methods=['GET','POST'])
def register():
   msg=''
   if request.method=='POST' and 'email' in request.form and 'passwd' in request.form:
         # DB Implementation for registering new user 
         # print('hi')
         if len(request.form['email']) == 0 or len(request.form['passwd']) == 0 or len(str(request.form['phone'])) != 10:
            msg = 'Try Again'
            # return render_template('register.html',msg=msg)
         else:

            usr = request.form['email']
            password = request.form['passwd']
            phone = int(request.form['phone'])
            name = request.form['name']
            addr = request.form['addr']
            age = int(request.form['age'])
            gender = request.form['gender']
            cursor = db.connection.cursor(MySQLdb.cursors.DictCursor)
            
            cursor.execute('select * from customer where email=%s',(usr,))
            if cursor.rowcount != 0:
               msg='A person with this Email Exists .. Try again'
               return render_template('register.html',msg=msg)
            l = list('1234567890@#$%^&*!~()')
            if len(password)<8 or not any(char in l for char in password) or not any(char.isupper() for char in password):
               msg = 'Invalid password'
               return render_template('register.html',msg=msg)

            cursor.execute('insert into user(email,passwd) values(%s ,%s)',(usr,password,))
            db.connection.commit()
            cursor.execute('insert into customer(name,age,phNo,gender,email,passwd,address) values(%s ,%s,%s,%s ,%s,%s,%s)',(name,age,phone,gender,usr,password,addr,))
            db.connection.commit()
            msg = 'Registration Successful .. Log in'

   return render_template('register.html',msg = msg)
                  






@app.route('/register_service',methods=['GET','POST'])
def register_service():  
   msg=''
   if request.method=='POST' and 'email' in request.form and 'passwd' in request.form:
         # DB Implementation for registering new user 
      
         if len(request.form['email']) == 0 or len(request.form['passwd']) == 0:
            msg = 'Try Again'
            
         else:

            usr = request.form['email']
            password = request.form['passwd']
            
            name = request.form['name']
            
            
            sub = request.form['sub']
            cursor = db.connection.cursor(MySQLdb.cursors.DictCursor)
            
            cursor.execute('select * from serviceProvider where email=%s',(usr,))
            if cursor.rowcount != 0:
               msg='A person with this Email Exists .. Try again'
               return render_template('register_service.html',msg=msg)
            l = list('1234567890@#$%^&*!~()')
            if len(password)<8 or not any(char in l for char in password) or not any(char.isupper() for char in password):
               msg = 'Invalid password'
               return render_template('register_service.html',msg=msg)

            cursor.execute('insert into user(email,passwd) values(%s ,%s)',(usr,password,))
            db.connection.commit()
            cursor.execute('insert into serviceProvider(name,rating,subType,email,passwd) values(%s ,%s,%s,%s ,%s)',(name,int('0'),sub,usr,password,))
            db.connection.commit()
            msg = 'Registration Successful .. Log in'

   return render_template('register_service.html',msg = msg)
   



@app.route('/register_manager')
def register_manager(): 
   msg=''
   if request.method=='POST' and 'email' in request.form and 'passwd' in request.form:
         # DB Implementation for registering new user 
      
         if len(request.form['email']) == 0 or len(request.form['passwd']) == 0:
            msg = 'Try Again'
            
         else:

            usr = request.form['email']
            password = request.form['passwd']
            
            name = request.form['name']
            
            
            age = int(request.form['age'])
            cursor = db.connection.cursor(MySQLdb.cursors.DictCursor)
            
            cursor.execute('select * from WareHouseManager where email=%s',(usr,))
            if cursor.rowcount != 0:
               msg='A person with this Email Exists .. Try again'
               return render_template('register_manager.html',msg=msg)
            l = list('1234567890@#$%^&*!~()')
            if len(password)<8 or not any(char in l for char in password) or not any(char.isupper() for char in password):
               msg = 'Invalid password'
               return render_template('register_manager.html',msg=msg)

            cursor.execute('insert into user(email,passwd) values(%s ,%s)',(usr,password,))
            db.connection.commit()
            cursor.execute('insert into WareHouseManager(name,age,email,passwd) values(%s ,%s,%s ,%s)',(name,age,usr,password,))
            db.connection.commit()
            msg = 'Registration Successful .. Log in'

   return render_template('register_manager.html',msg = msg)
 
# ADMIN FUNCTIONALITY

@app.route('/admin')
def admin_page():
   return render_template('admin.html')


@app.route('/inventory_analysis')
def inventory_analysis():
   

   return render_template('inventory_analysis.html')

@app.route('/customer_analysis')
def customer_analysis():
   print("-------------------o------------------------")
   print("[ INFO ] CUSTOMER ANALYSIS")
   print("-------------------o------------------------")
   print("[ INFO ] SERVICE PROVIDER ANALYSIS")
   print("-------------------o------------------------")

   nonFlaskCursor.execute('select * from serviceProvider')
   val = nonFlaskCursor.fetchall()
   print(val)
   print("-------------------o------------------------")

   print("[ INFO ] CONSUMER ANALYSIS")
   print("-------------------o------------------------")

   nonFlaskCursor.execute('select * from customer')
   val = nonFlaskCursor.fetchall()
   print(val)
   print("-------------------o------------------------")

   # print("-------------------o------------------------")

   print("[ INFO ] WAREHOUSE MANAGER ANALYSIS")
   print("-------------------o------------------------")

   

   return render_template('customer_analysis.html')


@app.route('/warehouse_analysis')
def warehouse_analysis():
   print("-------------------o------------------------")
   print("[ INFO ] WareHouse ANALYSIS")
   nonFlaskCursor.execute('select * from WareHouseManager')
   val = nonFlaskCursor.fetchall()
   print(val)
   print("-------------------o------------------------")

   return render_template('warehouse_analysis.html')


@app.route('/cart')
def cart():
   return render_template("cart.html")

@app.route('/products')
def products():
   return render_template('products.html')


@app.route('/payment')
def payment():
   return render_template('payment-portal.html')

@app.route('/pay_success')
def pay_success():
   return render_template('pay-success.html')

if __name__ == '__main__':
   app.run(debug=True)




