import 'package:flutter/material.dart';
import 'package:news_flutter/helper/categoriedata.dart';
import 'package:news_flutter/helper/newsdata.dart';
import 'package:news_flutter/model/categoriemodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_flutter/model/newsmodel.dart';
import 'package:news_flutter/views/category.dart';

class HomePage extends StatefulWidget {
  const HomePage ({super.key});
    @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  
 
   // recuperer la liste de categorie
  List<CategorieModel> categories = [];
  //List<CategorieModel> categories = [];
  bool _loading = true;
  
  List<ArticleModel> articles = [];
  
  //verifier
  getNews() async {
    News newsdata = News();
    await newsdata.getNews();
    articles = newsdata.dataToBeSavedIn;
    setState((){
      _loading = false;
   });
  }
  
  @override

  void initState() {
    super.initState();
    // la liste est égal à la méthode
  categories = getCategories();
  getNews();
}
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        //pour centrer titre on peut mettre elevation:0.0;
        title: const Text(
          'News',
          style: TextStyle(color: Color.fromRGBO(220, 240, 245, 1)),
        ),
      ),
      //category
      body: _loading ? Center(
  child: CircularProgressIndicator(
      ),
      ): SingleChildScrollView(
    child: Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            height: 170.0,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView.builder(
              itemCount: categories.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CategoryTile(
                  imageUrl: categories[index].imageUrl,
                  categorieName: categories[index].categorieName,
                );
              },
            ),
          ),
          Container(
            child: ListView.builder(
              itemCount: articles.length,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return NewsTemplate(
                  title: articles[index].title,
                  description: articles[index].description,
                  urlToImage: articles[index].urlToImage,
                  url: articles[index].url,
                );
              },
            ),
          ),
        ],
      ),
    ),
  ),
);

  }
}
//pour des images des categories
class CategoryTile extends StatelessWidget {
 
   final String categorieName;
   final String imageUrl;
   
   const CategoryTile({
    Key? key,
    required this.categorieName,
    required this.imageUrl,
  }) : super(key: key);

  @override
Widget build(BuildContext context) {
  
    return GestureDetector(
      onTap:(){
        Navigator.push(context, MaterialPageRoute(
        builder: (context)=> CategoryFragment(
          //valeur de CategoryFragment
        category: categorieName.toLowerCase(),
  ),
   ));
    },
    child:Container(
    margin: const EdgeInsets.only(right: 20.0),
    child: Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            width: 180.0,
            height: 150.0,
            fit: BoxFit.cover,
          ),
        ),
        // Texte sur les catégories
        Container(
          //voile pour le text plus visible
          alignment: Alignment.center,
          width: 180,
          height: 150,
          decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(89, 9, 3, 25),
          ),
          //text sur categories
          child: Text(
            categorieName,
            style: const  TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 26,
            ),
          ),
        ),
      ],
    ),
    ),
  );
  }
}

class NewsTemplate extends StatelessWidget {
final String title; 
final String description;
final String  urlToImage;
final String  url;
  
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
            borderRadius: BorderRadius.circular(8),
        
           child: CachedNetworkImage(
            imageUrl: urlToImage,
            width: 380,
            height: 200,
            fit: BoxFit.cover, 
            ),
             ),
         const SizedBox(
            height: 10,
          ),
          Text(title,
          style: const  TextStyle(
           fontSize: 16.0 ,
           fontWeight: FontWeight.bold),
           ),
          const SizedBox(
            height: 10,
            ),
            Text(description,
          style: const TextStyle(
           fontSize: 24.0,
            ),
           ),
        ],
        ),
    );
  }
}
