import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:utibuhealth/constants/urls.dart';
import 'package:utibuhealth/home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  _login(BuildContext context) {
    var headers = {'Content-Type': 'application/json'};
    print("error none");
    var request =
        http.Request('POST', Uri.parse('https://fmksystems.co.ke/api/login/'));
    request.body = json.encode({
      "username": _usernameController.text,
      "password": _passwordController.text,
    });

    print(request.body);
    request.headers.addAll(headers);

    request.send().then((response) {
      if (response.statusCode == 200) {
        print(response.stream.bytesToString());

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        print(response.reasonPhrase);
        print("");

        // final errorMessage = json.decode(response.body)['error'];
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text("errorMessage"),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }).catchError((error) {
      print('Error occurred: $error');
      // Handle error
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _login(context), // Use a callback function
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
