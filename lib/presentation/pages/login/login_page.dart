import 'package:animate_do/animate_do.dart';
import 'package:asap_game/di/injectable.dart';
import 'package:asap_game/presentation/pages/login/controller/login_controller.dart';
import 'package:asap_game/presentation/themes/theme_const.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../app_config.dart';
import '../../../domain/entities/user_entity.dart';
import '../../widgets/forms/custom_reactive_textfield.dart';

class LoginPage extends StatefulWidget {
  final void Function(bool isLoggedIn)? onLoginResult;
  const LoginPage({Key? key, this.onLoginResult}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<LoginPage> {
  late FormGroup formLogin;
  final LoginController controller = getIt<LoginController>();
  bool showPassword = false;

  @override
  void dispose() {
    formLogin.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    formLogin = FormGroup({
      'email': FormControl<String>(validators: [
        Validators.required,
        Validators.email,
      ]),
      'password': FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(6),
        ],
      ),
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ReactiveForm(
              formGroup: formLogin,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(height: kToolbarHeight * 2.5),
                    Text.rich(
                      TextSpan(
                        text: 'Asap',
                        children: [
                          TextSpan(
                              text: 'Game',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(primaryColor),
                                letterSpacing: 0,
                              )),
                        ],
                      ),
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            letterSpacing: -3,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                        'Explore milhares de desafios divertidos e multiplayer',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.grey, fontWeight: FontWeight.normal)),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            formLogin.value = {
                              'email': 'wesley@wesleydev.com',
                              'password': '123456',
                            };
                          },
                          child: Text('Login with Wesley'),
                        ),
                        TextButton(
                          onPressed: () {
                            formLogin.value = {
                              'email': 'soraia@gmail.com',
                              'password': '111111',
                            };
                          },
                          child: Text('Login with Soraia'),
                        ),
                      ],
                    ),
                    CustomReactiveTextField(
                      formControlName: 'email',
                      labelText: "Email address",
                      suffixIcon: Ionicons.mail_outline,
                      onPressedSuffix: () {},
                    ),
                    const SizedBox(height: 20),
                    CustomReactiveTextField(
                      formControlName: 'password',
                      labelText: "Password",
                      obscureText: !showPassword,
                      suffixIcon: showPassword
                          ? Ionicons.eye_outline
                          : Ionicons.eye_off_outline,
                      onPressedSuffix: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text("Redefina sua senha"),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ReactiveFormConsumer(builder: (context, snapshot, child) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                              double.infinity,
                              50,
                            ),
                            elevation: 0,
                            textStyle: TextStyle(fontSize: 16),
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        onPressed: snapshot.valid ? submitSignIn : null,
                        child: const Text("Acessar conta"),
                      );
                    }),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(
                          double.infinity,
                          50,
                        ),
                        elevation: 0,
                        textStyle: const TextStyle(fontSize: 16),
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        primary: Colors.black87,
                      ),
                      onPressed: submitSignInGoogle,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/providers/google_g_icon.svg',
                            width: 22,
                          ),
                          const SizedBox(width: 10),
                          Center(child: Text("Continuar com Google")),
                          Icon(
                            Ionicons.logo_google,
                            color: Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: Text.rich(
                        TextSpan(
                          text: "Não tem uma conta? ",
                          children: [
                            TextSpan(
                                text: 'Criar conta',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => AppConfig.instance.appRouter
                                      .replaceNamed('/register'),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Observer(builder: (_) {
              if (controller.isLoading) {
                return FadeIn(
                  child: Container(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(.4),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ),
                );
              }
              return SizedBox.shrink();
            })
          ],
        ),
      ),
    );
    // snackBarError(
    //                   msg: "invalid email", scaffoldState: _scaffoldGlobalKey);
  }

  void submitSignIn() async {
    await controller.signInWithEmailAndPassword(
        user: UserEntity(
      email: formLogin.control('email').value?.trim(),
      password: formLogin.control('password').value?.trim(),
    ));
  }

  void submitSignInGoogle() async {
    await controller.signInWithGoogle();
  }
}
