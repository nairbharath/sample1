import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future ForgotPass() async {
    FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Email ID"),
          TextField(
            controller: _emailController,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: '',
              labelStyle: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
          SizedBox(
            height: 60.0,
            child: Material(
              borderRadius: BorderRadius.circular(10.0),
              shadowColor: Colors.blueAccent,
              color: Colors.blue,
              elevation: 0,
              child: GestureDetector(
                onTap: () {
                  ForgotPass();
                },
                child: const Center(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
