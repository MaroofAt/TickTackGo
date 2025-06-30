import 'package:dio/dio.dart';
import 'package:pr1/core/functions/api_error_handling.dart';
import 'package:pr1/core/variables/api_variables.dart';
import 'package:pr1/data/models/projects/add_member_to_project.dart';
import 'package:pr1/data/models/projects/change_user_role_model.dart';
import 'package:pr1/data/models/projects/create_project_model.dart';
import 'package:pr1/data/models/projects/delete_project_model.dart';
import 'package:pr1/data/models/projects/fetch_projects_model.dart';
import 'package:pr1/data/models/projects/retrieve_project_model.dart';

class ProjectsApi {
  static Future<List<FetchProjectsModel>> fetchProjects(
      int projectId, String token) async {
    var headers = {'Authorization': 'Bearer $token'};

    var queryParameters = {'workspace': projectId};

    late List<FetchProjectsModel> projects;

    try {
      var response = await dio.request(
        '/projects/',
        queryParameters: queryParameters,
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        projects =
            data.map((json) => FetchProjectsModel.onSuccess(json)).toList();
      } else {
        projects = [FetchProjectsModel.onError(response.data)];
      }
    } on DioException catch (e) {
      projects = [FetchProjectsModel.error(handleDioError(e))];
    }
    return projects;
  }

  static Future<CreateProjectModel> createProject(
      String title, int workspaceId, String color, String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var data = {"title": title, "workspace": workspaceId, "color": color};

    late CreateProjectModel createProjectModel;

    try {
      var response = await dio.request(
        '/projects/',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 201) {
        createProjectModel = CreateProjectModel.onSuccess(response.data);
      } else {
        createProjectModel = CreateProjectModel.onError(response.data);
      }
    } on DioException catch (e) {
      createProjectModel = CreateProjectModel.error(handleDioError(e));
    }
    return createProjectModel;
  }

  static Future<RetrieveProjectModel> retrieveProject(
      int projectId, String token) async {
    var headers = {'Authorization': 'Bearer $token'};

    late RetrieveProjectModel retrieveProjectModel;

    try {
      var response = await dio.request(
        '/projects/$projectId/',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        retrieveProjectModel = RetrieveProjectModel.onSuccess(response.data);
      } else {
        retrieveProjectModel = RetrieveProjectModel.onError(response.data);
      }
    } on DioException catch (e) {
      retrieveProjectModel = RetrieveProjectModel.error(handleDioError(e));
    }
    return retrieveProjectModel;
  }

  static Future<AddMemberToProjectModel> addMemberToProject(
      int projectId, int userId, String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var data = {"user": userId};
    late AddMemberToProjectModel addMemberToProjectModel;

    try {
      var response = await dio.request(
        '/projects/$projectId/add_user_to_project/',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 201) {
        addMemberToProjectModel =
            AddMemberToProjectModel.onSuccess(response.data);
      } else {
        addMemberToProjectModel =
            AddMemberToProjectModel.onError(response.data);
      }
    } on DioException catch (e) {
      addMemberToProjectModel =
          AddMemberToProjectModel.error(handleDioError(e));
    }
    return addMemberToProjectModel;
  }

  static Future<ChangeUserRoleModel> changeUserRole(
      String projectId, String newRole, String userId, String token) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var data = {"user": userId, "role": newRole};
    late ChangeUserRoleModel changeUserRoleModel;

    try {
      var response = await dio.request(
        '/projects/$projectId/change_user_role/',
        options: Options(
          method: 'PATCH',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 202) {
        changeUserRoleModel = ChangeUserRoleModel.onSuccess(response.data);
      } else {
        changeUserRoleModel = ChangeUserRoleModel.onError(response.data);
      }
    } on DioException catch (e) {
      changeUserRoleModel = ChangeUserRoleModel.error(handleDioError(e));
    }
    return changeUserRoleModel;
  }

  static Future<DeleteProjectModel> deleteProject(
      int projectId, String token) async {
    var headers = {'Authorization': 'Bearer $token'};
    late DeleteProjectModel deleteProjectModel;

    try {
      var response = await dio.request(
        '/projects/$projectId/',
        options: Options(
          method: 'DELETE',
          headers: headers,
        ),
      );

      if (response.statusCode == 204) {
        deleteProjectModel = DeleteProjectModel.onSuccess();
      } else {
        deleteProjectModel = DeleteProjectModel.onError(response.data);
      }
    } on DioException catch (e) {
      deleteProjectModel = DeleteProjectModel.error(handleDioError(e));
    }
    return deleteProjectModel;
  }
}
