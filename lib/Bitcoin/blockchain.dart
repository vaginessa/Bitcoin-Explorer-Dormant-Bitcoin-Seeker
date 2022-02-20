// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;

class Blockchain{

  static String baseUrl = "https://blockchain.info/balance?cors=true&active=";

  Future<http.Response> request(String address) 
  {
    return http.get(Uri.parse(baseUrl + address));
  }
}