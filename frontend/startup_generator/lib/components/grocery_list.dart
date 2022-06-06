import 'package:flutter/material.dart';
import 'package:startup_generator/components/empty_list_indicator.dart';
import 'package:startup_generator/components/grocery_item_card.dart';
import 'package:startup_generator/providers/grocery_list_provider.dart';
import 'package:startup_generator/services/grocery_item_servce.dart';

class GroceryList extends StatefulWidget {
  final Function handleAddItem;
  const GroceryList({Key? key, required this.handleAddItem}) : super(key: key);

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final listProvider = getIt<GroceryListProvider>();

  @override
  void initState() {
    super.initState();
    listProvider.addListener(() {
      setStateIfMounted(() {});
    });
  }

  void setStateIfMounted(f) {
    // mounted is a property of a stateful widget so this protects
    // the app from crashing.
    if (mounted) setState(f);
  }

  Future<void> _refreshData() async {
    // _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final items = listProvider.items;

    if (!listProvider.ready) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (items.isEmpty) {
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
        itemCount: items.length,
        itemBuilder: (ctx, index) {
          final item = items[index];
          return GroceryItemCard(groceryItem: item);
        },
      ),
    );
  }
}
