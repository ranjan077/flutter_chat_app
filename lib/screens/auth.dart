import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() {
    return _AuthScreen();
  }
}

class _AuthScreen extends State<AuthScreen> {
  bool _isLogin = true;
  final _formKey = GlobalKey<FormState>();

  String _enteredEmail = '';
  String _enteredPassword = ''

  void _submit() {
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 30, bottom: 20, left: 20, right: 20),
                width: 200,
                child: Image.asset('assets/images/chat.png'),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                  label: Text('Email address')),
                              onSaved: (value) {
                                _enteredEmail = value!;
                              },
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !value.contains('@')) {
                                  return 'Please enter valid email address.';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                               onSaved: (value) {
                                _enteredPassword = value!;
                              },
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    value.trim().length < 6) {
                                  return 'Password must be at least 6 letters long.';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  label: Text('Password')),
                              obscureText: true,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            ElevatedButton(
                                onPressed: _submit,
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer),
                                child: _isLogin
                                    ? const Text('Login')
                                    : const Text('Sign up')),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    _isLogin = !_isLogin;
                                  });
                                },
                                child: Text(_isLogin
                                    ? 'Create an account'
                                    : 'I have already have account. Login')),
                          ],
                        )),
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
