import 'package:flutter/material.dart';
import 'package:newsapp/src/pages/tab1_page.dart';
import 'package:newsapp/src/pages/tab2_page.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _NavegationModel(),
      child: Scaffold(
        body: _Pages(),
        bottomNavigationBar: _NavegationBar(),
      ),
    );
  }
}

class _NavegationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavegationModel>(context);

    return BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[700],
        currentIndex: navigationModel.pageActual,
        onTap: (i) => navigationModel.pageActual = i,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Public',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'For you',
          ),
        ]);
  }
}

class _Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavegationModel>(context);
    return PageView(
      controller: navigationModel.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [Tab1Page(), Tab2Page()],
    );
  }
}

class _NavegationModel with ChangeNotifier {
  int _pageActual = 0;
  final PageController _pageController = PageController();
  int get pageActual => _pageActual;
  set pageActual(int value) {
    _pageActual = value;
    _pageController.animateToPage(value,
        duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
