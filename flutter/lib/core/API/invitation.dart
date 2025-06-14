import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pr1/core/functions/api_error_handling.dart';
import 'package:pr1/core/variables/api_variables.dart';
import 'package:pr1/data/models/invitation/accept_invite_model.dart';
import 'package:pr1/data/models/invitation/invitation_search_model.dart';
import 'package:pr1/data/models/invitation/reject_invite_model.dart';
import 'package:pr1/data/models/invitation/send_invite_model.dart';
import 'package:pr1/data/models/invitation/user_invites_model.dart';

class InvitationApi {
  static Future<InvitationSearchModel> invitationSearch(String query) async {
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQ5ODIzMTY2LCJpYXQiOjE3NDk4MTk1NjYsImp0aSI6IjQ1NjE5MTIwMTdmYjRjYTQ4ODc4Yzg4NTJmMWUwODMxIiwidXNlcl9pZCI6MX0.e2uSWvp1a-Y503CaOQzvzJqNU21lDbIkRkfScAX91C0'
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
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQ5ODI1NzExLCJpYXQiOjE3NDk4MjIxMTEsImp0aSI6IjBkNzRiYmYzYmEwNjQyMDU4ODMzZjY4MTg2NzBiNzZjIiwidXNlcl9pZCI6NX0.szn0HrpzlZkZswiGvz0UGzPdttQX_g1O_J9Sl7UMet0',
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
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQ5ODI1NzExLCJpYXQiOjE3NDk4MjIxMTEsImp0aSI6IjBkNzRiYmYzYmEwNjQyMDU4ODMzZjY4MTg2NzBiNzZjIiwidXNlcl9pZCI6NX0.szn0HrpzlZkZswiGvz0UGzPdttQX_g1O_J9Sl7UMet0'
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

      if (response.statusCode == 201) {
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
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQ5ODI1NzExLCJpYXQiOjE3NDk4MjIxMTEsImp0aSI6IjBkNzRiYmYzYmEwNjQyMDU4ODMzZjY4MTg2NzBiNzZjIiwidXNlcl9pZCI6NX0.szn0HrpzlZkZswiGvz0UGzPdttQX_g1O_J9Sl7UMet0'
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

      if (response.statusCode == 202) {
        rejectInviteModel = RejectInviteModel.onSuccess();
      } else {

        rejectInviteModel = RejectInviteModel.onError(response.data);
      }
    } on DioException catch (e) {
      rejectInviteModel = RejectInviteModel.error(handleDioError(e));
    }
    return rejectInviteModel;
  }

  static Future<SendInviteModel> sendInvite(int senderId, int receiverId, int workspaceId) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQ5ODIzMTY2LCJpYXQiOjE3NDk4MTk1NjYsImp0aSI6IjQ1NjE5MTIwMTdmYjRjYTQ4ODc4Yzg4NTJmMWUwODMxIiwidXNlcl9pZCI6MX0.e2uSWvp1a-Y503CaOQzvzJqNU21lDbIkRkfScAX91C0'
    };
    var data = {
      "sender": senderId,
      "receiver": receiverId,
      "workspace": workspaceId,
      "status": "pending"
    };

    late SendInviteModel sendInviteModel;

    try {
      var response = await dio.request(
        '/workspaces/$senderId/invite_user/',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 201) {
        sendInviteModel = SendInviteModel.onSuccess(response.data);
      } else {
        sendInviteModel = SendInviteModel.onError(response.data);
      }
    } on DioException catch (e) {
      sendInviteModel = SendInviteModel.error(handleDioError(e));
    }
    return sendInviteModel;
  }
}
