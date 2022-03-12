import 'package:bloc/bloc.dart';
import 'package:eshopapp/models/login_model/loginmodel.dart';
import 'package:eshopapp/modules/login/cubit/states.dart';
import 'package:eshopapp/shared/network/remote/dio_helper.dart';
import 'package:eshopapp/shared/network/remote/end_points.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit( ) : super(ShopLoginInitialState());

  static ShopLoginCubit get(context)=>BlocProvider.of(context);
  late ShopLoginModel shopLoginModel;
  void userLogin({
  required String email,
    required String password
}){
    emit(ShopLoginLoadingState());
   DioHelper.postData(url: '$LOGIN', data:{
     'email':email,
     'password':password
   },).then((value) {
     shopLoginModel=ShopLoginModel.fromJson(value.data);
    // print(shopLoginModel.data?.name);
     emit(ShopLoginSuccessState(shopLoginModel));
   }).catchError((onError){
     print(onError);
     emit(ShopLoginErrorState(onError.toString()));
   });
  }

  IconData suffix=Icons.visibility_outlined;
  bool isPasswordShown=true;
  void changeVisibility(){
    isPasswordShown=!isPasswordShown;
    suffix=isPasswordShown==true?Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityState());
  }

}