import 'package:flutter/material.dart';
import 'package:note_app_with_provider/noteapp_using_provider/note_provider.dart';
import 'package:provider/provider.dart';
import 'app_database.dart';
import 'package:note_app_with_provider/main.dart';
import 'note_model.dart';

class AddNotePage extends StatelessWidget {
  var titleController = TextEditingController();
  var descController = TextEditingController();

  /*void getNotes() async {
    arrNotes = await myDB.fetchAllNotes();
    setState(() {});
  }*/
  void getInitialNotes(BuildContext context) {
    Provider.of<NoteProvider>(context, listen: false).fetchNote();
  }

  void addNotes(
      String title, String desc, String time, BuildContext context) async {
    context.read<NoteProvider>().addNote(NoteModel(
          title: title,
          desc: desc,
          time: time,
        ));
  }

  /*void addNotes(String title, String desc) async {
    bool check = await myDB.addNote(NoteModel(title: title, desc: desc));
    if (check) {
      arrNotes = await myDB.fetchAllNotes();
      setState(() {});
    }
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF252525),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.all(26.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Color(0XFF3B3B3B),
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios_new,
                            color: Color(0XFFFFFFFF)),
                      )),
                  InkWell(
                    onTap: () {
                      var title = titleController.text.toString();
                      var desc = descController.text.toString();
                      var date = DateTime.now();
                      String time = "${date.day}/${date.month}/${date.year} - ${date.hour}:${date.minute}:${date.second}";

                      if (title != '' && desc != '') {
                        addNotes(title, desc, time, context);
                        //  getInitialNotes(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotesPage()));
                        // Navigator.pop(context);
                      }
                      // Navigator.pop(context);
                    },
                    child: Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Color(0XFF3B3B3B),
                        ),
                        child: Center(
                            child: Text(
                          'Save',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.green.shade500,
                              fontWeight: FontWeight.bold),
                        ))),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            TextField(
              style: TextStyle(color: Color(0XFFFFFFFF)),
              controller: titleController,
              decoration: InputDecoration(
                  hintText: 'Title here!',
                  hintStyle: TextStyle(color: Color(0XFF8C8C8C)),
                  label: Text('Title',
                      style: TextStyle(fontSize: 40, color: Color(0XFF8C8C8C))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                      borderSide: BorderSide(color: Colors.transparent))),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              style: TextStyle(color: Color(0XFFFFFFFF)),
              maxLines: 7,
              controller: descController,
              decoration: InputDecoration(
                  hintText: 'Type something...',
                  hintStyle: TextStyle(color: Color(0XFF8C8C8C)),
                  label: Text('Description',
                      style: TextStyle(fontSize: 26, color: Color(0XFF8C8C8C))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21),
                      borderSide: BorderSide(color: Colors.transparent))),
            ),
          ],
        ),
      ),
    );
  }
}
