import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:startup_generator/models/grocery_item.dart';
import 'package:startup_generator/services/api_service.dart';
import 'package:startup_generator/services/firebase_service.dart';

GetIt getIt = GetIt.instance;

class GroceryItemService extends ApiService {
  List<GroceryItem> items = [];

  Future<List<GroceryItem>> list() async {
    // final data = await get("/items/");
    final data = await FirebaseService().get("/items");
    final mappedData = Map<String, dynamic>.from(data)["results"];
    final List<GroceryItem> results = [];
    mappedData.forEach((k, v) {
      v["id"] = k;
      // cast internal hash mappy thing to a usable map
      Map<String, dynamic> valClean = Map<String, dynamic>.from(v);
      results.add(GroceryItem.fromJson(valClean));
    });
    return results;
  }

  Future<GroceryItem> create(String name, Category category) async {
    final categoryName = GroceryItem.stringFromCategory(category);
    final params = {
      "name": name,
      "category": categoryName,
      "purchased": false,
    };

    // final data = await post("/items", params);
    final data = await FirebaseService().post("/items", params);

    return GroceryItem.fromJson(data);
  }

  Future<void> deleteItem(GroceryItem item) async {
    await delete("/items/${item.id}");
  }

  Future<void> purchaseItem(GroceryItem item, bool purchase) async {
    String endpoint = purchase ? "purchase" : "unpurchase";
    await post("/items/${item.id}/$endpoint");
  }

  Future<GroceryItem> updateItem(String id, GroceryItem item) async {
    final params = {
      "name": item.name,
      "category": item.categoryValue,
      "purchased": item.purchased,
    };
    final data = await update("/items/${item.id}", params);
    return GroceryItem.fromJson(data);
  }
}

GroceryItemService _export() {
  final service = Provider((ref) => GroceryItemService());
  final container = ProviderContainer();
  return container.read(service);
}

final groceryItemService = _export();
