import 'package:flutter/cupertino.dart';

import '../../data/models/auth/sign_up_model.dart';
import '../../data/models/user/user.dart';

SignUpModel? globalSignUpModel;
String token = '';
String refresh = '';
String? FCMuserToken;
String? deviceType;
User? user ;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
