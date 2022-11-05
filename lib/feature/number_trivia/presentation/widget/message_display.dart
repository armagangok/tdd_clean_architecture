import 'package:flutter/material.dart';
import 'package:tdd_clean_architecture/core/extension/context_extension.dart';

class MessageDisplay extends StatelessWidget {
  final String message;
  const MessageDisplay({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height(0.3),
      child: Center(
        child: SingleChildScrollView(
          child: Text(
            message,
            style: context.textTheme.headline4,
          ),
        ),
      ),
    );
  }
}
