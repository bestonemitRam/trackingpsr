import 'package:http/http.dart' as http;

class Connect {
  Future<http.Response> getResponse(String url, Map<String, String> headers) {
    var uri = Uri.parse(url);
    return http.get(uri, headers: headers);
  }

  Future<http.Response> postResponse
  ( String url, Map<String, String> headers, Map<String, String> body) 
      {
      var uri = Uri.parse(url);
      return http.post(uri, headers: headers, body: body);
      }
}
