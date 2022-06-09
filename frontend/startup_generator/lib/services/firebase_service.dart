import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final DatabaseReference database = FirebaseDatabase.instance.ref();

  String _paramsToQueryString(Map<String, dynamic> params) {
    UnimplementedError("paramsToQueryString not implemented for firebase");
    return ""; // todo change return type to be optional
  }

  // path based on the api url
  Future<Map<String, dynamic>> get(
    String path, [
    Map<String, dynamic> params = const {},
  ]) async {
    dynamic data = {};
    final items = database.child(path);
    final snapshot = await items.get();
    if (snapshot.exists) {
      data = snapshot.value;
    }
    return {"results": data};
  }

  Future<Map<String, dynamic>> post(
    String path, [
    Map<String, dynamic> params = const {},
  ]) async {
    final items = database.child(path).push();
    items
        .set(params)
        .then((_) => print("added item to database"))
        .catchError((error) => print("You got an error $error"));
    Map<String, dynamic> data = {};
    params["id"] = items.key;
    print(params);
    return params;
  }

  Future<void> delete(String path) async {
    // final url = "$API_BASE_URL$path";
    // final response = await Dio().delete(url,
    //     options: Options(
    //       headers: authHeader,
    //     ));
  }

  Future<Map<String, dynamic>> update(
      String path, Map<String, dynamic> params) async {
    // final url = "$API_BASE_URL$path";
    // final response = await Dio().put(url,
    //     data: params,
    //     options: Options(
    //       headers: authHeader,
    //     ));
    Map<String, dynamic> data = {};
    return data;
  }
}
