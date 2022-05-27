import 'package:flutter/material.dart';
import 'package:startup_generator/components/grocery_item_card.dart';
import 'package:startup_generator/models/grocery_item.dart';
import 'package:startup_generator/services/grocery_item_servce.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  List<GroceryItem> _items = [];

  @override
  void initState() {
    super.initState();

    _init();
  }

  Future<void> _init() async {
    final items = await groceryItemService.list();
    setState(() {
      _items = items;
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("My List"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){}, 
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: _items.length, 
        itemBuilder: (ctx, index) {
          final item = _items[index];

          return GroceryItemCard(groceryItem: item);

        }),
    );
  
  }
}