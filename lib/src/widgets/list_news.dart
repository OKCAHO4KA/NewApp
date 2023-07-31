import 'package:flutter/material.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:newsapp/src/theme/theme.dart';

class ListNews extends StatelessWidget {
  const ListNews(this.noticias, {super.key});
  final List<Article>? noticias;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: noticias!.length,
        itemBuilder: (BuildContext context, int index) {
          return _Noticia(
            noticia: noticias![index],
            index: index,
          );
        });
  }
}

class _Noticia extends StatelessWidget {
  final Article noticia;
  final int index;

  const _Noticia({required this.noticia, required this.index});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TarjetaTopBar(
          noticia: noticia,
          index: index,
        ),
        _TarjetaTitulo(noticia: noticia),
        _TarjetaImagen(noticia: noticia),
        _TarjetaBody(noticia: noticia),
        _TarjetaBotones(),
        const SizedBox(
          height: 10,
        ),
        const Divider()
      ],
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  const _TarjetaTopBar({
    required this.noticia,
    required this.index,
  });
  final Article noticia;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(children: [
        Text('${index + 1}. ',
            style: TextStyle(
              fontSize: 14,
              color: myTheme.cardColor,
            )),
        Text('${noticia.source!.name}. ', style: const TextStyle(fontSize: 14))
      ]),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {
  final Article noticia;

  const _TarjetaTitulo({required this.noticia});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(noticia.title!,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  final Article noticia;

  const _TarjetaImagen({required this.noticia});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Container(
            child: (noticia.urlToImage != null)
                ? FadeInImage(
                    image: NetworkImage(noticia.urlToImage),
                    placeholder: const AssetImage('assets/giphy.gif'))
                : const Image(image: AssetImage('assets/no-image.png'))),
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {
  final Article noticia;

  const _TarjetaBody({required this.noticia});
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          (noticia.description != null) ? noticia.description : '',
        ));
  }
}

class _TarjetaBotones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RawMaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            fillColor: Colors.black12,
            onPressed: () {},
            child: const Icon(Icons.star_border, color: Colors.teal)),
        RawMaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            fillColor: Colors.black12,
            onPressed: () {},
            child: const Icon(Icons.more_horiz_outlined, color: Colors.teal))
      ],
    );
  }
}
