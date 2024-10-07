import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Login Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final dynamic title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _nameController; // Controller for name input
  late TextEditingController _passwordController; // Controller for password input

  final String correctPassword = "password123"; // Define a correct password

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Function to navigate to ProfilePage
  void _navigateToProfilePage(String name) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(username: name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Login Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Login Page',
              style: TextStyle(fontSize: 30),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: "Enter your name",
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _passwordController,
                obscureText: true, // Hide the password input
                decoration: const InputDecoration(
                  hintText: "Enter your password",
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                var enteredName = _nameController.text;
                var enteredPassword = _passwordController.text;

                // Check if the password is correct
                if (enteredPassword == correctPassword) {
                  // Navigate to ProfilePage with the entered name
                  _navigateToProfilePage(enteredName);
                } else {
                  // Show an error message if the password is incorrect
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Incorrect password!"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final String username; // Accept the username from the previous page

  const ProfilePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    // Show a SnackBar welcoming the user
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Welcome Back, $username!')),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page"),
      ),
      body: Center(
        child: Text(
          "Welcome back, $username!",
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
