// Copyright 2017, the Flutter project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

void main() {
  runApp(new TodoListApp());
}

class TodoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new LoadingScreen(),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  Widget buildLoadingScreen() {
    return new Material(
      child: new Center(
        child: new Text("Signing in..."),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: FirebaseAuth.instance.signInAnonymously(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> user) {
        if (!user.hasData) {
          return buildLoadingScreen();
        }
        DatabaseReference userReference = FirebaseDatabase.instance
          .reference()
          .child("users")
          .child(user.data.uid);
        return new StreamBuilder(
          stream: userReference.child("profile").onValue,
          builder: (BuildContext context, AsyncSnapshot<Event> event) {
            if (!event.hasData) {
              return buildLoadingScreen();
            }
            return new HomePage(
              userReference: userReference,
              profile: event.data.snapshot,
            );
          }
        );
      }
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({ this.userReference, this.profile });

  final DatabaseReference userReference;
  final DataSnapshot profile;

  DatabaseReference get _profileReference => userReference.child('profile');
  DatabaseReference get _todosReference => userReference.child('todos');

  bool get _hideCompleted => profile?.value['hideCompleted'] ?? false;
  set _hideCompleted(bool value) => _profileReference.child('hideCompleted').set(value);

  String get _sort => profile?.value['sort'] ?? 'created_at';
  set _sort(String value) => _profileReference.child('sort').set(value);

  Query get _query {
    Query query = userReference.child('todos');
    if (_hideCompleted) {
      query = query.orderByChild('done').equalTo(true);
    }
    return query;
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Todo List'),
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new CheckboxListTile(
              title: new Text('Hide completed items'),
              value: _hideCompleted,
              onChanged: (bool value) => _hideCompleted = value,
            ),
            new Divider(),
            new RadioListTile<String>(
              title: new Text('Sort by creation'),
              value: 'created_at',
              groupValue: _sort,
              onChanged: (String value) => _sort = value,
            ),
            new RadioListTile<String>(
              title: new Text('Sort by description'),
              value: 'description',
              groupValue: _sort,
              onChanged: (String value) => _sort = value,
            ),
          ],
        ),
      ),
      body: new FirebaseAnimatedList(
        shrinkWrap: true,
        reverse: true,
        query: _query,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
          Animation<double> animation) {
          return new SizeTransition(
            key: new ValueKey(snapshot.key),
            sizeFactor: animation,
            child: new TodoListTile(
              reference: _todosReference.child(snapshot.key),
              initialSnapshot: snapshot,
            ),
          );
        },
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () async {
          String result = await showDialog<String>(
            context: context,
            child: new EditTodoDialog(),
          );
          if (result != null) {
            _todosReference.push().set({ 'description': result, 'done': false});
          }
        },
        tooltip: 'Add',
        child: new Icon(Icons.add),
      ),
    );
  }
}

class TodoListTile extends StatelessWidget {
  TodoListTile({ this.reference, this.initialSnapshot });

  final DatabaseReference reference;
  final DataSnapshot initialSnapshot;

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: reference.onValue,
      builder: (BuildContext context, AsyncSnapshot<Event> event) {
        DataSnapshot snapshot = (event.data?.snapshot ?? initialSnapshot);
        return new ListTile(
          leading: new Checkbox(
            value: snapshot.value['done'],
            onChanged: (bool value) {
              reference.child('done').set(value);
            },
          ),
          title: new Text(snapshot.value['description']),
          onTap: () {
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (_) => new TodoPage(snapshot, reference),
              ),
            );
          },
        );
      },
    );
  }
}

class TodoPage extends StatelessWidget {
  TodoPage(this.initialSnapshot, this.reference);

  final DataSnapshot initialSnapshot;
  final DatabaseReference reference;

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<Event>(
      stream: reference.onValue,
      builder: (BuildContext context, AsyncSnapshot<Event> event) {
        DataSnapshot snapshot = (event?.data.snapshot ?? this.initialSnapshot);
        return new Scaffold(
          appBar: new AppBar(
            title: new Text('Details')
          ),
          body: new SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: new Text(
              snapshot.value['description'],
              style: Theme
                .of(context)
                .textTheme
                .display1,
            ),
          ),
          floatingActionButton: new FloatingActionButton(
            child: new Icon(Icons.edit),
            onPressed: () {
              showDialog(
                context: context,
                child: new EditTodoDialog(text: snapshot.value['description']));
            },
          ),
        );
      },
    );
  }
}

class EditTodoDialog extends StatefulWidget {
  EditTodoDialog({ this.text: '' });

  final String text;

  EditTodoDialogState createState() => new EditTodoDialogState();
}

class EditTodoDialogState extends State<EditTodoDialog> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = new TextEditingController(text: widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: new Text('Description'),
      content: new TextField(
        decoration: const InputDecoration(hintText: 'New todo'),
        maxLines: 10,
        controller: _controller,
      ),
      actions: <Widget>[
        new FlatButton(
          child: const Text('CANCEL'),
          onPressed: () => Navigator.pop(context),
        ),
        new FlatButton(
          child: const Text('SAVE'),
          onPressed: () => Navigator.pop(context, _controller.text),
        ),
      ],
    );
  }
}
