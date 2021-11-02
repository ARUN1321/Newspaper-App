import 'dart:convert';
import 'package:newspaper/models/article.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];
  Future<void> getNews() async {
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=5c2be84a9b8548ab8dde4cfa1eaa1023");
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element["title"],
            author: element["author"] ?? '',
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"] ?? '',
          );
          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNewsClass {
  List<ArticleModel> news = [];
  Future<void> getNews(String category) async {
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=5c2be84a9b8548ab8dde4cfa1eaa1023");
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element["title"],
            author: element["author"] ?? '',
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["context"] ?? '',
          );
          news.add(articleModel);
        }
      });
    }
  }
}
