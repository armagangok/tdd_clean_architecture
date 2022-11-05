import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/number_trivia_bloc.dart';
import '../widget/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Number Trivia"),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Builder(builder: (context) {
      return BlocProvider(
        create: (context) => getIt<NumberTriviaBloc>(),
        child: Padding(
          padding: context.lowPadding,
          child: Column(
            children: [
              height03(),
              SizedBox(
                child: BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                  bloc: getIt<NumberTriviaBloc>(),
                  builder: (context, state) {
                    if (state is Empty) {
                      return const MessageDisplay(message: "Start searching!");
                    } else if (state is Error) {
                      return MessageDisplay(message: state.message);
                    } else if (state is Loading) {
                      return const LoadingWidget();
                    } else if (state is Loaded) {
                      return TriviaDisplay(trivia: state.trivia);
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
              height03(),
              const TriviaControl(),
            ],
          ),
        ),
      );
    });
  }

  Widget height03() => Builder(
        builder: (context) {
          return SizedBox(height: context.bigHeight);
        },
      );
}

class TriviaControl extends StatefulWidget {
  const TriviaControl({Key? key}) : super(key: key);

  @override
  State<TriviaControl> createState() => _TriviaControlState();
}

class _TriviaControlState extends State<TriviaControl> {
  // String inputStr;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Input a number",
          ),
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  dispatchConcrete(context);
                },
                child: const Text("Search"),
              ),
            ),
            SizedBox(
              width: context.normalWidth,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Get Random Trivia"),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void dispatchConcrete(BuildContext context) {
    BlocProvider.of<NumberTriviaBloc>(context);
  }
}
