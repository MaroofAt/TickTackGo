import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

import '../../core/variables/api_variables.dart';

part 'project_state.dart';

class ProjectCubit extends Cubit<ProjectState> {
  ProjectCubit() : super(ProjectInitial());

  Future<void>creatProject(String title,String workspaceId)async{
    // emit();

    try{
      var data ={
        "title":title,
        "workspace":workspaceId
      };
      final response= await dio.post('',data: data);
      // if
      // emit
      // else
      //   emit
    }catch(e){

    }
  }
}
