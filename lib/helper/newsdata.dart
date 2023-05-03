import 'dart:convert';
import 'package:http/http.dart';
import 'package:news_flutter/model/newsmodel.dart';

//recuperer news par categorie
class News {
  //pour donnees json
  List<ArticleModel> dataToBeSavedIn = [];

 Future<void> getNews() async {
   var response = await get(Uri.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=5226017a2d37404ba457b7945e39c04c'));
    var jsonData = jsonDecode(response.body);
  
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            urlToImage: element['urlToImage'],
            description: element['description'],
            url: element['url'],
          );
          dataToBeSavedIn.add(articleModel);
        }
      });
    }
  }
}
//recuperer par categories
class CategoryNews {
  List<ArticleModel> dataToBeSavedIn = [];

  Future<void> getNews(String category) async {
    //verifier 
   var response = await get(Uri.parse('https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=5226017a2d37404ba457b7945e39c04c'));
    var jsonData = jsonDecode(response.body);
  
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            urlToImage: element['urlToImage'],
            description: element['description'],
            url: element['url'],
          );
          dataToBeSavedIn.add(articleModel);
        }
      });
    }
  }
}
