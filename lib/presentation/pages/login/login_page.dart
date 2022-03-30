import 'package:asap_game/di/injectable.dart';
import 'package:asap_game/presentation/app/app_controller.dart';
import 'package:asap_game/presentation/pages/login/controller/login_controller.dart';
import 'package:asap_game/presentation/themes/theme_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../app_config.dart';
import '../../../domain/entities/user_entity.dart';
import '../../widgets/custom_annotated_region.dart';

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
    return CustomAnnotationRegion(
      child: Scaffold(
        body: ReactiveForm(
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
                          )),
                    ],
                  ),
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                ),
                const SizedBox(height: 10),
                Text('Explore milhares de desafios divertidos e multiplayer',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: Colors.grey, fontWeight: FontWeight.normal)),
                const SizedBox(height: 20),
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
                      )),
                  onPressed: submitSignInGoogle,
                  child: Row(
                    children: [
                      Icon(Ionicons.logo_google),
                      Expanded(
                        flex: 5,
                        child: Center(child: Text("Continuar com Google")),
                      ),
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
                              ..onTap = () => print('criar conta'),
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
      ),
    );
    // snackBarError(
    //                   msg: "invalid email", scaffoldState: _scaffoldGlobalKey);
  }

  void submitSignIn() async {
    await controller.signInWithEmailAndPassword(
        user: UserEntity(
      email: formLogin.control('email').value,
      password: formLogin.control('password').value,
    ));

    AppConfig.instance.appRouter.replaceNamed('/players');
  }

  void submitSignInGoogle() async {
    getIt<AppController>().setThemeData(ThemeData.light());
    // await controller.signInWithGoogle();
    // AppConfig.instance.appRouter.replaceNamed('/players');
  }
}

class CustomReactiveTextField extends StatefulWidget {
  final String? formControlName;
  final String? labelText;
  final bool obscureText;
  final void Function()? onPressedSuffix;
  final IconData? suffixIcon;
  const CustomReactiveTextField({
    Key? key,
    this.formControlName,
    this.obscureText = false,
    this.labelText,
    this.onPressedSuffix,
    this.suffixIcon,
  }) : super(key: key);

  @override
  State<CustomReactiveTextField> createState() =>
      _CustomReactiveTextFieldState();
}

class _CustomReactiveTextFieldState extends State<CustomReactiveTextField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField(
      key: widget.key,
      formControlName: widget.formControlName,
      obscureText: widget.obscureText,
      obscuringCharacter: "*",
      decoration: InputDecoration(
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(14),
        //   borderSide: const BorderSide(
        //     color: Color(primaryColor),
        //   ),
        // ),
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(14),
        //   borderSide: const BorderSide(
        //     color: Color(primaryColor),
        //     width: 2,
        //   ),
        // ),
        // filled: true,
        // fillColor: Colors.white,
        floatingLabelStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 22,
        ),
        labelText: widget.labelText,

        suffixIcon: IconButton(
          onPressed: widget.onPressedSuffix,
          splashRadius: 25,
          icon: Icon(widget.suffixIcon),
        ),
      ),
    );
  }
}
