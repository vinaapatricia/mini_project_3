import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_project_3/bloc/auth_bloc/auth_bloc.dart';

class SignUpPages extends StatefulWidget {
  const SignUpPages({super.key});

  @override
  State<SignUpPages> createState() => _SignUpPagesState();
}

class _SignUpPagesState extends State<SignUpPages> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Register",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.grey.shade800),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.supervised_user_circle,
                size: 100,
              ),
              textField(title: "Email", controller: emailController),
              textField(title: "Password", controller: passController),
              const SizedBox(
                height: 20,
              ),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state.userData != null) {
                    Navigator.pushReplacementNamed(context, '/login');
                  } else if (state.errorMessage.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.errorMessage),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: state.isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              final email = emailController.text;
                              final pass = passController.text;
                              if (email.isNotEmpty && pass.isNotEmpty) {
                                context.read<AuthBloc>().add(
                                      AuthRegister(
                                        email: email,
                                        password: pass,
                                      ),
                                    );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade800,
                            ),
                            child: const Text("Register",
                                style: TextStyle(color: Colors.white)),
                          ),
                  );
                },
              ),
              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: BlocBuilder<AuthBloc, AuthState>(
              //     builder: (context, state) {
              //       return state.errorMessage.isNotEmpty
              //           ? Text("Error : ${state.errorMessage}")
              //           : Text(
              //               "Email: ${state.userData?.email}\nUID: ${state.userData?.uid}",
              //               textAlign: TextAlign.center,
              //             );
              //     },
              //   ),
              // ),
              const SizedBox(height: 20),
              const Text('Have an account? '),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/signin');
                },
                child: const Text(
                  "Login here",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField({
    required String title,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          labelText: title,
        ),
        controller: controller,
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }
}
