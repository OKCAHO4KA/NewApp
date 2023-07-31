import 'package:flutter/material.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:newsapp/src/widgets/list_news.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatefulWidget {
  const Tab1Page({super.key});

  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final newServiceProvider = Provider.of<NewsService>(context);

    return Scaffold(
      body: (newServiceProvider.headLines.isEmpty)
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Center(
              child: ListNews(newServiceProvider.headLines),
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
