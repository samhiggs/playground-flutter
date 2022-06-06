import 'package:flutter/material.dart';
import 'package:startup_generator/components/grocery_item_checkbox.dart';
import 'package:startup_generator/models/grocery_item.dart';
import 'package:startup_generator/theme.dart';

class GroceryItemCard extends StatelessWidget {
  final GroceryItem groceryItem;

  const GroceryItemCard({
    Key? key,
    required this.groceryItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(), //Key(groceryItem.id.toString()),
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red,
        ),
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    groceryItem.name,
                    style: ThemeText.bodyText,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(groceryItem.categoryLabel, style: ThemeText.caption)
                ],
              ),
              GroceryItemCheckbox(groceryItem: groceryItem),
            ],
          ),
        ),
      ),
    );
  }
}
