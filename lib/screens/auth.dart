import 'dart:io';

import 'package:chat_app/widgets/user_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();

  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPass = '';
  var _enteredUserName = '';
  File? _selectedImage;
  var _isAuthenticating = false;
  var _imageUrl = '';

  void _submit() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid || !_isLogin && _selectedImage == null) {
      return;
    }

    _formKey.currentState!.save();

    try {
      setState(() {
        _isAuthenticating = true;
      });
      if (_isLogin) {
        final userCredential = await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPass);
        print('User credential: $userCredential');
      } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPass);
        print('User credential: $userCredentials');

        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${userCredentials.user!.uid}.jpg');

        await storageRef.putFile(_selectedImage!);
        final imageUrl = await storageRef.getDownloadURL();

        Map<String, dynamic> usersData = <String, dynamic>{
          'username': _enteredUserName,
          'email': _enteredEmail,
          'image_url': imageUrl
        };
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set(usersData);
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        // error for email already in use
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.message! ?? 'Authentication failed!',
          ),
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiaryFixed,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                width: 150,
                child: Image.asset(
                  'assets/images/chat.png',
                ),
              ),
              Card(
                color: Theme.of(context).colorScheme.surface,
                elevation: 8.0,
                margin: EdgeInsets.all(
                  20,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(
                      16,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!_isLogin)
                            UserImagePicker(
                              onPickedImage: (pickedImage) {
                                _selectedImage = pickedImage;
                              },
                            ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email address',
                              labelStyle: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                            ),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (emailValue) {
                              if (emailValue == null ||
                                  emailValue.trim().isEmpty ||
                                  !emailValue.contains('@')) {
                                return 'Please enter a valid email address.';
                              }
                              return null;
                            },
                            onSaved: (emailValue) {
                              _enteredEmail = emailValue!;
                            },
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          if (!_isLogin)
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Username',
                                labelStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                              enableSuggestions: false,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.trim().length < 4) {
                                  return 'Please enter a valid username atleast 4 characters';
                                }
                                return null;
                              },
                              onSaved: (userNameValue) {
                                _enteredUserName = userNameValue!;
                              },
                            ),
                          SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                            ),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                            obscureText: true,
                            validator: (passValue) {
                              if (passValue == null ||
                                  passValue.trim().length < 6) {
                                return 'Password must be at least 6 character long.';
                              }
                              return null;
                            },
                            onSaved: (passValue) {
                              _enteredPass = passValue!;
                            },
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          if (_isAuthenticating) CircularProgressIndicator(),
                          if (!_isAuthenticating)
                            ElevatedButton(
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.onSurface,
                                minimumSize: Size(
                                  200,
                                  50,
                                ),
                              ),
                              child: Text(
                                _isLogin ? 'Login' : 'Sign up',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .tertiaryFixed,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          SizedBox(
                            height: 8,
                          ),
                          if (!_isAuthenticating)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
                              child: Text(
                                _isLogin
                                    ? 'Create an account'
                                    : 'I already have an account.',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .tertiaryContainer),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
