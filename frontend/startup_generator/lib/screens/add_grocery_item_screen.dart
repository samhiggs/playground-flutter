import 'package:flutter/material.dart';
import 'package:startup_generator/main.dart';
import 'package:startup_generator/providers/grocery_item_form_provider.dart';

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
      print(newItem.name);
    } else {
      //TODO: show some error
    }
  }

  @override
  Widget build(BuildContext context) {
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
            )
          ]),
        ),
      ),
    );
  }
}
