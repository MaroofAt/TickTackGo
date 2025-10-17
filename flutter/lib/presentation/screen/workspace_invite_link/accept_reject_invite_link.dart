import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pr1/business_logic/invite_link_cubit/invite_link_cubit.dart';
import 'package:pr1/business_logic/splash_cubit/splash_cubit.dart';
import 'package:pr1/core/constance/colors.dart';
import 'package:pr1/core/constance/strings.dart';
import 'package:pr1/core/functions/navigation_functions.dart';
import 'package:pr1/data/local_data/local_data.dart';
import 'package:pr1/presentation/widgets/buttons.dart';
import 'package:pr1/presentation/widgets/loading_indicator.dart';
import 'package:pr1/presentation/widgets/text.dart';

class AcceptRejectInviteLink extends StatefulWidget {
  final String inviteToken;
  const AcceptRejectInviteLink({required this.inviteToken, super.key});

  @override
  State<AcceptRejectInviteLink> createState() => _AcceptRejectInviteLinkState();
}

class _AcceptRejectInviteLinkState extends State<AcceptRejectInviteLink> {
  Future<String?> _getToken() async {
    final String? refresh = await getRefreshToken();
    return refresh;
  }

  Future<void> _refreshToken(BuildContext context) async {
    final refresh = await _getToken();
    if (refresh != null) {
      BlocProvider.of<SplashCubit>(context).refreshToken(refresh);
      BlocProvider.of<InviteLinkCubit>(context).joinWorkspace(widget.inviteToken);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyText.text1('Would you like to join the workspace?',
              textColor: white),
          Row(
            children: [
              BlocBuilder<SplashCubit, SplashState>(
                builder: (context, state) {
                  return MyButtons.primaryButton(
                    () {
                      if(state is! RefreshTokenLoadingState) {
                        _refreshToken(context);
                      }
                    },
                    Theme.of(context).primaryColor,
                    child: Center(
                      child: (state is RefreshTokenLoadingState)
                          ? LoadingIndicator.circularProgressIndicator()
                          : MyText.text1('Accept', textColor: white),
                    ),
                  );
                },
              ),
              MyButtons.primaryButton(
                () {
                  NavigationService().pushReplacement(context, splashScreenLogoPath);
                },
                Theme.of(context).primaryColor,
                child: Center(
                  child: MyText.text1('Reject', textColor: white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
