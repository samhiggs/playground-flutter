import 'package:flutter/material.dart';
import 'package:startup_generator/models/grocery_item.dart';
import 'package:startup_generator/services/grocery_item_servce.dart';

class GroceryItemCheckbox extends StatefulWidget {
  final GroceryItem groceryItem;
  final Function onUpdate;

  const GroceryItemCheckbox({
    Key? key,
    required this.groceryItem,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<GroceryItemCheckbox> createState() => _GroceryItemCheckboxState();
}

class _GroceryItemCheckboxState extends State<GroceryItemCheckbox> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          widget.groceryItem.purchased = !widget.groceryItem.purchased;
          setState(() {});
          widget.onUpdate();
          groceryItemService.togglePurchase(widget.groceryItem.id!);
        },
        icon: Icon(widget.groceryItem.purchased
            ? Icons.check_box
            : Icons.check_box_outline_blank));
  }
}
