import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopify/controller.dart';

class ApiRequests
{
  static Future login(String email,String password)
  async{
    AuthController controller=Get.find<AuthController>();
    print(email);
    print(password);

http.Response response= await http.post(Uri.parse("https://ecommerce-calculator.herokuapp.com/api/MPC/login"),body: {
  "email":email,"password":password
});
    var map=json.decode(response.body);
if(map['message']!='loggedIn')
  {
    throw Exception(map['message']);
  }
SharedPreferences storage=await SharedPreferences.getInstance();
storage.setString('token',response.headers['X-Auth'].toString());
    storage.setString('email',map['email'].toString());
    storage.setString('name',  map['name'].toString());
    storage.setString('phone', map['phone'].toString());
return jsonDecode(response.body);
  }
}