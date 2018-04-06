<h1>This is user template.<h1>

%import sqlite3
%path = '/home/NicalaiGuy/phones.db'
%conn = sqlite3.connect(path)
%c = conn.cursor()

%def printTable(tab):
    %formatted = "SELECT * FROM {}".format(tab)
    %result = c.execute(formatted)  #view the results
    %names = [description[0] for description in result.description]  #get the field names

    %for record in result: #prints out all the attributes and values
        %fieldNum = 0
        %for field in record:
            <h5>{{("{}:{}".format(names[fieldNum], field))}}</h5>
            %fieldNum += 1
        %end
        <br>
    %end
%end

%def toArray(result):
    %array = []
    %names = [description[0] for description in result.description]  #get the field names
    %for record in result: #prints out all the attributes and values
        %for field in record:  #make turn into array, not print. More versatile
            %array.append(field)
        %end
    %end
    %return (array)
%end

%def printPhone(param): #outputs the information on a phone (more than from just the phone table)
    %# These lines assign array values to respective attributes

    %phoNamesql = c.execute("SELECT phoName FROM Phone WHERE pID = ?", (param,))
    %phoName = toArray(phoNamesql)
    %manNamesql = c.execute("SELECT manName FROM Manufacturer, Phone WHERE Manufacturer.mID = Phone.mID AND pID = ?", (param,))
    %manName = toArray(manNamesql)
    %OSsql = c.execute("SELECT OS FROM Manufacturer, Phone WHERE Manufacturer.mID = Phone.mID AND pID = ?", (param,))
    %OS = toArray(OSsql)
    %proNamesql = c.execute("SELECT proName FROM Processor, Phone WHERE Processor.proID = Phone.proID AND pID = ?", (param,))
    %proName = toArray(proNamesql)
    %ScreenSizesql = c.execute("SELECT ScreenSize FROM Phone WHERE pID = ?", (param,))
    %ScreenSize = toArray(ScreenSizesql)
    %ResolutionWidthsql = c.execute("SELECT ResolutionWidth FROM Phone WHERE pID = ?", (param,))
    %ResolutionWidth = toArray(ResolutionWidthsql)
    %ResolutionHeightsql = c.execute("SELECT ResolutionHeight FROM Phone WHERE pID = ?", (param,))
    %ResolutionHeight = toArray(ResolutionHeightsql)
    %Resolution = [str(ResolutionHeight[0]) + " X " + str(ResolutionWidth[0])] #formats resolution into more traditional format
    %ScreenTypesql = c.execute("SELECT ScreenType FROM Phone WHERE pID = ?", (param,))
    %ScreenType = toArray(ScreenTypesql)
    %ScreenToBodysql = c.execute("SELECT ScreenToBody FROM Phone WHERE pID = ?", (param,))
    %ScreenToBody = toArray(ScreenToBodysql)
    %Constructionsql = c.execute("SELECT Construction FROM Phone WHERE pID = ?", (param,))
    %Construction = toArray(Constructionsql)
    %StorageCapsql = c.execute("SELECT StorageCap FROM Phone WHERE pID = ?", (param,))
    %StorageCap = toArray(StorageCapsql)
    %RAMsql = c.execute("SELECT RAM FROM Phone WHERE pID = ?", (param,))
    %RAM = toArray(RAMsql)
    %RearCamerasql = c.execute("SELECT RearCamera FROM Phone WHERE pID = ?", (param,))
    %RearCamera = toArray(RearCamerasql)
    %FrontCamerasql = c.execute("SELECT FrontCamera FROM Phone WHERE pID = ?", (param,))
    %FrontCamera = toArray(FrontCamerasql)
    %BatterySizesql = c.execute("SELECT BatterySize FROM Phone WHERE pID = ?", (param,))
    %BatterySize = toArray(BatterySizesql)

    %varArray = [phoName, manName, OS, proName, ScreenSize,
                %Resolution, ScreenType, ScreenToBody, Construction, StorageCap,
                %RAM, RearCamera, FrontCamera, BatterySize] #contains variables of attributes
    %labelArray = ['Name', 'Manufacturer', 'Operating System', 'Processor', 'Screen Size (in)',
                  %'Resolution', 'Display Technology', 'Screen to Body Ratio (%)', 'Back Material', 'Storage Capacity (GB)',
                  %'RAM (GB)', 'Rear Camera (Megapixels)', 'Front Camera (Megapixels)', 'Battery Size (mAH)'] #Contains strings to output to user
    %count = 0
    %for i in varArray:
        <h5>{{labelArray[count]}}: {{varArray[count][0]}}</h5>
        %count += 1 #Outputs the variable label and variable value of each attribute to user
    %end

%end

<h2>Phone 1</h2>
%printPhone(1)

<h2>Phone 2</h2>
%printPhone(2)

<h2>Phone 3</h2>
%printPhone(3)

<h2>Phones</h2>
%printTable("Phone")

<h2>Carriers</h2>
%printTable("Carrier")

<h2>Phone to Carrier Links</h2>
%printTable("Phone_Carrier")

<h2>Processors</h2>
%printTable("Processor")

<h2>Manufacturers</h2>
%printTable("Manufacturer")

%conn.close()
