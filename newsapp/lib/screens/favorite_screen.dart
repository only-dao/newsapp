import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/article_provider.dart';
import 'detail_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ArticleProvider>(context);
    final favorites = provider.favorites;

    return Scaffold(
      appBar: AppBar(title: const Text("Yêu thích")),
      body: favorites.isEmpty
          ? const Center(child: Text("Chưa có bài yêu thích"))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (_, i) {
          final article = favorites[i];

          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(article.title),
              subtitle: Text(
                article.body,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const Icon(Icons.favorite,
                  color: Colors.red),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        DetailScreen(article: article),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}