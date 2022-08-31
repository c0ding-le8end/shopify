import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopify/controller.dart';

class HomeScreen extends GetWidget<AuthController> {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: Column(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [Padding(
        padding: const EdgeInsets.only(top: 60.0,left: 10,right: 10),
        child: SizedBox(child: Center(child: Text("Welcome back ${controller.name}",textAlign:TextAlign.center,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 34),))),
      ),Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, bottom: 80),
        child: Container(
          width: 314,
          height: 70,
          decoration: const BoxDecoration(
              color: Color.fromRGBO(37, 150, 190, 1),
              borderRadius: BorderRadius.all(Radius.circular(40)),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 4,
                    color: Color.fromRGBO(0, 0, 0, 0.25))
              ]),
          child: TextButton(
              onPressed: () {
controller.storage.value.remove( 'token');
controller.storage.value.remove( 'name');
controller.storage.value.remove( 'email');
controller.storage.value.remove( 'phone');
controller.isLoggedIn.value=false;

              },
              child: Text(
                "Log out",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              )),
        ),
      ),],),),
    );
  }
}
