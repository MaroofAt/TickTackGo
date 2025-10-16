import 'package:dio/dio.dart';
import 'package:pr1/core/functions/api_error_handling.dart';
import 'package:pr1/core/variables/api_variables.dart';
import 'package:pr1/data/models/invite_link/create_invite_link.dart';
import 'package:pr1/data/models/invite_link/get_invite_link.dart';

class InviteLink {
  static Future<GetInviteLinkModel> getInviteLInk(
      int workspaceId, String token) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    late GetInviteLinkModel getInviteLinkModel;

    try {
      var response = await dio.request(
        '/workspaces/$workspaceId/get_workspace_invitation_link/',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        getInviteLinkModel = GetInviteLinkModel.onSuccess(response.data);
      } else {
        getInviteLinkModel = GetInviteLinkModel.onError(response.data);
      }
    } on DioException catch (e) {
      getInviteLinkModel = GetInviteLinkModel.error(handleDioError(e));
    }
    return getInviteLinkModel;
  }

  static Future<CreateInviteLinkModel> createInviteLink(
      int workspaceId, String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var data = {"workspace": workspaceId};

    late CreateInviteLinkModel createInviteLinkModel;

    try {
      var response = await dio.request(
        '/workspaces/create_invitation_link/',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        createInviteLinkModel = CreateInviteLinkModel.onSuccess(response.data);
      } else {
        createInviteLinkModel = CreateInviteLinkModel.onError(response.data);
      }
    } on DioException catch (e) {
      createInviteLinkModel = CreateInviteLinkModel.error(handleDioError(e));
    }
    return createInviteLinkModel;
  }
}
