import 'package:flutter/material.dart';
import 'package:startup_generator/components/grocery_list.dart';
import 'package:startup_generator/screens/add_grocery_item_screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  void _handleAddItem() {
    Navigator.of(context).pushNamed(AddGroceryItemScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My List"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _handleAddItem,
          child: const Icon(Icons.add),
        ),
        body: GroceryList(
          handleAddItem: _handleAddItem,
        ));
  }
}
