import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/components/difficulty.dart';
import 'package:nosso_primeiro_projeto/data/task_dao.dart';

class Task extends StatefulWidget {
  final String name;
  final String photo;
  final int difficulty;

  int level;

  Task(
      {required this.name,
      required this.photo,
      required this.difficulty,
      required this.level,
      Key? key})
      : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool assetOrNetwork() {
    if (widget.photo.contains('http')) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.indigo,
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: .1,
                  blurRadius: 15,
                  offset: Offset(0, 7),
                )
              ],
            ),
          ),
          Column(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.black26,
                      ),
                      width: 72,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: assetOrNetwork()
                            ? Image.asset(
                                widget.photo,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                widget.photo,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 200,
                            child: Text(
                              widget.name,
                              style: const TextStyle(
                                  fontSize: 24,
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.black),
                            )),
                        Difficulty(
                          difficultyLevel: widget.difficulty,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: SizedBox(
                        height: 60,
                        width: 90,
                        child: ElevatedButton(
                          style: const ButtonStyle(
                              elevation: MaterialStatePropertyAll(3),
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.indigo)),
                          onLongPress: () {
                            showDialog<void>(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Deletar Tarefa?'),
                                  content: Text(
                                      'Você tem certeza que deseja deletar a tarefa ${widget.name}?'),
                                  actions: [
                                    TextButton(
                                      child: const Text('Não'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Sim'),
                                      onPressed: () {
                                        TaskDao().delete(widget.name);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text('Tarefa Deletada!'),
                                          ),
                                        );
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                  elevation: 24,
                                  surfaceTintColor: Colors.white,
                                  shadowColor: Colors.black,
                                );
                              },
                            );
                          },
                          onPressed: () {
                            setState(
                              () {
                                widget.level++;
                                TaskDao().updateLevel(
                                  Task(
                                      name: widget.name,
                                      photo: widget.photo,
                                      difficulty: widget.difficulty,
                                      level: widget.level),
                                );
                              },
                            );
                            //print(nivel);
                          },
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_drop_up,
                                size: 30,
                                color: Colors.white,
                              ),
                              Text(
                                'Lvl Up',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.white30,
                        color: Colors.white,
                        value: widget.difficulty > 0
                            ? (widget.level / widget.difficulty) / 10
                            : 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Nivel: ${widget.level}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
