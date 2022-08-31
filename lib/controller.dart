
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AuthController extends GetxController
{
  TextEditingController emailController=TextEditingController(text: "");
  TextEditingController passwordController=TextEditingController(text: "");
  late Rx<SharedPreferences> storage;
  RxBool isLoggedIn=RxBool(false);
  String name="";
  String email="";
  String phone="";
  @override
  void onInit() async{
    storage= Rx<SharedPreferences>(await SharedPreferences.getInstance());
    String? value=storage.value.get('token')?.toString();
    if(value!=null)
    {
      print("here");
      print(value);
      isLoggedIn.value=true;
    }
    print("i am here $value");
    super.onInit();
  }

}

class AuthBinding extends Bindings
{
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
    // TODO: implement dependencies
  }

}