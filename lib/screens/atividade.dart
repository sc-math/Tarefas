import 'package:flutter/material.dart';

class tarefa extends StatelessWidget {
  const tarefa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.check_circle_outline),
        title: const Text('Flutter: Primeiros Passos'),
      ),
      body: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Quadrados(Color.fromARGB(255, 0, 255, 0), false),
              Quadrados(Color.fromARGB(255, 255, 127, 0), false),
              Quadrados(Color.fromARGB(255, 255, 70, 0), false),
              Quadrados(Color.fromARGB(255, 186, 0, 255), false),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Quadrados(Color.fromARGB(255, 254, 179, 0), true),
              Quadrados(Color.fromARGB(255, 255, 0, 0), true),
              Quadrados(Color.fromARGB(255, 0, 121, 0), true),
              Quadrados(Color.fromARGB(255, 115, 8, 165), true),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Quadrados(Color.fromARGB(255, 0, 174, 174), false),
              Quadrados(Color.fromARGB(255, 204, 0, 175), false),
              Quadrados(Color.fromARGB(255, 0, 0, 255), false),
              Quadrados(Color.fromARGB(255, 255, 255, 0), false),
            ],
          ),
        ],
      ),
    );
  }
}

class Quadrados extends StatelessWidget {
  final Color cor;
  final bool isImg;

  const Quadrados(this.cor, this.isImg, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: cor,
            border: Border.all(
                style: BorderStyle.solid, color: Colors.black, width: 4)),
        width: 90,
        height: 120,
        child: isImg
            ? const Icon(Icons.people)
            : const Icon(
          Icons.people,
          size: 0,
        )
    );
  }
}
