import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pollutrack24/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInfoOnboarding extends StatefulWidget {
  const PersonalInfoOnboarding({super.key});

  @override
  State<PersonalInfoOnboarding> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfoOnboarding> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  int? bs;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1970, 1),
        lastDate: DateTime(2024, 12));
    if (picked != null && picked != selectedDate) {
      dateController.text = picked.toString();
    }
  }

  // Method for navigation SplashPage -> HomePage
  void _toHomePage(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => const Home()));
  } //_toHomePage

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color(0xFFFFFFFF),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 2, right: 8),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    const Text(
                      '2',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF384242)),
                    ),
                    Text(
                      '/2',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF384242).withOpacity(0.5)),
                    )
                  ],
                ),
                const ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: LinearProgressIndicator(
                    value: 2 / 2,
                    color: Color(0xFF326f5e),
                    backgroundColor: Color(0xFFedf1f1),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Personal Info',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text("Info about you for a tailored experience",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black45,
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 8.0),
                  child: TextFormField(
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                    controller: nameController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      border: const OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      prefixIcon: const Icon(
                        Icons.person,
                      ),
                      hintText: 'Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 8.0),
                  child: TextFormField(
                    onTap: () {
                      _selectDate(context);
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Date of Birth is required';
                      }
                      return null;
                    },
                    controller: dateController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      border: const OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      prefixIcon: const Icon(
                        Icons.calendar_month,
                      ),
                      hintText: 'Date of Birth',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 8.0),
                  child: DropdownButtonFormField(
                    value: bs,
                    validator: (value) {
                      if (value == null) {
                        return 'Biological Sex is required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    hint: Row(children: [
                      Icon(MdiIcons.genderMaleFemale),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("Biological Sex")
                    ]),
                    items: const [
                      DropdownMenuItem(
                        value: 0,
                        child: Text("Male"),
                      ),
                      DropdownMenuItem(
                        value: 1,
                        child: Text("Female"),
                      )
                    ],
                    onChanged: (value) {
                      bs = value ?? bs;
                    },
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Back')),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final sp = await SharedPreferences.getInstance();
                          await sp.setString('bs', bs.toString());
                          await sp.setString(
                              'dob', dateController.text.toString());
                          await sp.setString(
                              'name', nameController.text.toString());
                          Future.delayed(const Duration(seconds: 3),
                              () => _toHomePage(context));
                        }
                      },
                      style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  const EdgeInsets.symmetric(
                                      horizontal: 80, vertical: 12)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF384242))),
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
