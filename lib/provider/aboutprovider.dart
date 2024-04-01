import 'package:bmitserp/repositories/aboutrepository.dart';
import 'package:flutter/material.dart';

class AboutProvider with ChangeNotifier {
  AboutRepository repository = AboutRepository();

  final Map<String, String> _content = {
    'title': '',
    'description': '',
  };

  Map<String, String> get content {
    return _content;
  }

  Future<void> getContent(String value) async {
    try {
      final response = await repository.getContent(value);
      _content.update('title', (value) => response.data.title);
      _content.update('description', (value) => response.data.description);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
