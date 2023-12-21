import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

part 'scripts_event.dart';
part 'scripts_state.dart';

Future setScripts(List<Script> scripts) async {
  var prefs = await SharedPreferences.getInstance();
  prefs.setString('scripts', jsonEncode(scripts));
}

Future<List<Script>> getScripts() async {
  var prefs = await SharedPreferences.getInstance();
  // await prefs.clear();
  var scripts =
      (jsonDecode(prefs.getString('scripts') ?? "[]") as List<dynamic>)
          .map((e) => Script.fromJson(e))
          .toList();

  return scripts;
}

Future writeScriptsToFile(String scripts) async {
  final File file = File('${Directory.current.path}/scripts.txt');
  await file.writeAsString(scripts);
}

Future saveScripts(List<Script> scripts) async {
  await setScripts(scripts);
  await writeScriptsToFile(jsonEncode(scripts));
}

class ScriptsBloc extends Bloc<ScriptsEvent, ScriptsState> {
  ScriptsBloc() : super(const ScriptsState()) {
    on<ScriptsInitEvent>((event, emit) async {
      var scripts = await getScripts();
      emit(state.copyWith(
        scripts: scripts,
      ));
    });
    on<ScriptsAddEvent>((event, emit) {
      var scripts = [...state.scripts, Script(id: const Uuid().v4())];
      emit(state.copyWith(
        scripts: scripts,
      ));
      saveScripts(scripts);
    });
    on<ScriptsSetNameEvent>((event, emit) async {
      var scripts = [...state.scripts];
      scripts[scripts.indexWhere((script) => script.id == event.id)].name =
          event.name;
      emit(state.copyWith(
        scripts: scripts,
      ));
      saveScripts(scripts);
    });
    on<ScriptsSetPathEvent>((event, emit) async {
      var scripts = [...state.scripts];
      scripts[scripts.indexWhere((script) => script.id == event.id)].command =
          event.command;
      emit(state.copyWith(
        scripts: scripts,
      ));
      saveScripts(scripts);
    });
    on<ScriptsSetPinEvent>((event, emit) async {
      var scripts = [...state.scripts];
      scripts[scripts.indexWhere((script) => script.id == event.id)].pin =
          event.pin;
      emit(state.copyWith(
        scripts: scripts,
      ));
      saveScripts(scripts);
    });
    on<ScriptsRemoveEvent>((event, emit) async {
      var scripts = [...state.scripts];
      scripts.removeAt(scripts.indexWhere((script) => script.id == event.id));
      emit(state.copyWith(
        scripts: scripts,
      ));
      saveScripts(scripts);
    });
  }
}
