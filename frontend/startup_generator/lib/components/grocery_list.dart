import 'package:flutter/material.dart';
import 'package:startup_generator/components/empty_list_indicator.dart';
import 'package:startup_generator/components/grocery_item_card.dart';
import 'package:startup_generator/models/grocery_item.dart';
import 'package:startup_generator/services/grocery_item_servce.dart';
import 'package:startup_generator/theme.dart';

class GroceryList extends StatefulWidget {
  final Function handleAddItem;
  const GroceryList({Key? key, required this.handleAddItem}) : super(key: key);

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  bool _loading = false;
  List<GroceryItem> _items = [];

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _loading = true;
    });

    final items = await groceryItemService.list();

    setState(() {
      _items = items;
      _loading = false;
    });
  }

  Future<void> _refreshData() async {
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (_items.isEmpty) {
      return Center(
          child: EmptyListInd(
        title: "No Grocery Items",
        buttonText: "Add Item",
        onButtonPressed: widget.handleAddItem,
      ));
    }

    return RefreshIndicator(
      onRefresh: _refreshData,
      child: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (ctx, index) {
          final item = _items[index];
          return GroceryItemCard(groceryItem: item);
        },
      ),
    );
  }
}
