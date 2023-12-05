import 'package:demo_2/config/game_config.dart';
import 'package:demo_2/modules/func/bloc/counter/counter_bloc.dart';
import 'package:demo_2/modules/func/bloc/success/success_bloc.dart';
import 'package:demo_2/utils/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Layout extends StatelessWidget {
  const Layout({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
        elevation: 1.0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Listeners
            MultiBlocListener(
              listeners: [
                BlocListener<CounterBloc, CounterState>(
                  listener: (context, state) {
                    if (state is CounterInitial) {
                      if (state.match) {
                        BlocProvider.of<SuccessBloc>(context)
                            .add(SuccessCallEvent());
                        CustomSnackbar.pushSnackbar(context, "Congratulations");
                      }
                    }
                  },
                ),
                BlocListener<SuccessBloc, SuccessState>(
                  listenWhen: (previous, current) {
                    if (previous is SuccessInitial &&
                        current is SuccessInitial) {
                      return previous.successCounter != 0;
                    } else {
                      return true;
                    }
                  },
                  listener: (context, state) {
                    if (state is SuccessInitial && state.successCounter == 0) {
                      CustomSnackbar.pushSnackbar(context, "Game is now reset");
                    }
                  },
                ),
              ],
              child: const SizedBox.shrink(),
            ),

            // Message Banner
            Flexible(
              child: BlocBuilder<SuccessBloc, SuccessState>(
                builder: (context, state) {
                  if (state is SuccessInitial) {
                    return Container(
                      margin: const EdgeInsets.all(8.0).copyWith(bottom: 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: state.successCounter == 0
                            ? Colors.grey
                            : Colors.green,
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _getMessage(state.successCounter),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
            Flexible(
              child: Row(
                children: [
                  // generator
                  Flexible(
                    child: BlocBuilder<SuccessBloc, SuccessState>(
                      builder: (context, state) {
                        if (state is SuccessInitial) {
                          return GestureDetector(
                            onTap: () {
                              if (state.successCounter >=
                                  GameConfig.winningScore) {
                                // ask to reset
                                CustomSnackbar.pushSnackbar(
                                  context,
                                  'You already won the game.\nPlease reset it to continue',
                                  error: true,
                                );
                              } else {
                                // generate random number
                                BlocProvider.of<CounterBloc>(context)
                                    .add(GenerateRandomNumber());
                              }
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.all(8.0).copyWith(right: 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: state.successCounter >=
                                        GameConfig.winningScore
                                    ? Colors.grey
                                    : Colors.blueAccent,
                              ),
                              child: Center(
                                child: Text(
                                  "Play",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),

                  // spacing
                  const SizedBox(width: 8.0),

                  // generated number
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.all(8.0).copyWith(left: 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.blueAccent,
                      ),
                      child: Center(
                        child: BlocBuilder<CounterBloc, CounterState>(
                          builder: (context, state) {
                            if (state is CounterInitial &&
                                state.randomNumber != null) {
                              return Text(
                                state.randomNumber!.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<SuccessBloc, SuccessState>(
        builder: (context, state) {
          if (state is SuccessInitial &&
              state.successCounter >= GameConfig.winningScore) {
            return FloatingActionButton(
              onPressed: () {
                BlocProvider.of<SuccessBloc>(context).add(ResetCallEvent());
              },
              child: const Icon(Icons.restore),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  String _getMessage(int successCounter) {
    if (successCounter == 0) {
      return "Try your Luck";
    } else if (successCounter < GameConfig.winningScore) {
      return 'You have $successCounter wins!';
    } else {
      return 'Congratulations! You won the game!';
    }
  }
}
