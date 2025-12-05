import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:learnify_client/helpers/dio_helper.dart';
import 'package:learnify_client/helpers/hive_helper.dart';
import 'package:learnify_client/login_model.dart';
import 'package:learnify_client/screens/bottomNav/bottom_nav.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  LoginModel? model; // Nullable to avoid init issues

  void login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());

    try {
      final response = await DioHelper.postData(
        path: 'login',
        body: {
          "email": email,
          "password": password,
        },
      );

      if (response.data is! Map<String, dynamic>) {
        emit(LoginErorrState("Server Error: Invalid response format"));
        return;
      }
      // Convert JSON to Model
      model = LoginModel.fromJson(response.data);

      if (model?.status == true) {
        // 1. Save Token and Data
        HiveHelper.setToken(model?.data?.token ?? "");
        HiveHelper.setValueLoginBox();

        // 2. Save User Data
        var box = Hive.box('USER_BOX');
        box.put('username', model?.data?.name);
        box.put('email', model?.data?.email);
        box.put('phone', model?.data?.phone);

        // 3. Navigate to Home
        Get.offAll(() => const BottomNav());

        emit(LoginSuccessState(model?.message ?? "Login Successful"));
      } else {
        // If status is false (Wrong password/email)
        emit(LoginErorrState(model?.message ?? "Something went wrong"));
      }
    } catch (e) {
      // Print actual error
      print("Login Error: ${e.toString()}");
      emit(LoginErorrState(e.toString()));
    }
  }
}
