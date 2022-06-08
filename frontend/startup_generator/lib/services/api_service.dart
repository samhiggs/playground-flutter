import 'package:dio/dio.dart';
import 'package:startup_generator/models/grocery_item.dart';

// use dart env when going to production
const API_VERSION = "v1";
const API_BASE_URL = "http://localhost:8000/$API_VERSION";

class ApiService {
  String _paramsToQueryString(Map<String, dynamic> params) {
    Map<String, String> _params = {};

    //normalize all the dynamic values to string
    params.entries.forEach((element) {
      _params = {
        ..._params,
        ...{element.key: "${element.value}"},
      };
    });
    // build a uri based on the above params
    return Uri(queryParameters: _params).query;
  }

  // path based on the api url
  Future<Map<String, dynamic>> get(
    String path, [
    Map<String, dynamic> params = const {},
  ]) async {
    final query = _paramsToQueryString(params);
    final url = "$API_BASE_URL$path?$query";
    final response = await Dio().get(url);
    return {"results": response.data};
  }

  Future<Map<String, dynamic>> post(
    String path, [
    Map<String, dynamic> params = const {},
  ]) async {
    final url = "$API_BASE_URL$path/";
    final response = await Dio().post(url, data: params);
    return response.data;
  }

  Future<void> delete(String path) async {
    final url = "$API_BASE_URL$path";
    final response = await Dio().delete(url);
    return response.data;
  }

  Future<Map<String, dynamic>> update(
      String path, Map<String, dynamic> params) async {
    final url = "$API_BASE_URL$path";
    final response = await Dio().put(url, data: params);
    return response.data;
  }
}
