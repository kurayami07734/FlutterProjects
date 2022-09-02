import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math show Random;

void main() {
  runApp(const MyApp());
}

const names = [
  "foo",
  "bar",
  "baz",
  "spam",
  "eggs",
  "fizz",
  "buzz",
];

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}

class NamesCubit extends Cubit<String?> {
  NamesCubit() : super(null);
  void pickRandomName() {
    emit(names.getRandomElement());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learning Bloc',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Bloc basics'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final NamesCubit cubit;
  @override
  void initState() {
    cubit = NamesCubit();
    super.initState();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Text("data"),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

enum PersonURL {
  person1,
  person2,
}

extension URLString on PersonURL {
  String get urlString {
    switch (this) {
      case PersonURL.person1:
        return 'http://127.0.0.1:5500/api/person1.json';
      case PersonURL.person2:
        return 'http://127.0.0.1:5500/api/person2.json';
    }
  }
}

@immutable
abstract class LoadAction {
  const LoadAction();
}

class LoadPersonsAction implements LoadAction {
  final PersonURL url;
  const LoadPersonsAction({required this.url}) : super();
}

@immutable
class Person {
  final String name;
  final int age;

  const Person({
    required this.name,
    required this.age,
  });
  factory Person.fromJSON(Map<String, dynamic> json) => Person(
        name: json['name'] as String,
        age: json['age'] as int,
      );
}

Future<Iterable<Person>> getPersons(String url) => HttpClient()
    .getUrl(Uri.parse(url))
    .then((req) => req.close())
    .then((res) => res.transform(utf8.decoder).join())
    .then((str) => json.decode(str) as List<dynamic>)
    .then((list) => list.map((e) => Person.fromJSON(e)));

@immutable
class FetchResult {
  final Iterable<Person> persons;
  final bool isRetrievedFromCache;
  const FetchResult({
    required this.persons,
    required this.isRetrievedFromCache,
  });
  @override
  String toString() {
    return 'FetchResult from Cache : $isRetrievedFromCache, persons : $persons';
  }
}

class PersonBloc extends Bloc<LoadAction, FetchResult?> {
  PersonBloc() : super(null) {
    on<LoadPersonsAction>((event, emit) {
      final url = event.url;
    });
  }
  final Map<PersonURL, Iterable<Person>> _cache = {};
}
