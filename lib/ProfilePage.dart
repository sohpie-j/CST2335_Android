import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfilePage extends StatefulWidget {
  final String username;

  const ProfilePage({super.key, required this.username});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  late TextEditingController _controllerFName;
  late TextEditingController _controllerLName;
  late TextEditingController _controllerPNumber;
  late TextEditingController _controllerEAddress;

  @override
  void initState() {
    super.initState();
    _controllerFName = TextEditingController();
    _controllerLName = TextEditingController();
    _controllerPNumber = TextEditingController();
    _controllerEAddress = TextEditingController();

    _loadData(); // Load saved data from secure storage when the page opens
  }

  Future<void> _loadData() async {
    _controllerFName.text = await storage.read(key: 'firstName') ?? '';
    _controllerLName.text = await storage.read(key: 'lastName') ?? '';
    _controllerPNumber.text = await storage.read(key: 'phoneNumber') ?? '';
    _controllerEAddress.text = await storage.read(key: 'email') ?? '';
  }

  Future<void> _saveData() async {
    await storage.write(key: 'firstName', value: _controllerFName.text);
    await storage.write(key: 'lastName', value: _controllerLName.text);
    await storage.write(key: 'phoneNumber', value: _controllerPNumber.text);
    await storage.write(key: 'email', value: _controllerEAddress.text);
  }

  @override
  void dispose() {
    _saveData(); // Save data before the page is destroyed
    _controllerFName.dispose();
    _controllerLName.dispose();
    _controllerPNumber.dispose();
    _controllerEAddress.dispose();
    super.dispose();
  }

  // Launch Phone Dialer
  void _launchDialer(String phoneNumber) async {
    final Uri dialerUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(dialerUri)) {
      await launchUrl(dialerUri);
    } else {
      _showAlertDialog("Phone dialer not supported on this device.");
    }
  }

  // Launch SMS Application
  void _launchSMS(String phoneNumber) async {
    final Uri smsUri = Uri(scheme: 'sms', path: phoneNumber);
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      _showAlertDialog("SMS not supported on this device.");
    }
  }

  // Launch Email Application
  void _launchEmail(String emailAddress) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      _showAlertDialog("Email not supported on this device.");
    }
  }

  // Show AlertDialog if a URL scheme is not supported
  void _showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Welcome Back, User!')),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Welcome Back, ${widget.username}!",
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            // First Name Field
            TextField(
              controller: _controllerFName,
              decoration: const InputDecoration(
                labelText: "First Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Last Name Field
            TextField(
              controller: _controllerLName,
              decoration: const InputDecoration(
                labelText: "Last Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Phone Number Field with buttons for Phone and SMS
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _controllerPNumber,
                    decoration: const InputDecoration(
                      labelText: "Phone Number",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    _launchDialer(_controllerPNumber.text);
                  },
                  child: const Icon(Icons.phone),
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  onPressed: () {
                    _launchSMS(_controllerPNumber.text);
                  },
                  child: const Icon(Icons.message),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Email Address Field with Mail Button
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _controllerEAddress,
                    decoration: const InputDecoration(
                      labelText: "Email Address",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    _launchEmail(_controllerEAddress.text);
                  },
                  child: const Icon(Icons.email),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
