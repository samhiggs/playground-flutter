import 'package:flutter/material.dart';
import 'package:startup_generator/models/grocery_item.dart';
import 'package:startup_generator/providers/grocery_list_provider.dart';
import 'package:startup_generator/services/grocery_item_servce.dart';
import 'package:startup_generator/services/toast_service.dart';

abstract class GroceryItemFormProvider extends ChangeNotifier {
  GroceryItem _groceryItem = GroceryItem();

  bool _isProcessing = false;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  // GETTERS
  GroceryItem get groceryItem;
  bool get isProcessing;
  GlobalKey<FormState> get form;

  // OPERATIONS
  void clearItem();
  void loadItem(GroceryItem item);
  void setItem(GroceryItem item);
  void setCategory(Category? category);

  Future<GroceryItem?> saveItem();

  // VALIDATION
  String? validateName(String? value);

  // VALUES
  void setName(String name);
}

class GroceryItemFormProviderImplementation extends GroceryItemFormProvider {
  GroceryItemFormProviderImplementation();

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
  void setItem(GroceryItem item) {
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

    bool isNew = false;
    if (_groceryItem.id == null) {
      isNew = true;
    }

    final newGroceryItem = await groceryItemService.create(
        _groceryItem.name, _groceryItem.category!);

    if (isNew) {
      ToastService.success("${newGroceryItem.name} Added");
      getIt<GroceryListProvider>().addItem(newGroceryItem);
    } else {
      ToastService.success("${newGroceryItem.name} Updated");
    }

    _isProcessing = false;
    handleUpdate();

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

  @override
  void setCategory(Category? category) {
    _groceryItem.category = category;
  }
}
