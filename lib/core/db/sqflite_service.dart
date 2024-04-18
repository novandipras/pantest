import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:pantest/lib.dart';

class SqfliteService {
  Future<Database> initializeDB() async {
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, 'database.db');
      final database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute(
            """CREATE TABLE Post(
            id TEXT NOT NULL, 
            image TEXT NOT NULL,
            likes INTEGER NOT NULL,
            tags TEXT NOT NULL,
            text TEXT NOT NULL,
            publishDate TEXT NOT NULL,
            owner TEXT NOT NULL,
            )""",
          );
        },
      );
      return database;
    } on Exception {
     rethrow;
    }

  }

  Future<int> createItem(DataSavedPostModel dataSavedPost) async {
    final Database db = await initializeDB();
    final id = await db.insert(
      'Post',
      {
        "id": dataSavedPost.id,
        "image": dataSavedPost.image,
        "likes": dataSavedPost.likes,
        "tags": '[${dataSavedPost.tags?.map((e) => '"$e"').join(',')}]',
        "text": dataSavedPost.text,
        "publishDate": dataSavedPost.publishDate,
        "owner": jsonEncode(dataSavedPost.owner?.toJson()),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<List<DataSavedPostModel>> getItems() async {
    try {
      final db = await initializeDB();
      final List<Map<String, dynamic>> queryResult = await db.query('Post');
      return queryResult.map((e) {
        return DataSavedPostModel(
          id: e['id'],
          image: e['images'],
          likes: e['likes'],
          tags: e['tags'].substring(1, e['tags'].length - 1).split(','),
          text: e['text'],
          publishDate: e['publishDate'],
          owner: OwnerDataSavedPost.fromJson(jsonDecode(e['owner'])),
        );
      }).toList();
    } on Exception {
      rethrow;
    }
  }

  Future<void> deleteItem(String id) async {
    final db = await initializeDB();
    try {
      await db.delete("Post", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      if (kDebugMode) {
        print("Something went wrong when deleting an item: $err");
      }
    }
  }
}
