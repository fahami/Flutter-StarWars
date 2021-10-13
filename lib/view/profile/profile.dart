import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starwars/models/people.dart';
import 'package:starwars/view/profile/form_edit.dart';
import 'package:starwars/view_model/people_provider..dart';

class ProfileScreen extends StatefulWidget {
  final People? people;
  const ProfileScreen({Key? key, this.people}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEdit = false;
  var textFields = <TextFormField>[];
  @override
  Map<String, dynamic> textEditingControllers = {};
  void initState() {
    // TODO: implement initState
    super.initState();
    var stringParams = [];
    var initValue = [];
    var newprops = widget.people!.props;
    var newparams = widget.people!.params;

    newprops.removeRange(9, 13);
    inspect(newprops);
    newparams.removeRange(9, 13);
    inspect(newparams);

    // inspect(newprops);
    newprops.forEach((value) {
      initValue.add(value.toString());
    });
    newparams.forEach((controlller) {
      stringParams.add(controlller.toString());
    });

    stringParams.asMap().forEach((index, str) {
      var textEditingController =
          new TextEditingController(text: initValue[index]);
      textEditingControllers.putIfAbsent(str, () => textEditingController);
      return textFields.add(
        TextFormField(
          controller: textEditingController,
          decoration: InputDecoration(
            labelText: str,
          ),
        ),
      );
    });
    inspect(stringParams);
    inspect(initValue);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.people!.name!),
        actions: [
          TextButton(
            onPressed: !isEdit
                ? () {
                    setState(() {
                      isEdit = !isEdit;
                    });
                  }
                : () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      inspect(textEditingControllers);
                      People temp = People(
                        birthYear: textEditingControllers['birthYear'].text,
                        name: textEditingControllers['name'].text,
                        created: textEditingControllers['created'].text,
                        edited: textEditingControllers['edited'].text,
                        eyeColor: textEditingControllers['eyeColor'].text,
                        gender: textEditingControllers['gender'].text,
                        hairColor: textEditingControllers['hairColor'].text,
                        height: textEditingControllers['height'].text,
                        homeworld: textEditingControllers['homeworld'].text,
                        mass: textEditingControllers['mass'].text,
                        skinColor: textEditingControllers['skinColor'].text,
                        url: textEditingControllers['url'].text,
                      );
                      inspect(temp);
                      Provider.of<PeopleProvider>(context, listen: false)
                          .updateProfile(temp, widget.people!.url!)
                          .then((_) => Navigator.pushNamed(context, '/'));

                      // DatabaseHelper()..updatePeople(temp)..getPeoples();
                    }

                    setState(() {
                      print('Disimpan');
                      isEdit = false;
                    });
                  },
            child: Text(
              isEdit ? 'Simpan' : 'Edit',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<PeopleProvider>(context, listen: false)
              .setFavorite(true, widget.people!.url!);
        },
        child: Icon(
          Icons.favorite_outline,
          color: Colors.red,
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: isEdit
            ? Padding(
                padding: const EdgeInsets.all(16),
                child: FormEdit(
                  formKey: _formKey,
                  textFields: textFields,
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text('Name'),
                      subtitle: Text(widget.people!.name!),
                    ),
                    ListTile(
                      title: Text('Mass'),
                      subtitle: Text(widget.people!.mass!),
                    ),
                    ListTile(
                      title: Text('Height'),
                      subtitle: Text(widget.people!.height!),
                    ),
                    ListTile(
                      title: Text('Skin Color'),
                      subtitle: Text(widget.people!.skinColor!),
                    ),
                    ListTile(
                      title: Text('Birth Year'),
                      subtitle: Text(widget.people!.birthYear!),
                    ),
                    ListTile(
                      title: Text('Eye Color'),
                      subtitle: Text(widget.people!.eyeColor!),
                    ),
                    ListTile(
                      title: Text('Hair Color'),
                      subtitle: Text(widget.people!.hairColor!),
                    ),
                    ListTile(
                      title: Text('Home World'),
                      subtitle: Text(widget.people!.homeworld!),
                    ),
                    ListTile(
                      title: Text('URL'),
                      subtitle: Text(widget.people!.url!),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
