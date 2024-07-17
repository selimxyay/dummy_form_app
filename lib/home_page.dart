import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    if (_formKey.currentState!.validate()) { // checks if all validators return true
      _formKey.currentState!.save(); // saves all the input values
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextFormField(
              controller: _nameController,
              maxLength: 50,
              decoration: const InputDecoration(
                  label: Text("Name"),
                  contentPadding: EdgeInsets.symmetric(horizontal: 6)),
              validator: (value) {
                if (value == null || value.isEmpty || value.trim().length <= 1 || value.trim().length > 50) {
                  return 'Please enter a valid input!';
                }
                return null; // this means user input value has passed all the criterias and validator can return true
              },
              onSaved: (newValue) {
                _nameController.text = newValue!; // it will never return null because it's checked above
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 6),
                label: Text("Age"),
              ),
              validator: (value) {
                if (value == null || value.isEmpty || int.tryParse(value) == null || int.tryParse(value)! <= 0) {
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
              Expanded(
                child: OutlinedButton(
                    onPressed: () => _formKey.currentState!.reset(),
                    child: const Text("Clear")),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                    onPressed: _submitForm, child: const Text("Submit")),
              ),
            ]),
            const SizedBox(height: 40),
          ]),
        ),
      ),
    );
  }
}
