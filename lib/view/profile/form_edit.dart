import 'package:flutter/material.dart';

class FormEdit extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final List<TextFormField> textFields;
  FormEdit({
    Key? key,
    required this.formKey,
    required this.textFields,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [...textFields],
      ),
    );
  }
}
