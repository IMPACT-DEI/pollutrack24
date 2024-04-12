import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 4),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
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
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
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
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).pop();
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
