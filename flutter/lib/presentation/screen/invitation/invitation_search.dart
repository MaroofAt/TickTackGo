import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/invitation_cubit/invitation_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/constance.dart';
import 'package:pr1/presentation/widgets/buttons.dart';
import 'package:pr1/presentation/widgets/gesture_detector.dart';
import 'package:pr1/presentation/widgets/loading_indicator.dart';
import 'package:pr1/presentation/widgets/text.dart';
import 'package:pr1/presentation/widgets/text_field.dart';

class InvitationSearch extends StatefulWidget {
  const InvitationSearch({super.key});

  @override
  State<InvitationSearch> createState() => _InvitationSearchState();
}

class _InvitationSearchState extends State<InvitationSearch> {
  List<String> _searchResults = [];

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MyTextField.textField(
                context,
                _controller,
                onChanged: (query) => BlocProvider.of<InvitationCubit>(context)
                    .invitationSearch(query),
                textColor: Colors.white,
                hint: "Search...",
                prefixIcon: const Icon(Icons.search, color: Colors.white),
              ),
            ),
            BlocConsumer<InvitationCubit, InvitationState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is SearchSuccessState) {
                  print(state.invitationSearchModel);
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.invitationSearchModel.count,
                      itemBuilder: (context, index) {
                        return Container(
                          width: width(context) * 0.9,
                          height: height(context) * 0.08,
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            border: Border.all(color: ampleOrange),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText.text1(
                                state.invitationSearchModel.results[index]
                                    .username,
                                textColor: Colors.white,
                              ),
                              MyGestureDetector.gestureDetector(
                                onTap: () {
                                },
                                child: Container(
                                  height: height(context) * 0.04,
                                  width: width(context) * 0.25,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Center(
                                    child: MyText.text1(
                                      'invite',
                                      textColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      fontSize: 18,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is SearchLoadingState) {
                  return Center(
                    child: LoadingIndicator.circularProgressIndicator(),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
