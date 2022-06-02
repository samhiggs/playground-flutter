import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:startup_generator/mocks/grocery_item_mock.dart';
import 'package:startup_generator/models/grocery_item.dart';

GetIt getIt = GetIt.instance;

class GroceryItemService {
  List<GroceryItem> items = [];

  Future<List<GroceryItem>> list() async {
    // call api, return delayed thing
    const data = groceryItems;
    await Future.delayed(const Duration(milliseconds: 1000));

    final List<GroceryItem> results =
        data.map<GroceryItem>((json) => GroceryItem.fromJson(json)).toList();

    items = results;
    return results;
  }

  Future<GroceryItem> create(String name, Category category) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final groceryItem = GroceryItem.fromJson({
      "id": 99,
      "name": name,
      "category": GroceryItem.stringFromCategory(category),
      "purchased": false,
    });

    items.add(groceryItem);

    return groceryItem;
  }
}

GroceryItemService _export() {
  final service = Provider((ref) => GroceryItemService());
  final container = ProviderContainer();
  return container.read(service);
}

final groceryItemService = _export();
