import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;

const _urlNews = 'https://newsapi.org/v2';
const _apiKey = '3343e0af7ca24a6fb1105aba70b799da';

class NewsService with ChangeNotifier {
  List<Article> headLines = [];

  String _selectedCategory = 'general';

  String get selectedCategory => _selectedCategory;
  set selectedCategory(String value) {
    _selectedCategory = value;
    getArticlesForCategory(value);
    notifyListeners();
  }

  Map<String, List<Article>> categoryArticle = {};
  List<Category> categories = [
    Category(FontAwesomeIcons.globe, 'general'),
    Category(FontAwesomeIcons.briefcase, 'business'),
    Category(FontAwesomeIcons.briefcaseMedical, 'health'),
    Category(FontAwesomeIcons.wrench, 'sports'),
    Category(FontAwesomeIcons.atom, 'science'),
    Category(FontAwesomeIcons.laptop, 'technology'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
  ];

  NewsService() {
    getHeadLines();

    for (var element in categories) {
      categoryArticle[element.name] = [];
    }
  }

  getHeadLines() async {
    final url = Uri.parse('$_urlNews/top-headlines?country=us&apiKey=$_apiKey');
    final resp = await http.get(url);
    final NewsResponse newResponse = newsResponseFromJson(resp.body);

    headLines.addAll(newResponse.articles as Iterable<Article>);

    notifyListeners();
  }

  getArticlesForCategory(String cat) async {
    if (categoryArticle[cat]!.isNotEmpty) {
      return categoryArticle[cat];
    }
    final url = Uri.parse(
        '$_urlNews/top-headlines?country=us&apiKey=$_apiKey&category=$cat');
    final resp = await http.get(url);
    final NewsResponse newResponse = newsResponseFromJson(resp.body);
    categoryArticle[cat]!.addAll(newResponse.articles as Iterable<Article>);
    notifyListeners();
  }
}
