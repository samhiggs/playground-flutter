import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:startup_generator/mocks/grocery_item_mock.dart';
import 'package:startup_generator/models/grocery_item.dart';

class GroceryItemService {
  Future<List<GroceryItem>> list() async {
    // call api, return delayed thing
    const data = groceryItems;
    await Future.delayed(const Duration(milliseconds: 1000));

    final List<GroceryItem> results =
        data.map<GroceryItem>((json) => GroceryItem.fromJson(json)).toList();

    return results;
  }
}

GroceryItemService _export() {
  final service = Provider((ref) => GroceryItemService());
  final container = ProviderContainer();
  return container.read(service);
}

final groceryItemService = _export();
