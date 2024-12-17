import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'spotifyAPI.dart';

class ArtistSearchField extends StatelessWidget {
  final TextEditingController controller;

  ArtistSearchField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<String>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller,
        decoration: const InputDecoration(
          labelText: "好きなアーティストを入力",
        ),
      ),
      suggestionsCallback: (pattern) async {
        if (pattern.length < 3) {
          return []; // 3文字以上入力されるまで候補を表示しない
        }
        return await SpotifyService.searchArtists(pattern);
      },
      itemBuilder: (context, String suggestion) {
        return ListTile(
          title: Text(suggestion),
        );
      },
      onSuggestionSelected: (String suggestion) {
        controller.text = suggestion;
      },
    );
  }
}
