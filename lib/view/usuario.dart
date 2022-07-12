import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Usuario extends StatelessWidget {
  Future<List<Map<String, Object?>>> buscarDados() async {
    String caminho = join(await getDatabasesPath(), 'banco.db');
    Database banco = await openDatabase(
      caminho,
      version: 2,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE usuario(
            id INT PRIMARY KEY,
            nome TEXT NOT NULL,
            cpf TEXT NOT NULL
          )
        ''');
        db.execute(
            'INSERT INTO usuario(nome,cpf) VALUES ("José","123.456.789-12")');
        db.execute(
            'INSERT INTO usuario(nome,cpf) VALUES ("Arlindo","963.852.741-98")');
      },
    );

    List<Map<String, Object?>> lista =
        await banco.rawQuery('SELECT * FROM usuario');
    return lista;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuarios'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/formularioUsuario');
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: buscarDados(),
        builder:
            (context, AsyncSnapshot<List<Map<String, Object?>>> dadosFuturo) {
          if (!dadosFuturo.hasData) return CircularProgressIndicator();
          var listaUsuario = dadosFuturo.data!;
          return ListView.builder(
            itemCount: listaUsuario.length,
            itemBuilder: (context, itenLista) {
              var tarefa = listaUsuario[itenLista];
              return ListTile(
                title: Text(tarefa['nome'].toString()),
                subtitle: Text(tarefa['cpf'].toString()),
              );
            },
          );
        },
      ),
    );

    //flutter clean
    // flutter pub get
  }
}
