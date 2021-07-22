// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:moor/moor.dart';
import 'package:moor/moor_web.dart';
import 'package:moor/remote.dart';

class Database {
  static void mains() {
    final self = html.SharedWorkerGlobalScope.instance;
    self.importScripts('sql-wasm.js');

    final db = WebDatabase.withStorage(MoorWebStorage.indexedDb('worker',
        migrateFromLocalStorage: false, inWebWorker: true));
    final server = MoorServer(DatabaseConnection.fromExecutor(db));

    self.onConnect.listen((event) {
      final msg = event as html.MessageEvent;
      server.serve(msg.ports.first.channel());
      print(msg.data.toString());
    });
  }

  static DatabaseConnection connectToWorker() {
    final worker = html.SharedWorker('worker.dart.js');

    return remote(worker.port.channel());
  }
}
