import MySQLdb
from flask import Flask, render_template, request, session, url_for, redirect, flash
from flask_mysqldb import MySQL
from datetime import datetime


app = Flask(__name__)
app.secret_key = "super_key"

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'jewellery_shopping'
mysql = MySQL(app)

@app.route('/')
@app.route('/login', methods=['GET', 'POST'])
def login():
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    msg = ""
    if request.method == 'POST':
        session.pop('AID', None)
        Username = request.form['Username']
        Password = request.form['Password']
        cursor.execute("SELECT * FROM admin where AID=%s AND Password = %s", (Username, Password))
        Arecord = cursor.fetchone()
        cursor.execute("SELECT * FROM employee where EID=%s AND EPass = %s", (Username, Password))
        Erecord = cursor.fetchone()
        if Arecord:
            session['loggendin'] = True
            session['AID'] = Arecord['AID']
            session['Password'] = Arecord['Password']
            msg = 'Logged in successfully!'
            flash(msg)
            return redirect(url_for('adminlogin'))
        elif Erecord:
            session['loggendin'] = True
            session['EID'] = Erecord['EID']
            session['EPass'] = Erecord['EPass']
            msg = 'Logged in successfully!'
            flash(msg)
            return render_template('custlogin.html', EID=Username)
        else:
            msg = "Incorrect username/Password"
            flash(msg)
    return render_template('login.html')

@app.route('/custlogin')
def custlogin():
        orders = []
        return render_template('custlogin.html')

@app.route('/custinfo', methods=['GET', 'POST'])
def custinfo():
        cur = mysql.connection.cursor()
        cust = cur.execute("SELECT * FROM customer ORDER BY CID")
        if cust>0:
                custdetails = cur.fetchall()
                mysql.connection.commit()
                cur.close()
                return render_template('custinfo.html', custdetails = custdetails)



@app.route('/custadd/<id>', methods=['GET', 'POST'])
def custadd(id):
        msg = ""
        cur = mysql.connection.cursor()
        cur.execute("SELECT MAX(CID) FROM customer")
        result = cur.fetchall()
        for i in result:
                max = float(i[0])
                max = max+1
        if request.method == 'POST':
                CName = request.form['cname']
                cno = request.form['cno']
                addr = request.form['caddr']
                gcid = request.form['gcid']
                cur.execute("INSERT INTO customer (CName, CID, CAddr, CCont, CGID, EID) VALUES (%s, %s, %s, %s, %s, %s)", (CName, max, addr, cno, gcid, id))
                msg ="New customer added successfully!"
                mysql.connection.commit()
                cur.close()
                return get_url(max, id, msg)

def get_url(a, id, msg):
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM customer WHERE CID=%s", [a])
        data= cur.fetchone()
        flash(msg)
        mysql.connection.commit()
        cur.close()
        return render_template('itemsadd.html', cust=data, id = id)


@app.route('/empadd')
def empadd():
        return render_template('empadd.html')



@app.route('/itemsadd/<id>', methods=['GET', 'POST'])
def get_itemsdetails(id):
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM customer WHERE CID=%s", [id])
        data= cur.fetchone()
        mysql.connection.commit()
        cur.close()
        return render_template('itemsadd.html', cust=data)


@app.route('/employeeadd', methods=['POST'])
def employeeadd():
        msg = ""
        cur = mysql.connection.cursor()
        if request.method == 'POST':
                EName = request.form['EName']
                Pass = request.form['Pass']
                GID = request.form['GID']
                section = request.form['section']
                shift = request.form['shift']
                cno = request.form['cno']
                salary = request.form['salary']
                addr = request.form['addr']
                cur = mysql.connection.cursor()
                cur.execute("INSERT INTO employee (EName, EPass, EAddr, Section, Shift, EGID, Salary, AID) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)", (EName, Pass, addr, section, shift, GID, salary, "admin101"))
                cur.execute("SELECT last_insert_id()")
                data = cur.fetchone()
                id = data[0]
                cur.execute("INSERT INTO empcontact (EID, Econt) VALUES (%s, %s)", (id, cno))
                msg = "Employee added successfully!"
                flash(msg)
                mysql.connection.commit()
                cur.close()
                return render_template('addcontact.html', data = data, id = id)

@app.route('/contactdisplay/<id>', methods=['GET', 'POST'])
def contactdisplay(id):
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM empcontact WHERE EID=%s", [id])
        contactdetails= cur.fetchall()
        mysql.connection.commit()
        cur.close()
        return render_template('contactdisplay.html', contactdetails = contactdetails, id = id)

@app.route('/contactdelete/<id>/<cno>', methods=['GET', 'POST'])
def contactdelete(id, cno):
        cur = mysql.connection.cursor()
        cur.execute("DELETE FROM empcontact WHERE (EID, Econt)=(%s, %s)", (id,cno))
        cur.execute("SELECT * FROM empcontact WHERE EID=%s", [id])
        contactdetails= cur.fetchall()
        mysql.connection.commit()
        cur.close()
        return render_template('contactdisplay.html', contactdetails = contactdetails, id = id)

@app.route('/addcontact/<id>', methods=['GET', 'POST'])
def addcontact(id):
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM employee WHERE EID=%s", [id])
        data= cur.fetchone()
        if request.method == 'POST':
                cno = request.form['cno']
                cur.execute("INSERT INTO empcontact (EID, Econt) VALUES (%s, %s)", (id, cno))
        mysql.connection.commit()
        cur.close()
        return render_template('addcontact.html', data = data, id = id)

@app.route('/empdisplay')
def empdisplay():
    cur = mysql.connection.cursor()
    emp = cur.execute("SELECT * FROM employee ORDER BY EID")
    if emp>0:
        empdetails = cur.fetchall()
        mysql.connection.commit()
        cur.close()
        return render_template('empdisplay.html', empdetails = empdetails)


@app.route('/adminlogin', methods=['GET', 'POST'])
def adminlogin():
        return render_template('adminlogin.html')


@app.route('/empdel')
def empdel():
        cur = mysql.connection.cursor()
        emp = cur.execute("SELECT * FROM employee ORDER BY EID")
        empdetails = cur.fetchall()
        mysql.connection.commit()
        cur.close()
        return render_template('empdel.html', empdetails = empdetails)



@app.route('/empreset', methods=['GET', 'POST'])
def empreset():
        return render_template('empreset.html')
        

@app.route('/resetpassword', methods=['POST'])
def resetpassword():
        msg = ""
        if request.method == 'POST':
                EID = request.form['eid']
                Pass = request.form['npass']
                CPass = request.form['cnpass']
                cur = mysql.connection.cursor()
                cur.execute("""UPDATE employee
                SET EPass=%s where EID=%s""",(CPass, EID))
                msg = "Password updated successfully!"
                flash(msg)
                mysql.connection.commit()
                cur.close()
                return redirect(url_for('empdisplay'))

@app.route('/empedit/<id>', methods=['GET', 'POST'])
def get_contact(id):
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM employee WHERE EID=%s", [id])
        data= cur.fetchone()
        mysql.connection.commit()
        cur.close()
        return render_template('empedit.html', employee=data)

@app.route('/empupdate/<id>', methods=['POST'])
def update_employee(id):
        msg = ""
        if request.method == 'POST':
                EName = request.form['EName']
                Pass = request.form['Pass']
                GID = request.form['GID']
                section = request.form['section']
                shift = request.form['shift']
                salary = request.form['salary']
                addr = request.form['addr']
                cur = mysql.connection.cursor()
                cur.execute("""UPDATE employee
                SET EName=%s, EPass=%s, 
                EGID = %s, Section= %s, Shift=%s,
                Salary=%s, EAddr=%s where EID=%s""", (EName, Pass, 
                GID, section, shift, salary, addr, id))
                msg = "Employee updated successfully!"
                flash(msg)
                mysql.connection.commit()
                cur.close()
                return redirect(url_for('empdel'))


    
@app.route('/empdelete/<id>', methods=['GET', 'POST'])
def empdelete(id):
        msg = ""
        cur = mysql.connection.cursor()
        cur.execute("DELETE FROM employee WHERE EID=%s",[id])
        mysql.connection.commit()
        msg = "Employee deleted successfully!"       
        flash(msg)
        cur.close()
        return redirect(url_for('empdel'))

@app.route('/supadd')
def supadd():
        return render_template('supadd.html')
    
@app.route('/supplieradd', methods=['POST'])
def supplieradd():
        msg = ""
        cur = mysql.connection.cursor()
        if request.method == 'POST':
                SName = request.form['SName']
                Company = request.form['Company']
                Companycode = request.form['Compcode']
                Scont = request.form['SCont']
                SAddr = request.form['SAddr']
                cur = mysql.connection.cursor()
                cur.execute("INSERT INTO supplier (SName, Company, Compcode, SCont, SAddr, AID) VALUES (%s, %s, %s, %s, %s, %s)", (SName, Company, Companycode, Scont, SAddr, "admin101"))
                msg = "Supplier added successfully!"
                flash(msg)
                mysql.connection.commit()
                cur.close()
                return redirect(url_for('supdisplay'))

@app.route('/supdisplay')
def supdisplay():
    cur = mysql.connection.cursor()
    sup = cur.execute("SELECT * FROM supplier ORDER BY SID")
    if sup>0:
        supdetails = cur.fetchall()
        mysql.connection.commit()
        cur.close()
        return render_template('supdisplay.html', supdetails = supdetails)

@app.route('/supdel')
def supdel():
        cur = mysql.connection.cursor()
        sup = cur.execute("SELECT * FROM supplier ORDER BY SID")
        supdetails = cur.fetchall()
        mysql.connection.commit()
        cur.close()
        return render_template('supdel.html', supdetails = supdetails)

@app.route('/supdelete/<id>', methods=['GET', 'POST'])
def supdelete(id):
        msg = ""
        cur = mysql.connection.cursor()
        cur.execute("DELETE FROM supplier WHERE SID=%s",[id])
        mysql.connection.commit()   
        msg = "Supplier deleted successfully!"    
        flash(msg)
        return redirect(url_for('supdel'))

@app.route('/supedit/<id>', methods=['GET', 'POST'])
def get_supplier(id):
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM supplier WHERE SID=%s", [id])
        data= cur.fetchone()
        mysql.connection.commit()
        cur.close()
        return render_template('supedit.html', supplier=data)

@app.route('/supupdate/<id>', methods=['POST'])
def update_supplier(id):
        msg = ""
        if request.method == 'POST':
                SName = request.form['SName']
                Company = request.form['Company']
                Compcode = request.form['Compcode']
                SAddr = request.form['SAddr']
                SCont = request.form['SCont']
                cur = mysql.connection.cursor()
                cur.execute("""UPDATE supplier
                SET SName=%s, Company=%s, 
                Compcode = %s, SAddr= %s, SCont=%s where SID=%s""", (SName, Company, 
                Compcode, SAddr, SCont, id))
                msg = "Supplier updated successfully!"
                flash(msg)
                mysql.connection.commit()
                cur.close()
                return redirect(url_for('supdel'))

@app.route('/stockadd')
def stockadd():
        return render_template('stockadd.html')
    

@app.route('/jeweladd', methods=['POST'])
def jeweladd():
        msg = ""
        if request.method == 'POST':
                SID = request.form['SID']
                TOJ = request.form['TOJ']
                SQuantity = request.form['SQuantity']
                Gold = request.form['Gold']
                if(TOJ == "Ring" and Gold == "G22"):
                        JID = 3001
                elif(TOJ == "Earings" and Gold == "G24"):
                        JID = 3002
                elif(TOJ == "Bangles" and Gold == "G22"):
                        JID = 3003
                elif(TOJ == "Necklace" and Gold == "G24"):
                        JID = 3004
                elif(TOJ == "Mangalsutra" and Gold == "G22"):
                        JID = 3005
                elif(TOJ == "Bracelet" and Gold == "G22"):
                        JID = 3006
                elif(TOJ == "Anklets" and Gold == "S925"):
                        JID = 3007
                else:
                        JID = 3008
                Grams = request.form['Grams']
                cur = mysql.connection.cursor()
                cur.execute("INSERT INTO jewel (JID, SID, TOJ, SQuantity, Gold, Grams, AID) VALUES (%s, %s, %s, %s, %s, %s, %s)", (JID, SID, TOJ, SQuantity, Gold, Grams, "admin101"))
                msg = "Stock added successfully!"
                flash(msg)
                mysql.connection.commit()
                cur.close()
                return redirect(url_for('stockdisplay'))

@app.route('/stockdisplay')
def stockdisplay():
    cur = mysql.connection.cursor()

    jewel = cur.execute("SELECT * FROM jewel ORDER BY JID")

    if jewel>0:
        jeweldetails = cur.fetchall()
        mysql.connection.commit()
        cur.close()
        return render_template('stockdisplay.html', jeweldetails = jeweldetails)

@app.route('/stockdel')
def stockdel():
        cur = mysql.connection.cursor()
        stock = cur.execute("SELECT * FROM jewel ORDER BY JID")
        stockdetails = cur.fetchall()
        return render_template('stockdel.html', stockdetails = stockdetails)

@app.route('/stockdelete/<id>', methods=['GET', 'POST'])
def stockdelete(id):
        msg = ""
        cur = mysql.connection.cursor()
        cur.execute("DELETE FROM jewel WHERE JID=%s",[id])
        mysql.connection.commit()   
        msg = "Stock deleted successfully!"
        flash(msg)
        cur.close()
        return redirect(url_for('stockdel'))

@app.route('/stockedit/<id>', methods=['GET', 'POST'])
def get_stockdetails(id):
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM jewel WHERE JID=%s", [id])
        data= cur.fetchone()
        mysql.connection.commit()
        cur.close()
        return render_template('stockedit.html', jewel=data)

@app.route('/stockupdate/<id>', methods=['POST'])
def update_stock(id):
        msg = ""
        if request.method == 'POST':
                SID = request.form['SID']
                TOJ = request.form['TOJ']
                SQuantity = request.form['SQuantity']
                Gold = request.form['Gold']
                Grams = request.form['Grams']
                cur = mysql.connection.cursor()
                cur.execute("""UPDATE jewel
                SET SID=%s, TOJ=%s, 
                SQuantity = %s, Gold= %s, Grams=%s where JID=%s""", (SID, TOJ, 
                SQuantity, Gold, Grams, id))
                msg = "Stock updated successfully!"
                flash(msg)
                mysql.connection.commit()
                cur.close()
                return redirect(url_for('stockdel'))



@app.route('/baseupdate')
def baseupdate():
        cur = mysql.connection.cursor()
        base = cur.execute("SELECT * FROM base ORDER BY Pure")
        basedetails = cur.fetchall()
        mysql.connection.commit()
        cur.close()
        return render_template('baseupdate.html', basedetails = basedetails)

@app.route('/baseedit/<id>', methods=['GET', 'POST'])
def get_basedetails(id):
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM base WHERE Pure=%s", [id])
        data= cur.fetchone()
        mysql.connection.commit()
        cur.close()
        return render_template('baseedit.html', base=data)

@app.route('/basegetupdate/<id>', methods=['POST'])
def update_base(id):
        msg = ""
        if request.method == 'POST':
                Rate = request.form['Rate']
                cur = mysql.connection.cursor()
                cur.execute("""UPDATE base
                SET Rate=%s where Pure=%s""", (Rate, id))
                msg = "Base upadated successfully!"
                flash(msg)
                mysql.connection.commit()
                cur.close()
                return redirect(url_for('baseupdate'))

orders = []
@app.route('/getorder/<id>', methods=['POST'])
def getorder(id):
        msg = ""
        cur = mysql.connection.cursor()
        global orders
        cur.execute("SELECT * FROM customer WHERE CID=%s", [id])
        data= cur.fetchone()
        if request.method == 'POST':
                JID = request.form['name[]']
                Quantity = int(request.form['quant[]'])
                cur.execute("SELECT SQuantity FROM jewel where JID=%s", [Quantity])
                result = cur.fetchall()
                
                for i in result:
                        quan = int(i[0])
                        quan = quan-Quantity
                        cur.execute("UPDATE jewel SET SQuantity=%s where JID=%s", (quan, JID)) 
                cur.execute("SELECT TOJ, Gold, Grams FROM jewel where JID=%s", [JID])
                details = cur.fetchone()
                cur.execute("SELECT Rate FROM base where Pure=%s", [details[1]])
                rate = cur.fetchone()
                Total = rate[0]*Quantity
                orders.append([JID, Quantity, details[2], details[1], rate[0], Total])
                mysql.connection.commit()
                cur.close()
        return render_template('itemsadd.html', cust = data, orders = orders)

@app.route('/remove/<id>', methods=['GET', 'POST'])
def remove(id):
        msg = ""
        cur = mysql.connection.cursor()
        cur.execute("SELECT * FROM customer WHERE CID=%s", [id])
        data= cur.fetchone()
        orders.pop()
        msg = "Jewellery deleted successfully!"
        flash(msg)
        mysql.connection.commit()
        cur.close()
        return render_template('itemsadd.html', cust = data, orders = orders)


@app.route('/bill', methods=['GET', 'POST'])
def bill():
        cur = mysql.connection.cursor()
        cur.execute("SELECT MAX(BID) FROM bill")
        result = cur.fetchall()
        for i in result:
                max = int(i[0])
                max = max+1
        cust = request.args['cust']
        print(cust)
        mysql.connection.commit()
        cur.close()
        return render_template('bill.html', orders = orders, cust = cust, BID = max)
        
@app.route('/billgeneration', methods=['GET', 'POST'])
def billgenerate():
        msg = ""
        cur = mysql.connection.cursor()
        l = len(orders)
        Total = 0
        Quantity = 0
        while(l>0):
                Total+=orders[l-1][5]
                Quantity+=orders[l-1][1]
                l-=1
        d1 = datetime.now()
        GST = 3
        Totalamount = Total +((GST/100)*Total)
        if request.method == 'POST':
                max = request.form['billno']
                eid = request.form['eid']
                cust = request.form['cid']
                cur.execute("INSERT INTO bill (BID, BQuantity, Tax, PDate, TAmount, EID, CID) VALUES (%s, %s, %s, %s, %s, %s, %s)", (int(max), Quantity, GST, str(d1), Totalamount, int(eid), int(cust)))
                
                l = len(orders)
                print(l)
                i =  0
                while i<l:
                        print(orders[i][0])
                        cur.execute("INSERT INTO bill_jewellery (BID, JID, JQuantity, Grams, Gold, JRate, JAmount) Values(%s, %s, %s, %s, %s, %s, %s)", (max, orders[i][0], orders[i][1], orders[i][2], orders[i][3], orders[i][4], orders[i][5]))
                        i+=1
                flash("Jewellery added successfully!")
                flash("Bill is created!")
                
                mysql.connection.commit()
                cur.close()
        return render_template('billgenerate.html', eid = eid, d1 = str(d1), cust = cust, orders = orders, Total = Total, Quantity = Quantity, GST = GST, Totalamount = Totalamount, BID = max)

@app.route('/newcustlogin')
def newcustlogin():
        orders = []
        return redirect(url_for('custlogin'))


@app.route('/transactions')
def transactions():
        return render_template('transaction.html')


@app.route('/report')
def report():
        return render_template('report.html')

@app.route('/showreport', methods=['GET', 'POST'])
def showreport():
        if request.method == 'POST':
                cur = mysql.connection.cursor()
                fromdate = request.form['fromdate']
                todate = request.form['todate']
                cur.execute("SELECT * FROM bill where PDate>=%s and PDate<=%s", (fromdate, todate))
                details = cur.fetchall()
                mysql.connection.commit()
                cur.close()
                return render_template('reportdetails.html', details = details)



@app.route('/payment', methods=['GET', 'POST'])
def payment():
        if request.method == 'POST':
                cur = mysql.connection.cursor()
                EID = request.form['EID']
                date = request.form['date']
                cur.execute("SELECT BID, BQuantity, BAmount, Tax, PDate, TAmount FROM bill where EID=%s and PDate=%s", (EID, date))
                details = cur.fetchall()
                mysql.connection.commit()
                cur.close()
                return render_template('billdetails.html', details = details)

@app.route('/customerdetails')
def customerdetails():
    cur = mysql.connection.cursor()

    customer = cur.execute("SELECT * FROM customer ORDER BY CID")

    if customer>0:
        customerdetails = cur.fetchall()
        mysql.connection.commit()
        cur.close()
        return render_template('customerdetails.html', customerdetails = customerdetails)


if __name__ == "__main__": 
    app.run(debug=True)