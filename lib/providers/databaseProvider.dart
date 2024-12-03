import 'package:note_pad_app/models/note.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;


class databaseNotifier extends AsyncNotifier<List<Note>>{
  Future<List<Note>> build() async {
    return await loadNotesFromDatabase();
  }
  Future<sql.Database> _getDatabase() async {
    final dbpath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
        path.join(dbpath, 'notepad.db'),
        onCreate: (db, version) {
          return db.execute(
              'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, noteTitle TEXT, noteDesc TEXT)');
        },
        version: 1
    );
    print("database connected");
    return db;
  }
  Future<List<Note>> loadNotesFromDatabase() async{
    final db = await _getDatabase();
    final data = await db.query('notes');
    final loadNotesList =
    data.map(
            (note)  => Note(id: note['id'] as int, title: note['noteTitle'] as String, Desc: note['noteDesc'] as String)
    ).toList();
    state = AsyncData(loadNotesList);
    return loadNotesList;
  }
  Future<void> deleteNoteFromDatabase(Note note) async {
    final db = await _getDatabase();
    await db.delete(
        'notes',
        where: 'id = ?',
      whereArgs: [note.id],
    );
    loadNotesFromDatabase();
  }
  void addNoteToDatabase(Note note,) async {
    final appDir = syspath.getApplicationDocumentsDirectory();
    final db = await _getDatabase();
    if(note.id == null){
      await db.insert(
          'notes',
          {
            'noteTitle': note.title,
            'noteDesc': note.Desc
          });
    } else {
      await db.update(
        'notes',
        {
          'noteTitle': note.title,
          'noteDesc': note.Desc
        },
        where: 'id = ?',
        whereArgs: [note.id],
      );
    }
    await loadNotesFromDatabase();
  }
}
final databaseProvider = AsyncNotifierProvider<databaseNotifier, List<Note>>(
  databaseNotifier.new,
);