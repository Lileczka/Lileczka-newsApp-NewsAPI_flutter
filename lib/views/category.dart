import 'package:flutter/material.dart';

import 'package:news_flutter/helper/newsdata.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_flutter/model/newsmodel.dart';

class CategoryFragment extends StatefulWidget {
  final String category;
//constructor
   const CategoryFragment(
    {Key? key, required this.category}
    ) : super(key: key);

  @override
  CategoryFragmentState createState() => CategoryFragmentState();
}

class CategoryFragmentState extends State<CategoryFragment> {
  
  List<ArticleModel> articles = [];
  bool _loading = true;
   
   getNews() async {
    CategoryNews newsdata = CategoryNews();
    await newsdata.getNews(widget.category);
    articles = newsdata.dataToBeSavedIn;
    //pour charger des news automatiquement sans passer par hotreload
    setState((){
      _loading = false;
   });
  }
   

  @override
  
  void initState() {
    super.initState();
    getNews();
  }

  @override
  
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: const EdgeInsets.only(right:50),
            child:Text(widget.category.toUpperCase(),
              
            ),
            ),
          ],
        ),
      ),
body: _loading ? const Center(
  child: CircularProgressIndicator(
      ),
      ): SingleChildScrollView(
      
      child: ListView.builder(
            itemCount: articles.length,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return NewsTemplate(
                urlToImage: articles[index].urlToImage,
                title: articles[index].title,
                description: articles[index].description,
                url: articles[index].url,
              );
            },
          ),
    ),
  );
  }
}
class NewsTemplate extends StatelessWidget {
  
  final String title;
  final String description;
  final String urlToImage;
  final String url;
  
  const NewsTemplate({
     Key? key,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
  }) : super(key: key);

  @override
Widget build(BuildContext context) {
  return Container(
    margin: const EdgeInsets.all(16),
    child: Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: urlToImage,
            width: 280.0,
            height: 150.0,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(
            color: Color.fromARGB(255, 23, 68, 105),
            fontSize: 24.0,
          ),
        ),
      ],
    ),
  );
}
}