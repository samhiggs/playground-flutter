import 'package:flutter/material.dart';
import 'package:startup_generator/theme.dart';

class EmptyListInd extends StatelessWidget {
  final String title;
  final String? buttonText;
  final IconData buttonIcon;
  final Function? onButtonPressed;

  const EmptyListInd({
    Key? key,
    required this.title,
    this.buttonText,
    this.buttonIcon = Icons.add,
    this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasButton = buttonText != null && onButtonPressed != null;

    return Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(Icons.no_food),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(title, style: ThemeText.heading6),
      ),
      if (hasButton)
        ElevatedButton.icon(
            onPressed: () {
              onButtonPressed!();
            },
            icon: Icon(buttonIcon),
            label: Text(buttonText!)),
    ]);
  }
}
