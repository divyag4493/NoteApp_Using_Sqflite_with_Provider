import 'package:flutter/material.dart';
import 'package:note_app_with_provider/list_data_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  var nameController = TextEditingController();
  var positionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Provider'),
      ),
      body: Consumer<ListDataProvider>(
        builder: (_, provider, __) {
          List<Map<String, dynamic>> data = provider.getMyList();
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (ctx, index) {
                return InkWell(
                  onTap: () {
                    nameController.text = data[index]['name'];
                    positionController.text = data[index]['position'];
                    showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Column(
                                children: [
                                  Text('Update Note'),
                                  SizedBox(
                                    height: 21,
                                  ),
                                  TextField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(21),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 21,
                                  ),
                                  TextField(
                                    controller: positionController,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(21),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 21,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        var dataToBeUpdated = {
                                          'name':
                                          nameController.text.toString(),
                                          'position': positionController.text
                                              .toString(),
                                        };
                                        context
                                            .read<ListDataProvider>()
                                            .updateData(dataToBeUpdated, index);
                                        Navigator.pop(context);
                                      },
                                      child: Text('Update'))
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: ListTile(
                    title: Text('${data[index]['name']}'),
                    subtitle: Text('${data[index]['position']}'),
                    trailing: InkWell(
                        onTap: () {
                          context.read<ListDataProvider>().deleteData(index);
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  ),
                );
              });
        },
      ),

      floatingActionButton: FloatingActionButton(onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (_) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 2000,
                  child: Column(
                    children: [
                      Text('Add Note'),
                      SizedBox(
                        height: 21,
                      ),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(21),
                            )),
                      ),
                      SizedBox(
                        height: 21,
                      ),
                      TextField(
                        controller: positionController,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(21),
                            )),
                      ),
                      SizedBox(
                        height: 21,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Map<String, dynamic> newList = {
                            'name': nameController.text.toString(),
                            'position': positionController.text.toString(),
                          };
                          Provider.of<ListDataProvider>(context, listen: false)
                              .addData(newList);
                          Navigator.pop(context);
                        },
                        child: Text('Save'),
                      ),
                    ],
                  ),
                ),
              );
            });
      },child: Icon(Icons.add),),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
