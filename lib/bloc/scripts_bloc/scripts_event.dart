part of 'scripts_bloc.dart';

@immutable
sealed class ScriptsEvent {}

class ScriptsInitEvent extends ScriptsEvent {}

class ScriptsAddEvent extends ScriptsEvent {}

class ScriptsSetNameEvent extends ScriptsEvent {
  final String id;
  final String name;

  ScriptsSetNameEvent(
    this.id,
    this.name,
  );
}

class ScriptsSetPathEvent extends ScriptsEvent {
  final String id;
  final String command;

  ScriptsSetPathEvent(
    this.id,
    this.command,
  );
}

class ScriptsSetPinEvent extends ScriptsEvent {
  final String id;
  final int pin;

  ScriptsSetPinEvent(
    this.id,
    this.pin,
  );
}

class ScriptsRemoveEvent extends ScriptsEvent {
  final String id;

  ScriptsRemoveEvent(
    this.id,
  );
}
