import 'package:flutter/material.dart';
import 'package:pollutrack24/screens/home.dart';
import 'package:pollutrack24/services/purpleair.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiKeyOnboarding extends StatefulWidget {
  ApiKeyOnboarding({super.key});

  @override
  State<ApiKeyOnboarding> createState() => _ApiKeyState();
}

class _ApiKeyState extends State<ApiKeyOnboarding> {
  final TextEditingController apiKeyController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final PurpleAir purpleAir = PurpleAir();

  @override
  @override
  void initState() {
    super.initState();
  }

  // method to check if the key is correct
  Future<int> _contactPurpleAir(String apiKey, BuildContext context) async {
    int logged = await purpleAir.getAuth(apiKey);
    return logged;
  }

  // Method for navigation SplashPage -> HomePage
  void _toHomePage(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => const Home()));
  } //_toHomePage

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 4),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Api Key',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                  "API keys are required to interact with the PurpleAir API",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 8.0),
                child: TextFormField(
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'API Key is required';
                    }
                    return null;
                  },
                  controller: apiKeyController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    prefixIcon: const Icon(
                      Icons.key,
                    ),
                    hintText: 'API Key',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      int validation = await _contactPurpleAir(
                          apiKeyController.text, context);
                      // if not valid show a message
                      if (validation != 201) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(8),
                          content: Text('Wrong API Key'),
                          duration: Duration(seconds: 2),
                        ));
                      } else {
                        final sp = await SharedPreferences.getInstance();
                        await sp.setString(
                            'apiKey', apiKeyController.text.toString());
                        // else move to home
                        Future.delayed(const Duration(seconds: 3),
                            () => _toHomePage(context));
                      }
                    }
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(
                              horizontal: 80, vertical: 12)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFF384242))),
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
