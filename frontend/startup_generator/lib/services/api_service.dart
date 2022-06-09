import 'dart:math';

import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';

// use dart env when going to production
const API_VERSION = "v1";
const API_BASE_URL = "http://localhost:8000/$API_VERSION";
// const API_BASE_URL = "https://backend-g4ircgsnhq-ts.a.run.app/$API_VERSION";

const token =
    "eyJhbGciOiJSUzI1NiIsImtpZCI6Ijc0ODNhMDg4ZDRmZmMwMDYwOWYwZTIyZjNjMjJkYTVmZTM5MDZjY2MiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIzMjU1NTk0MDU1OS5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImF1ZCI6IjMyNTU1OTQwNTU5LmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTA2NDA4NjA0OTgxNjA4NDM3NDM4IiwiZW1haWwiOiJoaWdnenk3N0BnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiYXRfaGFzaCI6InJJUTdmdzlzU2s2MGtfMkxkQ3JRbkEiLCJpYXQiOjE2NTQ2Nzc4MjgsImV4cCI6MTY1NDY4MTQyOH0.smbBqNlb-ZAcsufyJFwjvyYmCXSxw_HN01qkl6iDHnwEvIWjtem5WjdXXXHQLt85fbOTsQwOhVoDxqAABIS7OSzHENotAItcJTbe13BQTbic1-70Wx59043XDhcJg8EmlAp5ppTOOVQtHrXBAflaCHcSwRHeeieqmuPGye9YOPDbauU5xzC4PisujbCaeAFjZFhdv78hiJDYVCwNz9S507GHEiLbSc2m6XGuRYGrVL85i9prHpm_Zre89pEE9wXxgKfbbsaej_Dwv9bmFl2iPg84IDOznZJ0NdCEeEzQ8Rv9hblg8Kupo3nGIbNsV2d0zPOakcRSBGGgzUv_rh7bhQ";
const authHeader = {"Authorization": "Bearer $token"};

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
    final response = await Dio().get(url,
        options: Options(
          headers: authHeader,
        ));

    return {"results": response.data};
  }

  Future<Map<String, dynamic>> post(
    String path, [
    Map<String, dynamic> params = const {},
  ]) async {
    print("Hello from post");
    final url = "$API_BASE_URL$path/";
    final response = await Dio().post(url,
        data: params,
        options: Options(
          headers: authHeader,
        ));

    return response.data;
  }

  Future<void> delete(String path) async {
    final url = "$API_BASE_URL$path";
    final response = await Dio().delete(url,
        options: Options(
          headers: authHeader,
        ));
    return response.data;
  }

  Future<Map<String, dynamic>> update(
      String path, Map<String, dynamic> params) async {
    final url = "$API_BASE_URL$path";
    final response = await Dio().put(url,
        data: params,
        options: Options(
          headers: authHeader,
        ));
    return response.data;
  }
}
