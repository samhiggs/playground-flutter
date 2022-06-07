enum Category {
  Produce,
  Bakery,
  Dairy,
  Frozen,
  Aisle,
  Household,
  Misc,
}

//  compiles at runtime
const groceryItemCategoryMap = {
  Category.Produce: 'produce',
  Category.Bakery: 'bakery',
  Category.Dairy: 'dairy',
  Category.Frozen: 'frozen',
  Category.Aisle: 'aisle',
  Category.Household: 'household',
  Category.Misc: 'misc',
};

class GroceryItem {
  int? id;
  String name = "";
  Category? category;
  bool purchased = false;

  GroceryItem() {
    //TODO: Maybe set some additional defaults in this constructor
  }

  GroceryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    purchased = json['purchased'];
    category = json['category'] != null
        ? categoryFromString(json['category'])
        : Category.Misc;
  }

  get categoryLabel {
    if (category == null) {
      return "-";
    }

    return GroceryItem.stringFromCategory(category!);
  }

  get categoryValue {
    if (category == null) {
      return "misc";
    }

    return GroceryItem.stringFromCategory(category!);
  }

  static Category? categoryFromString(String category) {
    final categoryMap = groceryItemCategoryMap.entries
        .firstWhere(
            (element) => element.value.toLowerCase() == category.toLowerCase())
        .key;
    return categoryMap;
  }

  static String? stringFromCategory(Category category) {
    return groceryItemCategoryMap[category];
  }
}
