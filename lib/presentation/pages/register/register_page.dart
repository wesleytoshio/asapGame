import 'package:asap_game/di/injectable.dart';
import 'package:asap_game/presentation/pages/login/controller/login_controller.dart';
import 'package:asap_game/presentation/themes/theme_const.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../app_config.dart';
import '../../../domain/entities/user_entity.dart';
import '../../widgets/custom_annotated_region.dart';
import '../../widgets/forms/custom_reactive_textfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function(bool isLoggedIn)? onLoginResult;
  const RegisterPage({Key? key, this.onLoginResult}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<RegisterPage> {
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
      'name': FormControl<String>(validators: [
        Validators.required,
      ]),
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
      'passwordConfirmation': FormControl<String>(),
    }, validators: [
      Validators.mustMatch('password', 'passwordConfirmation'),
    ]);
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
                Text('Crie sua conta',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: Colors.grey, fontWeight: FontWeight.normal)),
                const SizedBox(height: 20),
                CustomReactiveTextField(
                  formControlName: 'name',
                  labelText: "Seu nome",
                  suffixIcon: Ionicons.person_outline,
                  onPressedSuffix: () {},
                ),
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
                const SizedBox(height: 20),
                CustomReactiveTextField(
                  formControlName: 'passwordConfirmation',
                  labelText: "Confirme seu password",
                  obscureText: !showPassword,
                  suffixIcon: showPassword
                      ? Ionicons.eye_outline
                      : Ionicons.eye_off_outline,
                  onPressedSuffix: () {},
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
                    child: const Text("Criar conta"),
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
                      text: "já tem uma conta? ",
                      children: [
                        TextSpan(
                            text: 'Entrar',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => AppConfig.instance.appRouter
                                  .replaceNamed('/login'),
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
    if (formLogin.valid) {
      await controller.signUpWithEmailAndPassword(
          user: UserEntity(
        email: formLogin.control('email').value,
        password: formLogin.control('password').value,
        name: formLogin.control('name').value,
      ));

      AppConfig.instance.appRouter.replaceNamed('/players');
    }
  }

  void submitSignInGoogle() async {
    await controller.signInWithGoogle();
    AppConfig.instance.appRouter.replaceNamed('/players');
  }
}
