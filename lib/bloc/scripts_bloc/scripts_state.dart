part of 'scripts_bloc.dart';

class Script {
  String id;
  String name;
  String command;
  int pin;

  Script({
    String? id,
    String? name,
    String? command,
    int? pin,
  })  : id = id ?? "0",
        name = name ?? 'Скрипт',
        command = command ?? Directory.current.path,
        pin = pin ?? 0;

  Script.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        command = json['command'],
        pin = json['pin'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'command': command,
      'pin': pin,
    };
  }
}

class ScriptsState extends Equatable {
  final List<Script> scripts;

  const ScriptsState({
    List<Script>? scripts,
  }) : scripts = scripts ?? const [];

  ScriptsState copyWith({
    List<Script>? scripts,
  }) {
    return ScriptsState(
      scripts: scripts ?? this.scripts,
    );
  }

  @override
  List<Object?> get props => [scripts];
}
