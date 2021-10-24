import 'package:flutter/material.dart';

//void main() => runApp(MyApp2),

void main() {
  runApp(const PageImage());
}

class PageImage extends StatelessWidget {
  const PageImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Hero(
      tag: "hero_example",
      child: Container(
        width: double.infinity,
        height: 400.0,
        child: const CircleAvatar(
          backgroundImage: AssetImage('images/blog-foto.png'),
          radius: 100,
        ),
        alignment: Alignment.topCenter,
      ),
    ));
  }
}
