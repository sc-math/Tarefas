import 'package:nosso_primeiro_projeto/components/task.dart';
import 'package:nosso_primeiro_projeto/data/database.dart';
import 'package:nosso_primeiro_projeto/screens/atividade.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  //Variavéis
  static const String _tablename = 'taskTable';
  static const String _name = 'nome';
  static const String _difficulty = 'dificuldade';
  static const String _image = 'imagem';
  static const String _level = 'level';

  //Tabela
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_difficulty INTEGER, '
      '$_image TEXT,'
      '$_level INTEGER)';

  save(Task tarefa) async {
    print('Acessando o save: ');

    final Database db = await getDatabase();

    var itemExists = await find(tarefa.name);
    Map<String, dynamic> taskMap = toMap(tarefa);

    if (itemExists.isEmpty) {
      print('A tarefa não existia.');

      return await db.insert(_tablename, taskMap);
    } else {
      print('A tarefa já existia');

      return await db.update(
        _tablename,
        taskMap,
        where: '$_name = ?',
        whereArgs: [tarefa.name],
      );
    }
  }

  updateLevel(Task task) async {
    final Database db = await getDatabase();

    var itemExists = await find(task.name);
    Map<String, dynamic> taskMap = toMap(task);

    if (itemExists.isEmpty) {
      return;
    } else {
      return await db.update(
        _tablename,
        taskMap,
        where: '$_name = ?',
        whereArgs: [task.name],
      );
    }
  }

  Future<List<Task>> findAll() async {
    print('Acessando o findAll: ');

    final Database db = await getDatabase();

    final List<Map<String, dynamic>> result = await db.query(_tablename);

    print('Procurando dados no banco de dados... encontrado: $result');

    return toList(result);
  }

  Future<List<Task>> find(String nomeDaTarefa) async {
    print('Acessando find:');

    final Database db = await getDatabase();

    final List<Map<String, dynamic>> result = await db
        .query(_tablename, where: '$_name = ?', whereArgs: [nomeDaTarefa]);

    print('Tarefa encontrada: ${toList(result)}');

    return toList(result);
  }

  delete(String nomeDaTarefa) async {
    print('Deletando uma Tarefa: $nomeDaTarefa');

    final Database db = await getDatabase();

    return db.delete(
      _tablename,
      where: '$_name = ?',
      whereArgs: [nomeDaTarefa],
    );
  }

  List<Task> toList(List<Map<String, dynamic>> taskMap) {
    print('Convertendo to List:');

    final List<Task> taskList = [];

    for (Map<String, dynamic> row in taskMap) {
      final Task task = Task(
          name: row[_name],
          photo: row[_image],
          difficulty: row[_difficulty],
          level: row[_level]);
      taskList.add(task);
    }

    print('Lista de Tarefas $taskList');

    return taskList;
  }

  Map<String, dynamic> toMap(Task task) {
    print('Convertendo to Map:');

    final Map<String, dynamic> taskMap = Map();

    taskMap[_name] = task.name;
    taskMap[_difficulty] = task.difficulty;
    taskMap[_image] = task.photo;
    taskMap[_level] = task.level;

    print('Mapa de Tarefas: $taskMap');

    return taskMap;
  }
}
