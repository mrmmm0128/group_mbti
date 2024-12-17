import 'dart:convert';
import 'package:http/http.dart' as http;

class SpotifyService {
  static const String _clientId = "941453f98f2d4934bcf2a7ffc075a263";
  static const String _clientSecret = "bff62902a89e435ab7efde98ddcd51c3";
  static String? _accessToken;

  // トークンを取得する関数
  static Future<void> _getAccessToken() async {
    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'grant_type': 'client_credentials',
        'client_id': _clientId,
        'client_secret': _clientSecret,
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      _accessToken = json['access_token'];
    } else {
      throw Exception("Failed to obtain access token");
    }
  }

  // アーティストを検索する関数
  static Future<List<String>> searchArtists(String query) async {
    if (_accessToken == null) {
      await _getAccessToken();
    }

    final response = await http.get(
      Uri.parse(
          'https://api.spotify.com/v1/search?q=$query&type=artist&limit=5'),
      headers: {
        'Authorization': 'Bearer $_accessToken',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List artists = json['artists']['items'];
      return artists.map<String>((artist) => artist['name'] as String).toList();
    } else {
      throw Exception("Failed to fetch artists");
    }
  }
}
