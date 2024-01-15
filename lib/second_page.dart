import 'package:flutter/material.dart';
import 'package:note_app_with_provider/counter_provider.dart';
import 'package:note_app_with_provider/main.dart';
import 'package:note_app_with_provider/not_in_use/homepage.dart';
import 'package:provider/provider.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('Second Page'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '${context.watch<CounterProvider>().ListShow}',
               // '${Provider.of<CounterProvider>(context).countValue}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              onPressed: () {

               /* Provider.of<CounterProvider>(context, listen: false)
                    .countValueMinus = 1;*/
              },
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Text('First Page')),
            FloatingActionButton(
              onPressed: () {
                context.read<CounterProvider>().countValuePlus =1;
                /*Provider.of<CounterProvider>(context, listen: false)
                    .countValuePlus = 1;*/
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ],
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
