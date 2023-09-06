import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:true_heart_app/domain/repository/questions_repository.dart';
import 'package:true_heart_app/presentation/pages/home_page/cubit/home_cubit.dart';

import '../../../app_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return BlocProvider(
      create: (context) => HomeCubit(context.read<QuestionsRepository>(), user.id),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text('True Heart'),
            actions: [
              IconButton(
                key: const Key('homePage_logout_iconButton'),
                icon: const Icon(Icons.exit_to_app),
                onPressed: () {
                  context.read<AppBloc>().add(const AppLogoutRequested());
                },
              )
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 4),
                    Text(user.email ?? '', style: textTheme.titleLarge),
                    const SizedBox(height: 4),
                    Text(user.name ?? '', style: textTheme.headlineSmall!),
                    const SizedBox(height: 12),
                    state.status == HomeStatus.loading
                        ? const CircularProgressIndicator()
                        : state.status == HomeStatus.error
                            ? Text(
                                state.errorMessage!,
                                style: textTheme.titleLarge,
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  state.questions[state.questionIndex].text,
                                  style: textTheme.titleLarge!
                                      .copyWith(color: state.isAnswered ? Colors.grey.withOpacity(0.5) : Colors.black),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                    const SizedBox(height: 4),
                    Ink(
                      decoration: const ShapeDecoration(
                        color: Colors.lightBlue,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        onPressed: () => context.read<HomeCubit>().onChangeQuestion(),
                        icon: const Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                AnimatedCrossFade(
                  crossFadeState: state.isAnswerMode ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  firstChild: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(onPressed: () {}, child: const Text('Другие ответы')),
                        ElevatedButton(
                            onPressed: () => context.read<HomeCubit>().onAnswerDialogButtonPressed(),
                            child: const Text('Ответить на вопрос')),
                      ],
                    ),
                  ),
                  secondChild: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Ink(
                              decoration: ShapeDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                shape: const CircleBorder(),
                              ),
                              child: IconButton(
                                  onPressed: () => context.read<HomeCubit>().onAnswerDialogButtonUnpressed(),
                                  icon: const Icon(Icons.close)),
                            ),
                          ),
                          const SizedBox(height: 4),
                          TextField(
                            controller: context.read<HomeCubit>().answerTextController,
                            onChanged: context.read<HomeCubit>().onAnswerTextChanged,
                            decoration:
                                InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
                            keyboardType: TextInputType.multiline,
                            minLines: 3,
                            maxLines: 5,
                          ),
                          const SizedBox(height: 4),
                          ElevatedButton(
                              onPressed: () {
                                context
                                    .read<HomeCubit>()
                                    .onSendAnswerPressed(
                                        user.id, state.questions[state.questionIndex].id, state.answerText)
                                    .then((value) => context.read<HomeCubit>().answerTextController.clear())
                                    .onError((error, stackTrace) => null);
                              },
                              child: const Text('Отправить'))
                        ],
                      )),
                  duration: const Duration(milliseconds: 300),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
