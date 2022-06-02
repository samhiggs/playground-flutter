import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:startup_generator/providers/grocery_item_form_provider.dart';
import 'package:startup_generator/providers/grocery_list_provider.dart';
import 'package:startup_generator/screens/add_grocery_item_screen.dart';
import 'package:startup_generator/screens/list_screen.dart';
import 'package:startup_generator/theme.dart';

GetIt getIt = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized;

  setupSingletons();

  runApp(MyApp());
}

void setupSingletons() {
  getIt.registerSingleton<GroceryItemFormProvider>(
    GroceryItemFormProviderImplementation(),
    signalsReady: true,
  );

  getIt.registerSingleton<GroceryListProvider>(
    GroceryListProviderImplementation(),
    signalsReady: true,
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "My Shopper",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: ThemeColors.primary),
        routes: {
          '/': (ctx) => ListScreen(),
          AddGroceryItemScreen.routeName: (ctx) => AddGroceryItemScreen(),
        });
  }
}
