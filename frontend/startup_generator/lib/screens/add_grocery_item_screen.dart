import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:startup_generator/main.dart';
import 'package:startup_generator/models/grocery_item.dart';
import 'package:startup_generator/providers/grocery_item_form_provider.dart';
import 'package:startup_generator/providers/grocery_list_provider.dart';

class AddGroceryItemScreen extends StatefulWidget {
  const AddGroceryItemScreen({Key? key}) : super(key: key);
  static const routeName = '/add-grocery-item';

  @override
  State<AddGroceryItemScreen> createState() => _AddGroceryItemScreenState();
}

class _AddGroceryItemScreenState extends State<AddGroceryItemScreen> {
  final formProvider = getIt<GroceryItemFormProvider>();

  @override
  void initState() {
    super.initState();
    formProvider.addListener(() {
      setStateIfMounted(() {});
    });
  }

  void setStateIfMounted(f) {
    // mounted is a property of a stateful widget so this protects
    // the app from crashing.
    if (mounted) setState(f);
  }

  void handleSave() async {
    if (formProvider.isProcessing) {
      return;
    }

    final newItem = await formProvider.saveItem();

    if (newItem != null) {
      getIt<GroceryListProvider>().addItem(newItem);
    } else {
      print("ERROR: new item is null and therefore cannot be added");
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = [
      Category.Produce,
      Category.Bakery,
      Category.Dairy,
      Category.Frozen,
      Category.Aisle,
      Category.Household,
      Category.Misc,
    ];

    final List<Map<String, dynamic>> _categories = categories.map((category) {
      Map<String, dynamic> cat = new Map<String, dynamic>();
      final strCat = GroceryItem.stringFromCategory(category);
      cat["value"] = strCat;
      cat["label"] = strCat;
      return cat;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text("Add Item"), actions: [
        formProvider.isProcessing
            ? Container(
                width: 24,
                height: 24,
                padding: const EdgeInsets.all(2.0),
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                  // valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
            : TextButton(
                onPressed: handleSave,
                child: Text("Save",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
      ]),
      body: Form(
        key: formProvider.form,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: "Item Name",
              ),
              autofocus: true,
              onChanged: (value) {
                formProvider.setName(value);
              },
              validator: formProvider.validateName,
            ),
            SelectFormField(
              type: SelectFormFieldType.dropdown, // or can be dialog
              // initialValue: 'misc',
              // icon: Icon(Icons.local_offer),
              labelText: 'Category',
              items: _categories,
              onChanged: (val) => {
                formProvider.setCategory(GroceryItem.categoryFromString(val))
              },
              onSaved: (val) => print(val),
            ),
          ]),
        ),
      ),
    );
  }
}
