import 'package:flutter/material.dart';
import 'package:story_flakes/data/element_field.dart';

class FieldEditingPage extends StatefulWidget {
  final ElementField elementField;

  const FieldEditingPage({super.key, required this.elementField});

  @override
  State<FieldEditingPage> createState() => _FieldEditingPageState();
}

class _FieldEditingPageState extends State<FieldEditingPage> {
  @override
  Widget build(BuildContext context) {
    ElementField elementField = widget.elementField;
    String name = elementField.name;
    String description = elementField.description;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, false);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit"),
          actions: [
            IconButton(
              onPressed: () {
                elementField.name = name;
                elementField.description = description;
                Navigator.pop(context, true);
              },
              icon: const Icon(Icons.check_circle_outline),
            ),
            IconButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              icon: const Icon(Icons.cancel_outlined),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Name",
                  ),
                  initialValue: name,
                  onChanged: (string) {
                    name = string;
                  },
                ),
                const SizedBox(height: 40.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder()
                  ),
                  initialValue: description,
                  maxLines: null,
                  minLines: 20,
                  onChanged: (string) {
                    description = string;
                  },
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}
