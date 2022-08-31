import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shopify/animations.dart';
import 'package:shopify/api.dart';
import 'package:shopify/controller.dart';
import 'package:shopify/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          fontFamily: "Raleway"),
      home: const Root(),
      initialBinding: AuthBinding(),
    );
  }
}

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
AuthController controller=Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Obx((){

      if(controller.isLoggedIn.value==false)
        {
          return Login();
        }
      else
        {
          read();
          return HomeScreen();
        }
    });
  }
}

void read() async{
  AuthController controller=Get.find<AuthController>();
  controller.name!=controller.storage.value.get('name').toString();
  controller.phone!= controller.storage.value.get('phone').toString();
  controller.email!= controller.storage.value.get('email').toString();
}

class Login extends StatefulWidget {
  const Login({
    Key? key,
  }) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late AssetImage image;
  bool isObscure = true;
  Color colorEmail = Color(0xFF868686);
  Color colorPassword = Color(0xFF868686);
  AuthController controller = Get.find<AuthController>();

  @override
  void initState() {
    image = AssetImage("assets/images/background.jpg");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.jpg"),
                fit: BoxFit.cover)),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, bottom: 80),
            child: FadeAnimation(
              1, Container(
                width: 314,
                height: 70,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          color: Color.fromRGBO(0, 0, 0, 0.25))
                    ]),
                child: TextButton(
                    onPressed: () {
                      showSheet(context);
                    },
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                          color: Color.fromRGBO(37, 150, 190, 1),
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    )),
              ),
            ),
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  showSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(left: 50.0, top: 36, right: 50),
            child: Form(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image(
                                  image:
                                      AssetImage("assets/images/message.png"),
                                  height: 24,
                                  width: 24,
                                  color: colorEmail,
                                ),
                                const SizedBox(
                                  width: 11,
                                ),
                                Text(
                                  "Email",
                                  style: TextStyle(
                                      color: colorEmail,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                            Flexible(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: TextFormField(
                                    controller: controller.emailController,
                                    onTap: () {
                                      setState(() {
                                        colorEmail =
                                            Color.fromRGBO(37, 150, 190, 1);
                                      });
                                    },
                                    onSaved: (value) {
                                      setState(() {
                                        colorEmail = Color(0xFF868686);
                                      });
                                    },
                                    onEditingComplete: () {
                                      setState(() {
                                        colorEmail = Color(0xFF868686);
                                      });
                                    },
                                    onFieldSubmitted: (value) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      setState(() {
                                        colorEmail = Color(0xFF868686);
                                      });
                                      setState(() {
                                        colorEmail = Color(0xFF868686);
                                      });
                                    },
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17),
                                    cursorColor:
                                        const Color.fromRGBO(37, 150, 190, 1),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image(
                                  image: AssetImage("assets/images/lock.png"),
                                  height: 24,
                                  width: 24,
                                  color: colorPassword,
                                ),
                                SizedBox(
                                  width: 11,
                                ),
                                Text(
                                  "Password",
                                  style: TextStyle(
                                      color: colorPassword,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                            Flexible(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: TextFormField(
                                    controller: controller.passwordController,
                                    obscureText: isObscure,
                                    onTap: () {
                                      setState(() {
                                        colorPassword =
                                            Color.fromRGBO(37, 150, 190, 1);
                                      });
                                    },
                                    onSaved: (value) {
                                      setState(() {
                                        colorPassword = Color(0xFF868686);
                                      });
                                    },
                                    onEditingComplete: () {
                                      setState(() {
                                        colorPassword = Color(0xFF868686);
                                      });
                                    },
                                    onFieldSubmitted: (value) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      setState(() {
                                        colorPassword = Color(0xFF868686);
                                      });
                                      setState(() {
                                        colorPassword = Color(0xFF868686);
                                      });
                                    },
                                    onChanged: (value) {},
                                    decoration: InputDecoration(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17),
                                    cursorColor:
                                        const Color.fromRGBO(37, 150, 190, 1),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 80),
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
                            onPressed: () async {
                              try {
                                await ApiRequests.login(
                                    controller.emailController.text,
                                    controller.passwordController.text).then((value) {
                                  controller.email=value['user']['email'].toString();
                                  controller.name=value['user']['name'].toString();
                                  controller.phone=value['user']['mobile_no'].toString();
                                  print("${value['user']['name']} is here");
                                  Navigator.pop(context);
                                  controller.isLoggedIn.value=true;
                                });

                              } catch (e) {
                                String message=e.toString().substring(11);
                                showDialog(
                                  context: context,
                                  builder: (context) =>  SimpleDialog(
                                    elevation: 5,
                                    backgroundColor: Colors.white,
                                    contentPadding: EdgeInsets.only(top: 30,left: 10,right: 10,bottom: 10),
                                    children: [SizedBox(height: 100,width: 100,
                                      child: Column(mainAxisAlignment:MainAxisAlignment.spaceEvenly,children: [Text(message,style: TextStyle(
                                          color: Color.fromRGBO(37, 150, 190, 1),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14),),
                                        Container(
                                          width: 70,
                                          height: 30,
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
                                                Get.back();
                                              },
                                              child: Text(
                                                "OK",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 12),
                                              )),
                                        )],),
                                    )
                                    ],
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Create account?",
                              style: TextStyle(
                                  color: Color.fromRGBO(37, 150, 190, 1),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20),
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
