import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app_with_provider/counter_provider.dart';
import 'package:note_app_with_provider/list_data_provider.dart';
import 'package:note_app_with_provider/not_in_use/homepage.dart';
import 'package:note_app_with_provider/noteapp_using_provider/add_note_page.dart';
import 'package:note_app_with_provider/noteapp_using_provider/app_database.dart';
import 'package:note_app_with_provider/noteapp_using_provider/note_model.dart';
import 'package:note_app_with_provider/noteapp_using_provider/note_provider.dart';
import 'package:note_app_with_provider/second_page.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import 'dart:math' as math show Random;

import 'noteapp_using_provider/update_note_page.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => NoteProvider(),
    child: const MyApp(),
  ));

  /*runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => CounterProvider(),
    ),
    ChangeNotifierProvider(create: (context) => ListDataProvider()),
  ], child: const MyApp()));*/
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: NotesPage(),
    );
  }
}

class NotesPage extends StatefulWidget {
  /* String? mTitle = '';
  String? mDesc = '';
  NotesPage({required this.mTitle,required this.mDesc});*/

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {

  List<NoteModel> arrNotes = [];
  var titleController = TextEditingController();
  var descController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void getInitialNotes(BuildContext context) {
    Provider.of<NoteProvider>(context, listen: false).fetchNote();
  }

  void deleteNote(int id,BuildContext context){
    Provider.of<NoteProvider>(context,listen: false).deleteNote(id);
  }



  @override
  Widget build(BuildContext context) {
    getInitialNotes(context);
    return Scaffold(
      backgroundColor: Color(0XFF252525),
      body: SingleChildScrollView(
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
                  Text('Notes',
                      style: TextStyle(fontSize: 40, color: Color(0XFFFFFFFF))),
                  Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Color(0XFF3B3B3B),
                      ),
                      child: InkWell(
                        onTap: () {
                          //TextFieldForSearch();
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>NoteSearch()));
                        },
                        child: Icon(Icons.search_rounded,
                            color: Color(0XFFB3B3B3), size: 40),
                      )),
                ],
              ),
            ),
            NoteSectionAll(),

            /* ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: arrNotes.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(arrNotes[index].title,style: TextStyle(fontSize: 22,color: Colors.white)),
                    subtitle: Text(arrNotes[index].desc,style: TextStyle(fontSize: 18,color: Colors.white)));
                }),*/
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(18.0),
        child: FloatingActionButton(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          backgroundColor: Color(0XFF252525),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddNotePage()));
            getInitialNotes(context);
          },
          /* Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddUpdateNotePage()));*/ /*
          },*/
          child: Icon(Icons.add_card, color: Color(0XFFFFFFFF)),
        ),
      ),
    );
  }

  Widget NoteSectionAll() {
    return Container(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
                child: Consumer<NoteProvider>(
                  builder: (_, provider, __) {
                    return MasonryGridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: provider
                            .getNotes()
                            .length,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        crossAxisCount: 2,

                        itemBuilder: (context, index) {
                          var currData = provider.getNotes()[index];
                          return InkWell(
                            onTap: () {
                              /*titleController.text = arrNotes[index].title;
                        descController.text = arrNotes[index].desc;*/

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateNote(
                                            mTitle: currData.title,
                                            mDesc: currData.desc,
                                            id: currData.note_id,
                                          )));
                              getInitialNotes(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border:
                                Border.all(
                                    color: Colors.white.withOpacity(0.4)),
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.primaries[
                                math.Random().nextInt(Colors.primaries.length)],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text(
                                          index.isFinite
                                              ? currData.title.length >
                                              10
                                              ? "${currData.title
                                              .substring(0, 10)}..."
                                              : currData.title
                                              : currData.title,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold)),
                                      InkWell(
                                          onTap: () async {
                                                deleteNote(currData.note_id!, context);
                                            getInitialNotes(context);
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                            size: 26,
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    index.isFinite
                                        ? currData.desc.length > 200
                                        ? "${currData.desc.substring(
                                        0, 200)}..."
                                        :currData.desc
                                        : currData.desc,
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                )
            ),
          ],
        ));
  }
}
