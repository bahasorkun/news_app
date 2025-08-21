// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:news_app/core/widgets/app_appbar.dart';
import 'package:news_app/core/widgets/app_drawer.dart';
import 'package:news_app/features/news/data/models/news_model.dart';

class NewsDetailPage extends StatefulWidget {
  final NewsModel item;
  const NewsDetailPage({super.key, required this.item});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(title: "Haber Detayı"),
      drawer: AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          if (widget.item.image.isNotEmpty)
            Image.network(widget.item.image, fit: BoxFit.cover),
          const SizedBox(height: 16),
          Text(
            widget.item.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            widget.item.source,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
          Text(widget.item.description, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
