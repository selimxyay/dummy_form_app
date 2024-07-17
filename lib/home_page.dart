// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  // when submit button is pressed, this method will be executed
  void _submitForm() {
    // if all validators return true, save the input values
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(
          "Username: ${_nameController.text}, User Age: ${_ageController.text}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Test App")),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextFormField(
              // instead of textfield
              controller: _nameController,
              maxLength: 50,
              decoration: const InputDecoration(
                  label: Text("Name"),
                  contentPadding: EdgeInsets.symmetric(horizontal: 6)),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value.trim().length <= 1 ||
                    value.trim().length > 50) {
                  return 'Please enter a valid input!';
                }
                return null;
              },
              onSaved: (newValue) {
                _nameController.text = newValue!;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 6),
                label: Text("Age"),
              ),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    int.tryParse(value) == null ||
                    int.tryParse(value)! <= 0) {
                  return "Must be a valid, positive number!";
                }
                return null;
              },
              onSaved: (newValue) {
                _ageController.text = newValue!;
              },
            ),
            const SizedBox(height: 32),
            DropdownButtonFormField(
              focusColor: Colors.transparent,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 6)),
              value: 1,
              items: const [
                DropdownMenuItem(value: 1, child: Text("Item 1")),
                DropdownMenuItem(value: 2, child: Text("Item 2")),
                DropdownMenuItem(value: 3, child: Text("Item 3")),
              ],
              onChanged: (value) {},
            ),
            const SizedBox(height: 40),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              OutlinedButton(
                  onPressed: () => _formKey.currentState!.reset(),
                  child: const Text("Clear")),
              const SizedBox(width: 8),
              ElevatedButton(
                  onPressed: _submitForm, child: const Text("Submit")),
            ]),
            const SizedBox(height: 40),
            
          ]),
        ),
      ),
    );
  }
}
