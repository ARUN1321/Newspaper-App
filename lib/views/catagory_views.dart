import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newspaper/helper/news.dart';
import 'package:newspaper/models/article.dart';
import 'package:newspaper/views/article_views.dart';

class Catagorynews extends StatefulWidget {
  const Catagorynews({Key? key, required this.category}) : super(key: key);
  final String category;

  @override
  _CatagorynewsState createState() => _CatagorynewsState();
}

class _CatagorynewsState extends State<Catagorynews> {
  List<ArticleModel> articles = <ArticleModel>[];
  // ignore: non_constant_identifier_names
  bool _Loading = true;

  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _Loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "News",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        actions: [
          Opacity(
            opacity: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(Icons.save),
            ),
          )
        ],
      ),
      body: _Loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              // ignore: avoid_unnecessary_containers
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    ///blogs
                    // ignore: avoid_unnecessary_containers
                    Container(
                      padding: const EdgeInsets.only(top: 16),
                      child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          return BlogTile(
                            imageUrl: articles[index].urlToImage,
                            title: articles[index].title,
                            desc: articles[index].description,
                            url: articles[index].url,
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;
  // ignore: use_key_in_widget_constructors
  const BlogTile({
    required this.imageUrl,
    required this.title,
    required this.desc,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Articleview(
                blogUrl: url,
              ),
            ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              desc,
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
