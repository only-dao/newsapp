import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/article_provider.dart';
import 'detail_screen.dart';
import 'favorite_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String keyword = '';

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<ArticleProvider>(context, listen: false)
            .fetchArticles());
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ArticleProvider>(context);

    final articles = keyword.isEmpty
        ? provider.articles
        : provider.search(keyword);

    return Scaffold(
      appBar: AppBar(
        title: const Text("News App"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const FavoriteScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: provider.fetchArticles,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                decoration:
                const InputDecoration(hintText: "Tìm kiếm..."),
                onChanged: (value) {
                  setState(() => keyword = value);
                },
              ),
            ),
            if (provider.isLoading)
              const CircularProgressIndicator(),
            if (provider.error.isNotEmpty)
              Text(provider.error),
            Expanded(
              child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (_, i) {
                  final a = articles[i];

                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(a.title),
                      subtitle: Text(
                        a.body,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Icon(
                        provider.isFavorite(a)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                DetailScreen(article: a),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}