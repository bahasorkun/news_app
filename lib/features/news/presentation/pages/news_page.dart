import 'package:flutter/material.dart';
import 'package:news_app/features/news/data/models/news_model.dart';
import 'package:news_app/features/news/data/news_api.dart';
import 'package:news_app/features/news/presentation/widgets/news_card.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late Future<List<NewsModel>> _newsFuture;
  final _newsApi = NewsApi();

  @override
  void initState() {
    super.initState();
    _newsFuture = _newsApi.getNews();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _newsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Hata : \${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("Hiç haber yok"));
        } else {
          final newsList = snapshot.data!;
          return ListView.builder(
            itemCount: newsList.length,
            itemBuilder: (context, index) {
              final news = newsList[index];
              return NewsCard(
                news: news,
                onTap: () {
                  //TODO Buradan detay sayfasına gidilecek
                  
                },
              );
            },
          );
        }
      },
    );
  }
}
