import 'package:flutter/material.dart';
import 'package:news_application/modules/app/root.dart';
import 'package:news_application/modules/authentication/register_view.dart';
import 'package:news_application/modules/user/user_provider.dart';
import 'package:news_application/utils/validator/text_field_validator.dart';
import 'package:news_application/widgets/background.dart';
import 'package:news_application/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Background(
        child: userProvider.screenLoadingState
            ? const Center(
                child: SizedBox(
                  height: 100,
                  child: ScreenProgressIndicator(),
                ),
              )
            : Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            fontSize: 36),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        controller: _emailController,
                        validator: TextFieldValidator.emailFieldValidator,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(labelText: "Email"),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        controller: _passwordController,
                        validator: TextFieldValidator.passwordFieldValidator,
                        obscureText: true,
                        decoration:
                            const InputDecoration(labelText: "Password"),
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      child: ElevatedButton(
                        onPressed: () async {
                          final isValidate =
                              _formKey.currentState?.validate() ?? false;
                          if (isValidate) {
                            final isSuccess = await userProvider.loginUser(
                              context,
                              username: _emailController.text,
                              password: _passwordController.text,
                            );
                            if (isSuccess) {
                              // 
                              Navigator.pushReplacementNamed(
                                  context, Root.routeName);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          // textColor: Colors.white,
                          padding: const EdgeInsets.all(0),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          width: size.width * 0.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80.0),
                            gradient: LinearGradient(colors: [
                              Theme.of(context).primaryColor,
                              Theme.of(context).primaryColor.withAlpha(150)
                            ]),
                          ),
                          padding: const EdgeInsets.all(0),
                          child: const Text(
                            "LOGIN",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 10),
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterView(),
                            ),
                          )
                        },
                        child: const Text(
                          "Don't Have an Account? Sign up",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2661FA)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
