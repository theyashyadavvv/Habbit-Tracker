import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'habit_tracker.db');
    return await openDatabase(
      path,
      onCreate: (db, version) async {
        // Create the users table
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT UNIQUE,
            password TEXT,
            profile_picture TEXT
          )
        ''');

        // Create the habits table with a foreign key referencing the user_id
        await db.execute('''
          CREATE TABLE habits (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            progress REAL,
            user_id INTEGER,
            FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE
          )
        ''');
      },
      version: 1,
    );
  }

  // Method to authenticate a user
  Future<int?> authenticateUser(String email, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      columns: ['id'],
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (result.isNotEmpty) {
      return result[0]['id'] as int?;
    }
    return null;
  }

  // Save the current user's ID in shared preferences
  Future<void> saveCurrentUserId(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentUserId', userId);
  }

  // Get the current user's ID from shared preferences
  Future<int?> getCurrentUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('currentUserId');
  }

// Add this method in your DatabaseHelper class
  Future<String?> getCurrentUserEmail() async {
    final userId = await getCurrentUserId();
    if (userId != null) {
      final db = await database;
      final List<Map<String, dynamic>> result = await db.query(
        'users',
        columns: ['email'],
        where: 'id = ?',
        whereArgs: [userId],
      );
      if (result.isNotEmpty) {
        return result[0]['email'] as String?;
      }
    }
    return null;
  }

  // Get the current user's name
  // Future<String?> getUserName() async {
  //   final userId = await getCurrentUserId();
  //   if (userId != null) {
  //     return await getUserNameById(userId);
  //   }
  //   return null;
  // }

  // Get a user's name by their ID
  Future<String?> getUserNameById(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      columns: ['name'],
      where: 'id = ?',
      whereArgs: [userId],
    );
    if (result.isNotEmpty) {
      return result[0]['name'] as String?;
    }
    return null;
  }

  // Get the current user's profile picture
  Future<String?> getUserProfilePicture(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      columns: ['profile_picture'],
      where: 'id = ?',
      whereArgs: [userId],
    );
    if (result.isNotEmpty) {
      return result[0]['profile_picture'] as String?;
    }
    return null;
  }

  // Update the user's profile picture
  Future<void> updateUserProfilePicture(
      int userId, String profilePictureUrl) async {
    final db = await database;
    await db.update(
      'users',
      {'profile_picture': profilePictureUrl},
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  // Add a new user
  Future<int> addUser(String name, String email, String password,
      {String? profilePicture}) async {
    final db = await database;
    return await db.insert('users', {
      'name': name,
      'email': email,
      'password': password,
      'profile_picture': profilePicture,
    });
  }

  // Add a new habit associated with a specific user
  Future<int> addHabit(String name, double progress, int userId) async {
    final db = await database;
    return await db.insert('habits', {
      'name': name,
      'progress': progress,
      'user_id': userId, // Associate the habit with the logged-in user
    });
  }

  // Retrieve habits specific to the logged-in user
  Future<List<Map<String, dynamic>>> getUserHabits(int userId) async {
    final db = await database;
    return await db.query(
      'habits',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
  }

  // Delete a habit by its ID and save the changes in the database
  Future<void> deleteHabit(int habitId) async {
    final db = await database;
    await db.delete('habits', where: 'id = ?', whereArgs: [habitId]);
  }

  // Update a habit's progress
  Future<void> updateHabit(int id, double progress) async {
    final db = await database;
    await db.update(
      'habits',
      {'progress': progress},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
