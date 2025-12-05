import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:learnify_client/helpers/dio_helper.dart';
import 'package:learnify_client/helpers/hive_helper.dart';
import 'package:learnify_client/register_model.dart';
import 'package:learnify_client/screens/bottomNav/bottom_nav.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  RegisterModel? registerModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    emit(RegisterLoadingState());

    try {
      final response = await DioHelper.postData(
        path: 'register',
        body: {
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
        },
      );

      if (response.data is! Map<String, dynamic>) {
        emit(RegisterErrorState("Server Error: Invalid response format"));
        return;
      }
      registerModel = RegisterModel.fromJson(response.data);

      if (registerModel?.status == true) {
        // Save token and data on success
        HiveHelper.setToken(registerModel?.data?.token ?? "");
        HiveHelper.setValueLoginBox();

        var box = Hive.box('USER_BOX');
        box.put('username', registerModel?.data?.name);
        box.put('email', registerModel?.data?.email);
        box.put('phone', registerModel?.data?.phone);

        Get.offAll(() => const BottomNav());

        emit(RegisterSuccessState(
            registerModel?.message ?? "Register Successful"));
      } else {
        // If error (e.g., email already exists)
        emit(RegisterErrorState(registerModel?.message ?? "Register Failed"));
      }
    } catch (e) {
      print("Register Error: ${e.toString()}");
      emit(RegisterErrorState(e.toString()));
    }
  }
}
