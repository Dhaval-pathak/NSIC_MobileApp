import 'package:http/http.dart' as http;

Future fetchUser(String udyam, String pan) async {
  var client = http.Client();
  var uri = Uri.parse(
      "http://api.nsicnet.in/MDBRestService/Service.svc/xml/$udyam,$pan,SPR-7314SIGEF559UQAK");
  try {
    var resp = await client.get(uri, headers: null);
    if (resp.statusCode == 200) {
      return resp.body;
    }
  } catch (e) {
    return e;
  }
}
