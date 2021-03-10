// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:check_to_check/core/models/TimeLineEntryModel.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:check_to_check/widgets/TimeLineEntry.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Check to Check',
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = TextStyle(fontSize: 18.0);
  final _entries = <TimeLineEntryModel>[
    new TimeLineEntryModel(1, "Testing", "01/01/21", "\$100.00", "\$200.00", true, true),
    new TimeLineEntryModel(2, "Other", "01/02/21", "\$150.00", "\$50.00", true, false)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check to Check'),
        actions: [
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.separated(
        padding: EdgeInsets.all(16.0),
        itemCount: _entries.length,
        itemBuilder: /*1*/ (context, i) {
          return TimeLineEntry(model: _entries[i], onToggled: _toggleEnabled);
        },
        separatorBuilder: (context, i) {
          return Divider();
        },
    );
  }

  void _toggleEnabled(int id) {

    setState(() {
      var entry = _entries.singleWhere((element) => element.id == id);
      entry.enabled = !entry.enabled;
    });
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // NEW lines from here...
        builder: (BuildContext context) {
          final tiles = _saved.map(
                (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        }, // ...to here.
      ),
    );
  }
}
