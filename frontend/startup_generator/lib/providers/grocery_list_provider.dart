import 'package:flutter/material.dart';
import 'package:startup_generator/models/grocery_item.dart';
import 'package:startup_generator/services/grocery_item_servce.dart';

abstract class GroceryListProvider extends ChangeNotifier {
  bool ready = false;
  List<GroceryItem> _items = [];

  // Getters
  List<GroceryItem> get items;

  // Operations
  void setItems(List<GroceryItem> items);
  void addItem(GroceryItem groceryItem);
}

class GroceryListProviderImplementation extends GroceryListProvider {
  GroceryListProviderImplementation() {
    _init();
  }

  Future<void> _init() async {
    final items = await groceryItemService.list();
    setItems(items);
    ready = true;
    notifyListeners();
  }

  @override
  void addItem(GroceryItem groceryItem) {
    _items.add(groceryItem);
    notifyListeners();
  }

  @override
  List<GroceryItem> get items => _items;

  @override
  void setItems(List<GroceryItem> items) {
    _items = items;
    notifyListeners();
  }
}
