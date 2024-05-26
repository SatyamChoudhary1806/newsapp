import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'model/NewsApiServices.dart';
import 'model/news_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NewsListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  late Future<NewsServices?> _newsFuture;

  @override
  void initState() {
    super.initState();
    _newsFuture = NewsApiService().fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Headlines'),
      ),
      body: FutureBuilder<NewsServices?>(
        future: _newsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.articles == null) {
            return const Center(child: Text('No news found'));
          } else {
            final articles = snapshot.data!.articles!;
            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height:4 ,
                  color: Colors.brown.shade100,
                );
              },
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return Card(
                  color: Color(0xABE8FFE8),
                  elevation: 2,
                  child: ListTile(
                    leading:
                    // article.urlToImage != null
                    //     ? Container(
                    //   decoration: BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.lightGreen.shade900,
                    //         spreadRadius: 1,
                    //         blurStyle: BlurStyle.inner,
                    //         blurRadius: 2,
                    //         offset: const Offset(0, 1),
                    //       ),
                    //     ],
                    //   ),
                    //   child: CircleAvatar(
                    //     radius: 25,
                    //     backgroundColor: Colors.white, // Background color of the CircleAvatar
                    //     backgroundImage: NetworkImage(article.urlToImage!),
                    //   ),
                    // )
                    //     : null,
                    article.urlToImage != null
                        ? Container(
                          width: 75,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.lightGreenAccent.withOpacity(.2),
                              boxShadow: [
                                 BoxShadow(
                                      color: Colors.lightGreen.withOpacity(.2),
                                       spreadRadius: 1,
                                       blurStyle: BlurStyle.outer,
                                       blurRadius: 2,
                                       offset: Offset(0, 1),
                                     ),
                                   ],
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: NetworkImage(article.urlToImage!),
                              fit: BoxFit.contain,
                            ),
                          ),
                        )
                        : null,
                    title: Center(
                      child: Text(article.title ?? 'No Title',
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),),
                    ),
                    subtitle: Text( "Published At: ${article.publishedAt!}", style: const TextStyle(fontSize: 11),),
                    onTap: () {
                      _launchURL(Uri.parse(article.url ?? ""));
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _launchURL(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
