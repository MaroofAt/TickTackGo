import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pr1/core/functions/api_error_handling.dart';
import 'package:pr1/core/variables/api_variables.dart';
import 'package:pr1/data/models/invitation/accept_invite_model.dart';
import 'package:pr1/data/models/invitation/invitation_search_model.dart';
import 'package:pr1/data/models/invitation/reject_invite_model.dart';
import 'package:pr1/data/models/invitation/user_invites_model.dart';

class InvitationApi {
  static Future<InvitationSearchModel> invitationSearch(String query) async {
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQ5MzYzMjMyLCJpYXQiOjE3NDkzNTk2MzIsImp0aSI6IjIzZTVhMjRlNzgyZDQzMGY4YWUxNjdlNTRkOTdmOWU2IiwidXNlcl9pZCI6MX0.kqu4l2N0-7gA_qT85WO86TC-11_4RbH4nv_OsuqQ_6w'
    };

    late InvitationSearchModel invitationSearchModel;

    try {
      var response = await dio.request(
        '/users/',
        queryParameters: {'search': query},
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        invitationSearchModel = InvitationSearchModel.onSuccess(response.data);
      } else {
        invitationSearchModel = InvitationSearchModel.onError(response.data);
      }
    } on DioException catch (e) {
      invitationSearchModel = InvitationSearchModel.error(handleDioError(e));
    }
    return invitationSearchModel;
  }

  static Future<List<dynamic>> fetchUserInvites(String token) async {
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQ5NDc4NzM1LCJpYXQiOjE3NDk0NzUxMzUsImp0aSI6IjYxYTQ5ZGQ3Njk1YTQ4YzZhMWYwNTJlMjYwMmM5MmFkIiwidXNlcl9pZCI6Mn0.Hn8ikBhFL9TXmBzFJ5R41BiQT4pjP-WZCLkyRwTmdc0',
    };

    late List<dynamic> userInvitesList;
    try {
      var response = await dio.request(
        '/users/show_invites/',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        userInvitesList = response.data
            .map((json) => UserInvitesModel.onSuccess(json))
            .toList();
      } else {
        userInvitesList = [UserInvitesModel.onError(response.data)];
      }
    } on DioException catch (e) {
      userInvitesList = [UserInvitesModel.error(handleDioError(e))];
    }
    return userInvitesList;
  }

  static Future<AcceptInviteModel> acceptInvite(
      int inviteId, String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQ5NDc4NzM1LCJpYXQiOjE3NDk0NzUxMzUsImp0aSI6IjYxYTQ5ZGQ3Njk1YTQ4YzZhMWYwNTJlMjYwMmM5MmFkIiwidXNlcl9pZCI6Mn0.Hn8ikBhFL9TXmBzFJ5R41BiQT4pjP-WZCLkyRwTmdc0'
    };
    var data = {"invite": inviteId};

    late AcceptInviteModel acceptInviteModel;
    try {
      var response = await dio.request(
        '/users/accept_invite/',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        acceptInviteModel = AcceptInviteModel.onSuccess(response.data);
      } else {
        acceptInviteModel = AcceptInviteModel.onError(response.data);
      }
    } on DioException catch (e) {
      print(e.toString());
      acceptInviteModel = AcceptInviteModel.error(handleDioError(e));
    }
    return acceptInviteModel;
  }

  static Future<RejectInviteModel> rejectInvite(
      int inviteId, String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQ5NDc4NzM1LCJpYXQiOjE3NDk0NzUxMzUsImp0aSI6IjYxYTQ5ZGQ3Njk1YTQ4YzZhMWYwNTJlMjYwMmM5MmFkIiwidXNlcl9pZCI6Mn0.Hn8ikBhFL9TXmBzFJ5R41BiQT4pjP-WZCLkyRwTmdc0'
    };

    var data = {"invite": inviteId};
    late RejectInviteModel rejectInviteModel;
    try {
      var response = await dio.request(
        '/users/reject_invite/',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        rejectInviteModel = RejectInviteModel.onSuccess(response.data);
      } else {
        rejectInviteModel = RejectInviteModel.onError(response.data);
      }
    } on DioException catch (e) {
      rejectInviteModel = RejectInviteModel.error(handleDioError(e));
    }
    return rejectInviteModel;
  }
}
