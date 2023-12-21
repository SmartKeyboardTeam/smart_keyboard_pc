import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_keyboard_pc/bloc/scripts_bloc/scripts_bloc.dart';

const double fieldHeight = 30;
const double inputTextSize = 12;

class ScriptCard extends StatelessWidget {
  final String id;

  ScriptCard({
    super.key,
    required this.id,
  });

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _commandController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<Script> scripts =
        context.select((ScriptsBloc bloc) => bloc.state.scripts);
    final script = scripts.firstWhere((element) => element.id == id);

    _nameController.text = script.name;
    _commandController.text = script.command;
    _pinController.text = script.pin.toString();

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: fieldHeight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            controller: _nameController,
                            onChanged: (String name) {
                              context
                                  .read<ScriptsBloc>()
                                  .add(ScriptsSetNameEvent(id, name));
                            },
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            decoration: const InputDecoration(isDense: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        context.read<ScriptsBloc>().add(ScriptsRemoveEvent(id));
                      },
                      child: const Text("—"))
                ],
              ),
              Row(
                children: [
                  const Flexible(
                    flex: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: fieldHeight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Команда",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: fieldHeight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Кнопка",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: fieldHeight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextField(
                                controller: _commandController,
                                onChanged: (String command) {
                                  context
                                      .read<ScriptsBloc>()
                                      .add(ScriptsSetPathEvent(id, command));
                                },
                                style: const TextStyle(fontSize: inputTextSize),
                                decoration:
                                    const InputDecoration(isDense: true),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: fieldHeight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextField(
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                controller: _pinController,
                                onChanged: (String pin) {
                                  var num = (pin == "") ? 0 : int.parse(pin);
                                  _pinController.text = num.toString();
                                  context
                                      .read<ScriptsBloc>()
                                      .add(ScriptsSetPinEvent(id, num));
                                },
                                style: const TextStyle(fontSize: inputTextSize),
                                decoration:
                                    const InputDecoration(isDense: true),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(height: 8)
            ],
          ),
        ),
      ],
    );
  }
}
