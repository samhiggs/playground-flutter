import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item"),
      ),
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
