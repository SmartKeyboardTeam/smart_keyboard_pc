import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_keyboard_pc/bloc/scripts_bloc/scripts_bloc.dart';
import 'package:smart_keyboard_pc/screens/home/script_card/script_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Script> scripts =
        context.select((ScriptsBloc bloc) => bloc.state.scripts);

    return Scaffold(
      body: Row(
        children: [
          const Expanded(
            child: Image(
              height: double.infinity,
              image: AssetImage('assets/img/keyboard.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Flexible(
                  flex: 0,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 14,
                      ),
                      Text(
                        "Скрипты",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                const Divider(
                  height: 1,
                  indent: 14,
                  endIndent: 14,
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      ...scripts
                          .map<Widget>((e) => ScriptCard(id: e.id))
                          .toList(),
                      TextButton(
                        onPressed: () {
                          context.read<ScriptsBloc>().add(ScriptsAddEvent());
                        },
                        child: const Text(
                          "+",
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
