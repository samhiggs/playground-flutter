import 'package:flutter/material.dart';
import 'package:startup_generator/components/grocery_item_checkbox.dart';
import 'package:startup_generator/models/grocery_item.dart';
import 'package:startup_generator/providers/grocery_item_form_provider.dart';
import 'package:startup_generator/providers/grocery_list_provider.dart';
import 'package:startup_generator/screens/add_grocery_item_screen.dart';
import 'package:startup_generator/theme.dart';
import 'package:startup_generator/main.dart';

class GroceryItemCard extends StatefulWidget {
  final GroceryItem groceryItem;
  final Function onUpdate;

  const GroceryItemCard({
    Key? key,
    required this.groceryItem,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<GroceryItemCard> createState() => _GroceryItemCardState();
}

class _GroceryItemCardState extends State<GroceryItemCard> {
  void _handleEdit() async {
    getIt<GroceryItemFormProvider>().setItem(widget.groceryItem);

    await Navigator.of(context).pushNamed(
      AddGroceryItemScreen.routeName,
    );
    setState(() {});
    widget.onUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(), //Key(groceryItem.id.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        final provider =
            getIt<GroceryListProvider>().removeItem(widget.groceryItem);
      },
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
              IconButton(
                onPressed: _handleEdit,
                icon: Icon(
                  Icons.edit,
                  size: 16,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.groceryItem.name,
                      style: ThemeText.bodyText,
                    ),
                  ],
                ),
              ),
              GroceryItemCheckbox(
                groceryItem: widget.groceryItem,
                onUpdate: () {
                  widget.onUpdate();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
