
from bottle import default_app, route, template

@route('/')  #home page, populates data upon loading
def hello_world():
    import sqlite3
    conn = sqlite3.connect("phones.db")
    c = conn.cursor()

    c.execute ("DROP TABLE IF EXISTS Carrier")  #these must be removed once user can edit database
    carrierSQL = """
    CREATE TABLE Carrier(
    cID INTEGER PRIMARY KEY,
    carName varchar(30)
    )"""
    c.execute(carrierSQL)

    c.execute("INSERT INTO Carrier VALUES (null, ?)", ('Verizon',))
    c.execute("INSERT INTO Carrier VALUES (null, ?)", ('T-Mobile',))
    c.execute("INSERT INTO Carrier VALUES (null, ?)", ('AT&T',))
    c.execute("INSERT INTO Carrier VALUES (null, ?)", ('Sprint',))

    #creates manufacturer table
    c.execute ("DROP TABLE IF EXISTS Manufacturer")
    manufacturerSQL = """
    CREATE TABLE Manufacturer(
    mID INTEGER PRIMARY KEY,
    manName varchar(30),
    OS varchar(30)
    )"""
    c.execute(manufacturerSQL)

    #inserts data into manufacturer table
    c.execute("INSERT INTO Manufacturer VALUES (null, ?, ?)",
            ('Samsung', 'android'))
    c.execute("INSERT INTO Manufacturer VALUES (null, ?, ?)",
            ('Apple', 'iOS'))

    #creates processor table
    c.execute ("DROP TABLE IF EXISTS Processor")
    processorSQL = """
    CREATE TABLE Processor(
    proID INTEGER PRIMARY KEY,
    proName varchar(30)
    )"""
    c.execute(processorSQL)

    #inserts data into processor table
    c.execute ("INSERT INTO Processor VALUES (null, ?)", ('Snapdragon 835',))
    c.execute ("INSERT INTO Processor VALUES (null, ?)", ('Snapdragon 845',))
    c.execute ("INSERT INTO Processor VALUES (null, ?)", ('A11 Bionic',))

    #creates Phone table (big one)
    c.execute ("DROP TABLE IF EXISTS Phone")
    phoneSQL = """
    CREATE TABLE Phone(
    pID INTEGER PRIMARY KEY,
    mID INTEGER,
    proID INTEGER,
    phoName varchar(100),
    ScreenSize float,
    ResolutionWidth INTEGER(4),
    ResolutionHeight INTEGER(4),
    ScreenType varchar(50),
    ScreenToBody float,
    Construction varchar(50),
    StorageCap int(3),
    RAM int(2),
    RearCamera int(2),
    FrontCamera int(2),
    BatterySize int(5)
    )"""
    c.execute(phoneSQL)

    #inserts data into phone table
    c.execute("INSERT INTO Phone VALUES (null, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
    (1, 1,'Galaxy S8+',6.2,1440,2960,'Super AMOLED',
    84,'Glass',64,4,12,8,3500))
    c.execute("INSERT INTO Phone VALUES (null, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
    (1, 2,'Galaxy S9+',6.2,1440,2960,'Super AMOLED',
    84.2,'Glass',64,6,12,8,3500))
    c.execute("INSERT INTO Phone VALUES (null, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
    (2, 3,'iVerizon',4.7,751,1336,'LCD',
    65,'Glass',512,2,12,8,1275))

    #creates Phone_Carrier link table
    c.execute ("DROP TABLE IF EXISTS Phone_Carrier")
    phoneCarrierSQL = """
    CREATE TABLE Phone_Carrier(
    pcID INTEGER PRIMARY KEY,
    price float,
    pID INTEGER,
    cID INTEGER
    )"""
    c.execute(phoneCarrierSQL)

    #inserts data into Phone_Carrier table
    c.execute("INSERT INTO Phone_Carrier VALUES (1, 799, 1, 1)")
    c.execute("INSERT INTO Phone_Carrier VALUES (2, 779, 1, 2)")
    c.execute("INSERT INTO Phone_Carrier VALUES (3, 749, 1, 3)")
    c.execute("INSERT INTO Phone_Carrier VALUES (4, 709, 1, 4)")
    c.execute("INSERT INTO Phone_Carrier VALUES (5, 899, 2, 1)")
    c.execute("INSERT INTO Phone_Carrier VALUES (6, 879, 2, 2)")
    c.execute("INSERT INTO Phone_Carrier VALUES (7, 849, 2, 3)")
    c.execute("INSERT INTO Phone_Carrier VALUES (8, 809, 2, 4)")
    c.execute("INSERT INTO Phone_Carrier VALUES (9, 999, 3, 4)")

    conn.commit()
    conn.close()
    return template('user_template')

application = default_app()
