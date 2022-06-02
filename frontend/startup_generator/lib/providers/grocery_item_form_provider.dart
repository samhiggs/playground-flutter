import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:startup_generator/models/grocery_item.dart';

abstract class GroceryItemFormProvider extends ChangeNotifier {
  GroceryItem _groceryItem = GroceryItem();

  bool _isProcessing = false;
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  // GETTERS
  GroceryItem get groceryItem;
  bool get isProcessing;
  GlobalKey<FormState> get form;

  // OPERATIONS
  void clearItem();
  void loadItem(GroceryItem item);
  Future<GroceryItem?> saveItem();

  // VALIDATION
  String? validateName(String? value);

  // VALUES
  void setName(String name);
}

class GroceryItemFormProviderImplementation extends GroceryItemFormProvider {
  GroceryItemFormProviderImplementation() {}

  void handleUpdate() {
    notifyListeners();
  }

  @override
  void clearItem() {
    _groceryItem = GroceryItem();
    handleUpdate();
  }

  @override
  GlobalKey<FormState> get form => _form;

  @override
  GroceryItem get groceryItem => _groceryItem;

  @override
  bool get isProcessing => _isProcessing;

  @override
  void loadItem(GroceryItem item) {
    _groceryItem = item;
    handleUpdate();
  }

  @override
  Future<GroceryItem?> saveItem() async {
    if (!_form.currentState!.validate()) {
      handleUpdate();
      return null;
    }

    _isProcessing = true;
    handleUpdate();
    await Future.delayed(const Duration(milliseconds: 500));

    GroceryItem? newGroceryItem = GroceryItem.fromJson({
      "id": 2,
      "name": _groceryItem.name,
      "category": "misc",
      "purchased": false
    });

    handleUpdate();
    _isProcessing = false;
    return newGroceryItem;
  }

  @override
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Item name is required";
    }
    return null;
  }

  @override
  void setName(String name) {
    _groceryItem.name = name;
    handleUpdate();
  }
}
