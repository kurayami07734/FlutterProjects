import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Learning redux"),
        ),
        body: const HomePage(),
      ),
    ),
  );
}

enum ItemFilter { all, longText, shortText }

@immutable
class State {
  final Iterable<String> items;
  final ItemFilter filter;

  const State({
    required this.items,
    required this.filter,
  });

  Iterable<String> get filteredItems {
    switch (filter) {
      case ItemFilter.all:
        return items;
      case ItemFilter.longText:
        return items.where((element) => element.length >= 10);
      case ItemFilter.shortText:
        return items.where((element) => element.length <= 3);
    }
  }
}

@immutable
abstract class Action {
  const Action();
}

@immutable
class ChangeFilterType extends Action {
  final ItemFilter filter;
  const ChangeFilterType(this.filter);
}

@immutable
abstract class ItemAction extends Action {
  final String item;
  const ItemAction(this.item);
}

@immutable
class AddItem extends ItemAction {
  const AddItem(String item) : super(item);
}

@immutable
class RemoveItem extends ItemAction {
  const RemoveItem(String item) : super(item);
}

extension AddRemoveItems<T> on Iterable<T> {
  Iterable<T> operator +(T other) => followedBy([other]);
  Iterable<T> operator -(T other) => where((element) => element != other);
}

Iterable<String> addItemReducer(
  Iterable<String> prevItems,
  AddItem action,
) =>
    prevItems + action.item;

Iterable<String> removeItemReducer(
  Iterable<String> prevItems,
  RemoveItem action,
) =>
    prevItems - action.item;

Reducer<Iterable<String>> itemReducers = combineReducers<Iterable<String>>([
  TypedReducer<Iterable<String>, AddItem>(addItemReducer),
  TypedReducer<Iterable<String>, RemoveItem>(removeItemReducer),
]);

ItemFilter itemFilterReducer(
  State old,
  Action action,
) =>
    action is ChangeFilterType ? action.filter : old.filter;

State appReducer(
  State old,
  Action action,
) =>
    State(
      filter: itemFilterReducer(old, action),
      items: itemReducers(old.items, action),
    );

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
