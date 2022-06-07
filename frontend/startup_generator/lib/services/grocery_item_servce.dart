import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:startup_generator/models/grocery_item.dart';
import 'package:startup_generator/services/api_service.dart';

GetIt getIt = GetIt.instance;

class GroceryItemService extends ApiService {
  List<GroceryItem> items = [];

  Future<List<GroceryItem>> list() async {
    // const data = groceryItems;
    // await Future.delayed(const Duration(milliseconds: 1000));

    final data = await get("/items/");
    print(data);
    final List<GroceryItem> results = data["results"]
        .map<GroceryItem>((json) => GroceryItem.fromJson(json))
        .toList();

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

    return groceryItem;
  }
}

GroceryItemService _export() {
  final service = Provider((ref) => GroceryItemService());
  final container = ProviderContainer();
  return container.read(service);
}

final groceryItemService = _export();
