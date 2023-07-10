import 'package:flutter/material.dart';
import 'package:mynelayan/models/user.dart';
import 'package:mynelayan/views/screens/shared/loginscreen.dart';
import 'package:mynelayan/views/screens/shared/registrationscreen.dart';

// for profile screen

class ProfileTabScreen extends StatefulWidget {
  final User user;

  const ProfileTabScreen({super.key, required this.user});

  @override
  State<ProfileTabScreen> createState() => _ProfileTabScreenState();
}

class _ProfileTabScreenState extends State<ProfileTabScreen> {
  late List<Widget> tabchildren;
  String maintitle = "Profile";
  late double screenHeight, screenWidth, cardwitdh;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(maintitle),
      ),
      body: Center(
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: screenHeight * 0.25,
            width: screenWidth,
            child: Card(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  margin: const EdgeInsets.all(4),
                  width: screenWidth * 0.4,
                  child: Image.asset(
                    "assets/images/profile.png",
                  ),
                ),
                Expanded(
                    flex: 6,
                    child: Column(
                      children: [
                        widget.user.name.toString() == "na"
                            ? const Column(
                                children: [
                                  Text(
                                    "Not Available",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  Divider(),
                                  Text("Not Available"),
                                  Text("Not Available"),
                                  Text("Not Available"),
                                ],
                              )
                            : Column(
                                children: [
                                  Text(
                                    widget.user.name.toString(),
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                  const Divider(),
                                  Text(widget.user.email.toString()),
                                  Text(widget.user.phone.toString()),
                                  Text(widget.user.datereg.toString()),
                                ],
                              )
                      ],
                    )),
              ]),
            ),
          ),
          Container(
            width: screenWidth,
            alignment: Alignment.center,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
              child: Text("PROFILE SETTINGS",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary,
                  )),
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              MaterialButton(
                onPressed: () {},
                child: const Text("CHANGE NAME"),
              ),
              const Divider(),
              MaterialButton(
                onPressed: () {},
                child: const Text("CHANGE PHONE"),
              ),
              const Divider(),
              MaterialButton(
                onPressed: () {},
                child: const Text("CHANGE PASSWORD"),
              ),
              const Divider(),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (content) => const LoginScreen()));
                },
                child: const Text("LOGIN"),
              ),
              const Divider(),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (content) => const RegistrationScreen()));
                },
                child: const Text("REGISTRATION"),
              ),
              const Divider(),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (content) => const LoginScreen()));
                },
                child: const Text("LOGOUT"),
              ),
            ],
          ))
        ]),
      ),
    );
  }
}
