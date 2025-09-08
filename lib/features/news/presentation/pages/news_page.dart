import 'package:flutter/material.dart';
import 'package:news_app/core/l10n/app_localizations.dart';
import 'package:news_app/features/news/data/models/news_model.dart';
import 'package:news_app/features/news/data/news_api.dart';
import 'package:news_app/features/news/presentation/pages/news_detail_page.dart';
import 'package:news_app/features/news/presentation/widgets/news_card.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Future<List<NewsModel>>? _newsFuture;
  final _newsApi = NewsApi();
  Locale? _lastLocale;

  void _load() {
    // Country is auto-selected inside NewsApi based on AppState locale.
    final fut = _newsApi.getNews();
    setState(() {
      _newsFuture = fut;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final current = Localizations.localeOf(context);
    if (_lastLocale != current || _newsFuture == null) {
      _lastLocale = current;
      _load();
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return FutureBuilder<List<NewsModel>>(
      future: _newsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            _newsFuture == null) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text('${loc.t('newsError')}: ${snapshot.error}'),
          );
        }
        final data = snapshot.data ?? const <NewsModel>[];
        if (data.isEmpty) {
          return Center(child: Text(loc.t('noNews')));
        }
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final news = data[index];
            return NewsCard(
              news: news,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsDetailPage(item: news),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
