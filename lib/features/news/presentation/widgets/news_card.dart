// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:news_app/features/news/data/models/news_model.dart';

class NewsCard extends StatelessWidget {
  final NewsModel news;
  final VoidCallback? onTap;
  const NewsCard({super.key, required this.news, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Görsel
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                news.image,
                fit: BoxFit.cover,
                loadingBuilder: (c, w, progress) {
                  if (progress == null) return w;
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
                errorBuilder: (c, e, s) => Container(
                  color: Colors.grey.shade200,
                  alignment: Alignment.center,
                  child: Icon(Icons.image_not_supported_outlined),
                ),
              ),
            ),
            //İçerik
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(16, 16, 16, 8),
              child: Text(
                news.name,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Text(
                news.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: .7),
                ),
              ),
            ),
            //Kaynak Satırı
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 14),
              child: Row(
                children: [
                  Icon(Icons.public, size: 16),
                  SizedBox(width: 8),
                  Text(
                    news.source,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: .7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
