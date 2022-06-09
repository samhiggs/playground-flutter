import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:startup_generator/providers/grocery_item_form_provider.dart';
import 'package:startup_generator/providers/grocery_list_provider.dart';
import 'package:startup_generator/screens/add_grocery_item_screen.dart';
import 'package:startup_generator/screens/list_screen.dart';
import 'package:startup_generator/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';

GetIt getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // final Future<FirebaseApp> _fbApp =
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
  // final FirebaseApp = Firebase.initializeApp();
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

// future thing to learn + implement later
// FutureBuilder(
//   future: _fbApp,
//   builder: (context, snapshot) {
//     if (snapshot.hasError) {
//       print("You have an error. This should really display an error screen ${snapshot.error.toString()}");
//       return Text("Something went wrong");
//     } else if (snapshot.hasData) {
//       return ListScreen() // Not sure if this is the right thing to do
//     }
//   },
// );
