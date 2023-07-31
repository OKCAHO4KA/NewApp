import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/services/news_service.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  const Tab2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [_ListaCategorias()]),
      ),
    );
  }
}

class _ListaCategorias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categorias = Provider.of<NewsService>(context).categories;

    return SizedBox(
      width: double.infinity,
      height: 90,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: categorias.length,
          itemBuilder: (BuildContext context, int index) {
            final cName = categorias[index].name;

            return SizedBox(
                child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(children: [
                _CategoryButton(categoria: categorias[index]),
                const SizedBox(
                  height: 5,
                ),
                Text('${cName[0].toUpperCase()}${cName.substring(1)}')
              ]),
            ));
          }),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category categoria;
  const _CategoryButton({
    required this.categoria,
  });

  @override
  Widget build(BuildContext context) {
    final provi = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        final provi = Provider.of<NewsService>(context, listen: false);
        provi.selectedCategory = categoria.name;
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        width: 40,
        height: 40,
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(
          categoria.icon,
          color: categoria.name == provi.selectedCategory
              ? Colors.red
              : Colors.black54,
        ),
      ),
    );
  }
}
