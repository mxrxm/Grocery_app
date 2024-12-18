import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Parent class to handle common database functionality
class Db {
  Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db;
  }

  Future<Database> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, getDatabaseName());
    if (await databaseExists(path)) {
      print("Database exists at: $path");
    } else {
      print("Database does not exist. Creating a new one.");
    }
    Database myDb = await openDatabase(
      path,
      version: getVersion(),
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onOpen: (db) async {
        // Enable foreign key constraints
        await db.execute('PRAGMA foreign_keys = ON;');
      }
    );
    return myDb;
  }

  String getDatabaseName() {
    // To be overridden by child classes
    throw UnimplementedError();
  }

  int getVersion() {
    // To be overridden by child classes
    throw UnimplementedError();
  }

  Future<void> _onCreate(Database db, int version) async {
    // To be implemented by child classes
    throw UnimplementedError();
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // To be implemented by child classes
    throw UnimplementedError();
  }

  Future<List<Map<String, dynamic>>> readData(String sql) async {
    Database? myDb = await db;
    return await myDb!.rawQuery(sql);
  }

  Future<int> insertData(String sql) async {
    Database? myDb = await db;
    return await myDb!.rawInsert(sql);
  }

  Future<int> updateData(String sql) async {
    Database? myDb = await db;
    return await myDb!.rawUpdate(sql);
  }

  Future<int> deleteData(String sql) async {
    Database? myDb = await db;
    return await myDb!.rawDelete(sql);
  }
}

// UserDb child class
class UserDb extends Db {
  @override
  String getDatabaseName() => 'UserInfo.db';

  @override
  int getVersion() => 1;

  @override
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE User_data (
            username TEXT NOT NULL CHECK (LENGTH(username) <= 10) UNIQUE,
            password TEXT NOT NULL CHECK (LENGTH(password) <= 10),
            number TEXT NOT NULL CHECK (LENGTH(number) = 11),
            email TEXT CHECK (email LIKE '%@%.__%'),
            address TEXT NOT NULL CHECK (LENGTH(address) <= 20),
            PRIMARY KEY (number)
        )
    ''');
    print("User database created and table initialized.");
  }

  @override
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("User database upgraded from version $oldVersion to $newVersion.");
  }
  Future<int> insertUser(String username, String password, String number,
      String email, String address) async {
    Database? myDb = await db;
    return await myDb!.rawInsert('''
    INSERT INTO 'User_data' (username,password,number,email,address)
     VALUES ('$username', '$password','$number','$email','$address')
''');
  }
  Future<Map<String, dynamic>> validateData(String username, String password) async {
    String? message;
    bool? state;

    List<Map<String, dynamic>> data = await readData('''
       SELECT password FROM User_data
       WHERE username = '$username'
    ''');

    if (data.isEmpty) {
      message = "User Not Found";
      state = false;
    } else {
      if (data[0]['password'] == password) {
        message = "Welcome";
        state = true;
      } else {
        message = "Password Incorrect";
        state = false;
      }
    }

    return {'message': message, 'state': state};
  }
}

// ItemDb child class
class ItemDb extends Db {
  @override
  String getDatabaseName() => 'ItemInfo.db';

  @override
  int getVersion() => 1;

  @override
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IMAGES (
        Img_Id INTEGER PRIMARY KEY AUTOINCREMENT,
        Img_path TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE CATEGORIES (
        Cat_Id INTEGER PRIMARY KEY AUTOINCREMENT,
        Cat_name TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE ITEMS (
        item_id INTEGER PRIMARY KEY AUTOINCREMENT,
        item_name TEXT NOT NULL,
        item_price REAL NOT NULL,
        item_quantity TEXT NOT NULL,
        item_count INTEGER NOT NULL,
        item_img INTEGER NOT NULL,
        item_cat INTEGER NOT NULL,
        FOREIGN KEY (item_img) REFERENCES IMAGES (Img_Id),
        FOREIGN KEY (item_cat) REFERENCES CATEGORIES (Cat_Id)
      );
    ''');
    print("====================Item database created===================");
     insertInitialData();
  }

  @override
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("Item database upgraded from version $oldVersion to $newVersion.");
  }

  Future<void> insertInitialData() async {
    Database? myDb = await db;
    int response;
    response = await insertData(
        "INSERT INTO 'CATEGORIES' (Cat_name) VALUES ('Fresh Fruits & Vegetables');");
    print("inserted cat with response: $response");
    response = await insertData(
        "INSERT INTO 'CATEGORIES' (Cat_name) VALUES ('Cooking Oil');");
    print("inserted cat with response: $response");
    response = await insertData(
        "INSERT INTO CATEGORIES (Cat_name) VALUES ('Meat & Fish');");
    print("inserted cat with response: $response");
    response = await insertData(
        "INSERT INTO 'CATEGORIES' (Cat_name) VALUES ('Bakery & Snacks');");
    print("inserted cat with response: $response");
    response = await insertData(
        "INSERT INTO 'CATEGORIES' (Cat_name) VALUES ('Dairy & Eggs');");
    print("inserted cat with response: $response");
    response = await insertData(
        "INSERT INTO 'CATEGORIES' (Cat_name) VALUES ('Beverages');");
    print("inserted cat with response: $response");
    //Initialize Image table
    response = await insertData(
        "INSERT INTO IMAGES (Img_path) VALUES ('images/apple.png');");
    print("inserted img with response: $response");
    response = await insertData(
        "INSERT INTO IMAGES (Img_path) VALUES ('images/banana.png');");
    print("inserted img with response: $response");
    response = await insertData(
        "INSERT INTO IMAGES (Img_path) VALUES ('images/bell_pepper.png');");
    print("inserted img with response: $response");
    response = await insertData(
        "INSERT INTO IMAGES (Img_path) VALUES ('images/cabbage.png');");
    print("inserted img with response: $response");
    response = await insertData(
        "INSERT INTO IMAGES (Img_path) VALUES ('images/carrot.png');");
    print("inserted img with response: $response");
    response = await insertData(
        "INSERT INTO IMAGES (Img_path) VALUES ('images/cauliflower.png');");
    print("inserted img with response: $response");
    response = await insertData(
        "INSERT INTO IMAGES (Img_path) VALUES ('images/ginger.png');");
    print("inserted img with response: $response");
    response = await insertData(
        "INSERT INTO IMAGES (Img_path) VALUES ('images/lamb_meat.png');");
    print("inserted img with response: $response");
    response = await insertData(
        "INSERT INTO IMAGES (Img_path) VALUES ('images/pumpkin.png');");
    print("inserted img with response: $response");
    response = await insertData(
        "INSERT INTO IMAGES (Img_path) VALUES ('images/spinach.png');");
    print("inserted img with response: $response");
    response = await insertData(
        "INSERT INTO IMAGES (Img_path) VALUES ('images/tomatoes.png');");
    print("inserted img with response: $response");
    response = await insertData(
        "INSERT INTO IMAGES (Img_path) VALUES ('images/beef.png');");
    print("inserted img with response: $response");
    response = await insertData(
        "INSERT INTO IMAGES (Img_path) VALUES ('images/chicken.png');");
    print("inserted img with response: $response");
    response = await insertData(
        "INSERT INTO IMAGES (Img_path) VALUES ('images/diet_coke.png');");
    print("inserted img with response: $response");
    response = await insertData(
        "INSERT INTO IMAGES (Img_path) VALUES ('images/sprite.png');");
    print("inserted img with response: $response");
    response = await insertData(
        "INSERT INTO IMAGES (Img_path) VALUES ('images/apple_and_grape_juice.png');");
    print("inserted img with response: $response");
    response = await insertData(
        "INSERT INTO IMAGES (Img_path) VALUES ('images/orange_juice.png');");
    print("inserted img with response: $response");
    response = await insertData(
        "INSERT INTO IMAGES (Img_path) VALUES ('images/coca_cola.png');");
    print("inserted img with response: $response");
    response = await insertData(
        "INSERT INTO IMAGES (Img_path) VALUES ('images/pepsi.png');");
    print("inserted img with response: $response");
    response = await insertData(
        "INSERT INTO IMAGES (Img_path) VALUES ('images/olive_oil.png');");
    print("inserted img with response: $response");
    response = await insertData(
        "INSERT INTO IMAGES (Img_path) VALUES ('images/sunflower_oil.png');");
    print("inserted img with response: $response");
    response = await insertData(
        "INSERT INTO IMAGES (Img_path) VALUES ('images/milk.png');");
    print("inserted img with response: $response");
    response = await insertData(
        "INSERT INTO IMAGES (Img_path) VALUES ('images/butter.png');");
    print("inserted img with response: $response");
    response = await insertData(
        "INSERT INTO IMAGES (Img_path) VALUES ('images/eggs.png');");
    print("inserted img with response: $response");
    response = await insertData(
        "INSERT INTO IMAGES (Img_path) VALUES ('images/cheese.png');");
    print("inserted img with response: $response");

    //Initialize Item table
    response = await insertData('''INSERT INTO ITEMS
           (item_name,item_price,item_quantity,item_count,item_img,item_cat)
           values
           ('Red Apple',4.99,'1kg, Priceg',20,1,1);
        ''');
    print("inserted item with response: $response");
    response = await insertData('''INSERT INTO ITEMS
           (item_name,item_price,item_quantity,item_count,item_img,item_cat)
           values
           ('Organic Bananas',4.99,'7pcs, Priceg',20,2,1);
        ''');
    print("inserted item with response: $response");
    response = await insertData('''INSERT INTO ITEMS
           (item_name,item_price,item_quantity,item_count,item_img,item_cat)
           values
           ('Bell Pepper Red',5.99,'1kg, Priceg',20,3,1);
        ''');
    print("inserted item with response: $response");
    response = await insertData('''INSERT INTO ITEMS
           (item_name,item_price,item_quantity,item_count,item_img,item_cat)
           values
           ('Fresh Lettuce',3.99,'4pcs, Priceg',20,4,1);
        ''');
    print("inserted item with response: $response");
    response = await insertData('''INSERT INTO ITEMS
           (item_name,item_price,item_quantity,item_count,item_img,item_cat)
           values
           ('Organic Carrots',5.99,'7pcs, Priceg',20,5,1);
        ''');
    print("inserted item with response: $response");
    response = await insertData('''INSERT INTO ITEMS
           (item_name,item_price,item_quantity,item_count,item_img,item_cat)
           values
           ('Fresh Broccoli',3.99,'3pcs, Priceg',20,6,1);
        ''');
    print("inserted item with response: $response");
    response = await insertData('''INSERT INTO ITEMS
           (item_name,item_price,item_quantity,item_count,item_img,item_cat)
           values
           ('Arabic Ginger',6.99,'7pcs, Priceg',20,7,1);
        ''');
    print("inserted item with response: $response");
    response = await insertData('''INSERT INTO ITEMS
           (item_name,item_price,item_quantity,item_count,item_img,item_cat)
           values
           ('Lamb Meat',54.99,'500gm, Priceg',20,8,3);
        ''');
    print("inserted item with response: $response");
    response = await insertData('''INSERT INTO ITEMS
           (item_name,item_price,item_quantity,item_count,item_img,item_cat)
           values
           ('Butternut Squash',8.99,'2pcs, Priceg',20,9,1);
        ''');
    print("inserted item with response: $response");
    response = await insertData('''INSERT INTO ITEMS
           (item_name,item_price,item_quantity,item_count,item_img,item_cat)
           values
           ('Fresh Spinach ',2.99,'10pcs, Priceg',20,10,1);
        ''');
    print("inserted item with response: $response");
    response = await insertData('''INSERT INTO ITEMS
           (item_name,item_price,item_quantity,item_count,item_img,item_cat)
           values
           ('Cherry Tomato',5.99,'1kg, Priceg',20,11,1);
        ''');
    print("inserted item with response: $response");
    response = await insertData('''INSERT INTO ITEMS
           (item_name,item_price,item_quantity,item_count,item_img,item_cat)
           values
           ('Meat',55.99,'250gm, Priceg',20,12,3);
        ''');
    print("inserted item with response: $response");
    response = await insertData('''INSERT INTO ITEMS
           (item_name,item_price,item_quantity,item_count,item_img,item_cat)
           values
           ('Chicken',34.50,'1kg, Priceg',20,13,3);
        ''');
    print("inserted item with response: $response");

    response = await insertData('''INSERT INTO ITEMS
           (item_name,item_price,item_quantity,item_count,item_img,item_cat)
           values
           ('Dite Coke',8.50,'355ml, Price',20,14,6);
        ''');
    print("inserted item with response: $response");
    response = await insertData('''INSERT INTO ITEMS
           (item_name,item_price,item_quantity,item_count,item_img,item_cat)
           values
           ('Sprite Can',8.50,'355ml, Price',20,15,6);
        ''');
    print("inserted item with response: $response");
    response = await insertData('''INSERT INTO ITEMS
           (item_name,item_price,item_quantity,item_count,item_img,item_cat)
           values
           ('Apple Juice',14.50,'2L, Price',20,16,6);
        ''');
    print("inserted item with response: $response");
    response = await insertData('''INSERT INTO ITEMS
           (item_name,item_price,item_quantity,item_count,item_img,item_cat)
           values
           ('Orange Juice',12.99,'2L, Price',20,17,6);
        ''');
    print("inserted item with response: $response");
    response = await insertData('''INSERT INTO ITEMS
           (item_name,item_price,item_quantity,item_count,item_img,item_cat)
           values
           ('Coca Cola Can',7.99,'355ml, Priceeg',20,18,6);
        ''');
    print("inserted item with response: $response");
    response = await insertData('''INSERT INTO ITEMS
           (item_name,item_price,item_quantity,item_count,item_img,item_cat)
           values
           ('Olive Oil',5.99,'500ml, Priceeg',20,20,2);
        ''');
    print("inserted item with response: $response");
    response = await insertData('''INSERT INTO ITEMS
           (item_name,item_price,item_quantity,item_count,item_img,item_cat)
           values
           ('SunFlower Oil',3.99,'500ml, Priceeg',20,21,2);
        ''');
    print("inserted item with response: $response");
    response = await insertData('''INSERT INTO ITEMS
           (item_name,item_price,item_quantity,item_count,item_img,item_cat)
           values
           ('Milk',2.99,'1000ml, Priceeg',20,22,5);
        ''');
    print("inserted item with response: $response");
    response = await insertData('''INSERT INTO ITEMS
           (item_name,item_price,item_quantity,item_count,item_img,item_cat)
           values
           ('Butter',9.99,'355ml, Priceeg',20,23,5);
        ''');
    print("inserted item with response: $response");
    response = await insertData('''INSERT INTO ITEMS
           (item_name,item_price,item_quantity,item_count,item_img,item_cat)
           values
           ('Eggs',7.99,'6 eggs, Priceeg',20,24,5);
        ''');
    print("inserted item with response: $response");
    response = await insertData('''INSERT INTO ITEMS
           (item_name,item_price,item_quantity,item_count,item_img,item_cat)
           values
           ('Cheese',2.99,'1kg, Priceeg',20,25,5);
        ''');
    print("inserted item with response: $response");

  }

  Future<List<Map<String, dynamic>>> getItems(String category) async {
    return await readData('''
      SELECT 
        ITEMS.item_name AS title,
        ITEMS.item_quantity AS quantity,
        ITEMS.item_price AS price,
        IMAGES.Img_path AS image 
      FROM ITEMS 
      JOIN IMAGES ON ITEMS.item_img = IMAGES.Img_Id
      JOIN CATEGORIES ON ITEMS.item_cat =CATEGORIES.Cat_Id
      WHERE CATEGORIES.Cat_name='$category';
    ''');
  }
}
