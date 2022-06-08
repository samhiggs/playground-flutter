import 'package:flutter/material.dart';
import 'package:startup_generator/components/empty_list_indicator.dart';
import 'package:startup_generator/components/grocery_item_card.dart';
import 'package:startup_generator/models/grocery_item.dart';
import 'package:startup_generator/providers/grocery_list_provider.dart';
import 'package:startup_generator/services/grocery_item_servce.dart';
import 'package:startup_generator/theme.dart';

class GroceryList extends StatefulWidget {
  final Function handleAddItem;

  final bool hidePurchased;

  const GroceryList(
      {Key? key, required this.handleAddItem, this.hidePurchased = false})
      : super(key: key);

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final listProvider = getIt<GroceryListProvider>();

  @override
  void initState() {
    super.initState();

    listProvider.addListener(() {
      setStateIfMounted(() {});
    });
  }

  void setStateIfMounted(f) {
    // mounted is a property of a stateful widget so this protects
    // the app from crashing.
    if (mounted) setState(f);
  }

  Future<void> _refreshData() async {
    listProvider.fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    final items = listProvider.items;

    if (!listProvider.ready) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (items.isEmpty) {
      return Center(
          child: EmptyListInd(
        title: "No Grocery Items",
        buttonText: "Add Item",
        onButtonPressed: widget.handleAddItem,
      ));
    }

    // final groups =
    Map<Category?, List<GroceryItem>> groups = listProvider.groupedItems;

    if (widget.hidePurchased) {
      groups = {};

      listProvider.groupedItems.keys.forEach((key) {
        // get the items and whether you should include the items (start with no)
        final items = listProvider.groupedItems[key];
        bool shouldInclude = false;

        // iterate over the items, if any items are valid, then include it
        // unfortunately you can't break a foreach loop
        items!.forEach((item) {
          if (!item.purchased) {
            shouldInclude = true;
          }
        });

        // if we got at least one item then add the group back to groups
        if (shouldInclude) {
          groups[key] = items;
        }
      });
    }

    return RefreshIndicator(
      onRefresh: _refreshData,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: groups.entries.length,
        itemBuilder: (ctx, index) {
          final key = groups.keys.elementAt(index);
          final group = groups[key];
          final filteredGroup = widget.hidePurchased
              ? group!.where(
                  (element) => !element.purchased,
                )
              : group;

          final categoryName = key != null
              ? GroceryItem.stringFromCategory(key)!.toUpperCase()
              : null;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: ThemeColors.secondary,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      categoryName ?? "-",
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
                ...filteredGroup!.map((item) {
                  return GroceryItemCard(
                      groceryItem: item,
                      onUpdate: () {
                        setState(() {});
                      });
                }).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
