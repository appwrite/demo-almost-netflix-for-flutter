//
// onboarding.dart
// appflix
// 
// Author: wess (me@wess.io)
// Created: 01/03/2022
// 
// Copywrite (c) 2022 Wess.io
//

import 'package:netflix_clone/providers/account.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {

 const  OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  Widget _renderSignIn() {
    return Container(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              TextField(
                controller: _emailController,
                autofocus: true,
                autocorrect: false,
                enableSuggestions: false,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.grey,
                  labelText: 'Email address',
                  floatingLabelStyle: TextStyle(color: Colors.black),
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 20.0),
               TextField(
                controller: _passwordController,
                obscureText: true,
                autofocus: false,
                autocorrect: false,
                enableSuggestions: false,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.grey,
                  labelText: 'Password',
                  floatingLabelStyle: TextStyle(color: Colors.black),
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 20.0),
              MaterialButton(
                child: const Text(
                  "Sign in",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0
                  ),
                ),
                onPressed: () async {
                  final api = context.read<AccountProvider>();
                  final email = _emailController.text;
                  final password = _passwordController.text;

                  if (email.isEmpty || password.isEmpty) {
                    showDialog(context: context, builder: (_) => AlertDialog(
                      title: const Text('Error'),
                      content: const Text('Please enter your email and password'),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () => Navigator.of(context).pop(),
                        )
                      ],
                    ));

                    return;
                  }
                  
                  await api.login(email, password);

                },
              ),
              const SizedBox(height: 10.0),
              MaterialButton(
                child: const Text(
                  "Forgot your password?",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
              ),
              const SizedBox(height: 40.0),
              MaterialButton(
                child: const Text(
                  "Don't have an account? Sign up",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
              ),
            ],
        ),
      );
  }
  
  Widget _renderSignUp() {
    return Container(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              TextField(
                controller: _nameController,
                autofocus: true,
                autocorrect: false,
                enableSuggestions: false,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.grey,
                  labelText: 'Your name',
                  floatingLabelStyle: TextStyle(color: Colors.black),
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _emailController,
                autofocus: true,
                autocorrect: false,
                enableSuggestions: false,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.grey,
                  labelText: 'Email address',
                  floatingLabelStyle: TextStyle(color: Colors.black),
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 20.0),
               TextField(
                controller: _passwordController,
                obscureText: true,
                autofocus: false,
                autocorrect: false,
                enableSuggestions: false,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.grey,
                  labelText: 'Password',
                  floatingLabelStyle: TextStyle(color: Colors.black),
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 20.0),
              MaterialButton(
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0
                  ),
                ),
                onPressed: () async {
                  final api = context.read<AccountProvider>();
                  final name = _nameController.text;
                  final email = _emailController.text;
                  final password = _passwordController.text;

                  if (email.isEmpty || password.isEmpty) {
                    showDialog(context: context, builder: (_) => AlertDialog(
                      title: const Text('Error'),
                      content: const Text('Please enter your email and password'),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () => Navigator.of(context).pop(),
                        )
                      ],
                    ));

                    return;
                  }
                  
                  await api.register(email, password, name);

                },
              ),
              const SizedBox(height: 10.0),
              MaterialButton(
                child: const Text(
                  "Forgot your password?",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
              ),
              const SizedBox(height: 40.0),
              MaterialButton(
                child: const Text(
                  "Already have an account? Sign in",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
              ),
            ],
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    final current = context.watch<AccountProvider>().current;

    _emailController.text = current?.email ?? "";

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 70.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: const Text(
            'Almost Netflix',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _renderSignIn(),
          _renderSignUp(),
        ],
      )
    );
  }
}


