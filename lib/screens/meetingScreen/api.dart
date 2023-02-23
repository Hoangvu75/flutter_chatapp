import 'dart:convert';

import 'package:http/http.dart' as http;

String token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiI1MDdlNTljYi00NGVhLTQwODUtYTkzMi1hMzQ1NzkwNGQwY2YiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTY3NTgzOTk1NCwiZXhwIjoxODMzNjI3OTU0fQ.kIBza_ZlRGpys9M1n1vR3iGWgpkoelCyp23f2I9oc8w";

Future<String> createMeeting() async {
  final http.Response httpResponse = await http.post(
    Uri.parse("https://api.videosdk.live/v2/rooms"),
    headers: {'Authorization': token},
  );

  return json.decode(httpResponse.body)['roomId'];
}
