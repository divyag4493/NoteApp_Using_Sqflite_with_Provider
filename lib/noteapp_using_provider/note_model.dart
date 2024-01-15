

import 'package:note_app_with_provider/noteapp_using_provider/app_database.dart';

class NoteModel {
  int? note_id;
  String title;
  String desc;
  String time;


  NoteModel({this.note_id, required this.title, required this.desc, required this.time});

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
        note_id: map[AppDatabase.Note_Id],
        title: map[AppDatabase.Note_Title],
        desc: map[AppDatabase.Note_Desc],
        time: map[AppDatabase.Note_Time]);
  }

  Map<String, dynamic> toMap() {
    return {
      AppDatabase.Note_Id:note_id,
      AppDatabase.Note_Title:title,
      AppDatabase.Note_Desc:desc,
      AppDatabase.Note_Time:time,
    };
  }
}
