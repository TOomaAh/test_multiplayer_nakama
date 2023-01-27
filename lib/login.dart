// flutter widget for nakama login and registration
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nakama/nakama.dart';
import 'package:multiplayer/game.dart';
import 'package:multiplayer/nakama.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // text field state
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => _email = val);
                },
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
                validator: (val) =>
                    val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => _password = val);
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                //color: Colors.pink[400],
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    dynamic result = await _login(_email, _password);
                    if (result == null) {
                      print('Could not sign in with those credentials');
                    } else {
                      print('Signed in');
                      print(result);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GameWidget<MultiplayerGame>(
                            game: MultiplayerGame(),
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
              SizedBox(height: 12.0),
              const Text(
                'or',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 12.0),
              ElevatedButton(
                //color: Colors.pink[400],
                child: const Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    dynamic result = await _register(_email, _password);
                    if (result == null) {
                      print('Could not register with those credentials');
                    } else {
                      print('Registered');
                      print(result);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GameWidget<MultiplayerGame>(
                            game: MultiplayerGame(),
                          ),
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // login function
  Future _login(String email, String password) async {
    try {
      Session session = await Nakama().client.authenticateEmail(
            email: email,
            password: password,
          );
      return session;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register function
  Future _register(String email, String password) async {
    try {
      Session session = await Nakama().client.authenticateEmail(
            email: email,
            password: password,
            create: true,
          );
      return session;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
