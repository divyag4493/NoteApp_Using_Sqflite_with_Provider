import 'package:flutter/foundation.dart';
import 'package:note_app_with_provider/noteapp_using_provider/app_database.dart';
import 'package:note_app_with_provider/noteapp_using_provider/note_model.dart';

class NoteProvider extends ChangeNotifier {
  List<NoteModel> _arrList = [];
  AppDatabase db = AppDatabase.db;

  // to get initial note when app is opened

  fetchNote() async {
    _arrList = await db.fetchAllNotes();
    notifyListeners();
  }

  addNote(NoteModel newNote) async {
    var check = await db.addNote(newNote);
    if (check) {
      fetchNote();
      notifyListeners();
    }
  }

  updateNote(NoteModel newUpdateNote) async {
    var check = await db.updateNote(newUpdateNote);
    if (check) {
      fetchNote();
      notifyListeners();
    }
  }

  deleteNote(int id)async{
    var check = await db.deleteNote(id);
    if(check){
      fetchNote();
      notifyListeners();
    }
  }

  List<NoteModel> getNotes() {
    return _arrList;
  }
}
