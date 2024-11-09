
import 'package:flutter/material.dart';
import 'package:move_app/main.dart';
import 'package:move_app/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  GlobalKey<FormState> fromkey = GlobalKey<FormState>();
  TextEditingController usertext = TextEditingController();
  TextEditingController passtext = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: fromkey,
            child: Column(
              children: [
                   const SizedBox(
                  height: 86,
                ),
                const Text("Log in Secreen ",style: TextStyle(fontSize: 25),),
                const SizedBox(
                  height: 52,
                ),
                SizedBox(
                  width: 400,
                  child: TextFormField(
                    controller: usertext,
                    decoration: const InputDecoration(
                      hintText: "user name",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("email can not be empty");
                      }
                      if (!value.contains("@") || !value.contains(".")) {
                        return ("email must have @ and .");
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: 400,
                  child: TextFormField(

                    controller: passtext,
                    decoration: const InputDecoration(
                      hintText: "Password",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("email can not be empty");
                      }
                      if (value.length > 8) {
                        return ("must be more than 8 char");
                      }
                      return null;
                    },
                  ),
                ),
                   const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (fromkey.currentState!.validate()) {
                        Provider.of<AuthenticationProvider>(context, listen: false)
                            .login(usertext.text, passtext.text)
                            .then(
                          (value) {
                            if (value) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ScreenRote()),
                                  (route) => false);
                            }
                          },
                        );
                      }
                    },
                    child: const Text("Log in", style: TextStyle()))
              ],
            ),
          ),
        ),
      ),
    );
  }
}