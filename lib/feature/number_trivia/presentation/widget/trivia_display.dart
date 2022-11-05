import 'package:flutter/widgets.dart';

import '../../../../core/extension/context_extension.dart';
import '../../domain/entities/number_trivia.dart';

class TriviaDisplay extends StatelessWidget {
  final NumberTrivia trivia;
  const TriviaDisplay({
    Key? key,
    required this.trivia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height(0.3),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "${trivia.number}",
                style: context.textTheme.headline4,
              ),
              Text(
                trivia.text,
                style: context.textTheme.headline5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
