import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/article.dart';
import '../providers/article_provider.dart';

class DetailScreen extends StatelessWidget {
  final Article article;

  const DetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ArticleProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Chi tiết")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(article.title,
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text(article.body),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                provider.toggleFavorite(article);
              },
              child: Text(
                provider.isFavorite(article)
                    ? "Bỏ yêu thích"
                    : "Yêu thích",
              ),
            )
          ],
        ),
      ),
    );
  }
}