import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:learnify_client/login_model.dart';
import '../../helpers/dio_helper.dart';
import '../../helpers/hive_helper.dart';
import '../bottomNav/bottom_nav.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  LoginModel model = LoginModel();
  
  // Removed duplicate user variables
  String? username;
  String? emaill;

  void Register({
    required String email,
    required String phone,
    required String name,  // Consistent usage of `username`
    required String password,
  }) async {
    emit(RegisterLoadingState());
    try {
      final response = await DioHelper.postData(path: 'register', body: {
        "name": name,
        "phone": phone,
        "email": email,
        "password": password,
      });
      model = LoginModel.fromJson(response.data);
      if (model.status == true) {
        HiveHelper.setToken(model.data?.token ?? "");
        HiveHelper.setValueLoginBox();

        // Save username and email to Hive with correct keys
        username = model.data?.name;
        emaill = model.data?.email;

        var box = Hive.box('USER_BOX');
        box.put('username', username); // Save in Hive for persistence
        box.put('email', emaill); // St
        // Navigate to the BottomNav screen after successful registration
        Get.offAll(const BottomNav());

        emit(RegisterSuccessState(model.message ?? ""));
      } else {
        emit(RegisterErrorState(model.message ?? ""));
      }
    } catch (e) {
      emit(RegisterErrorState("Connection is bad!"));
    }
  }
}
