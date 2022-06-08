import 'package:flutter/material.dart';
import 'package:startup_generator/models/grocery_item.dart';
import 'package:startup_generator/services/grocery_item_servce.dart';
import 'package:collection/collection.dart';

abstract class GroceryListProvider extends ChangeNotifier {
  bool ready = false;
  List<GroceryItem> _items = [];

  // Getters
  List<GroceryItem> get items;
  Map<Category?, List<GroceryItem>> get groupedItems;

  // Operations
  void fetchItems();
  void setItems(List<GroceryItem> items);
  void addItem(GroceryItem groceryItem);
  void removeItem(GroceryItem groceryItem);
}

class GroceryListProviderImplementation extends GroceryListProvider {
  GroceryListProviderImplementation() {
    _init();
  }

  Future<void> _init() async {
    fetchItems();
  }

  @override
  Future<void> fetchItems() async {
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
  Map<Category?, List<GroceryItem>> get groupedItems {
    final group = groupBy(_items, (item) => (item as GroceryItem).category);
    return group;
  }

  @override
  void setItems(List<GroceryItem> items) {
    _items = items;
    notifyListeners();
  }

  @override
  void removeItem(GroceryItem groceryItem) {
    final index = _items.indexWhere((element) => element.id == groceryItem.id);
    _items.removeAt(index);
    groceryItemService.deleteItem(groceryItem);
    notifyListeners();
  }
}
