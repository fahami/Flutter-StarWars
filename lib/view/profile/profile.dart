import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:starwars/models/people.dart';

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
    widget.people!.props.forEach((value) {
      initValue.add(value.toString());
    });
    widget.people!.params.forEach((controlller) {
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
    inspect(widget.people!);
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
                      inspect((textEditingControllers['films']));
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
                        // species:
                        //     json.decode(textEditingControllers['species'].text),
                        // films:
                        //     json.decode(textEditingControllers['films'].text),
                        // starships: json
                        //     .decode(textEditingControllers['starships'].text),
                        // vehicles: json
                        //     .decode(textEditingControllers['vehicles'].text),
                      );
                      print("cek temp");
                      inspect(temp);
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
      body: SingleChildScrollView(
        child: isEdit
            ? Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [...textFields],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Text('Name'),
                      title: Text(widget.people!.name!),
                    ),
                    ListTile(
                      leading: Text('Mass'),
                      title: Text(widget.people!.mass!),
                    ),
                    ListTile(
                      leading: Text('Skin Color'),
                      title: Text(widget.people!.skinColor!),
                    ),
                    ListTile(
                      leading: Text('URL'),
                      title: Text(widget.people!.url!),
                    ),
                    Text(
                      'Species',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    widget.people!.species!.length > 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.people!.species!.length,
                            itemBuilder: (context, i) {
                              return ListTile(
                                leading: Icon(Icons.star),
                                title: Text(widget.people!.species![i]),
                              );
                            })
                        : Text("No Data"),
                    Text(
                      'Starship',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    widget.people!.starships!.length > 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.people!.starships!.length,
                            itemBuilder: (context, i) {
                              return ListTile(
                                leading: Icon(Icons.flight),
                                title: Text(widget.people!.starships![i]),
                              );
                            })
                        : Text('No Data'),
                    Text(
                      'Vehicles',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    widget.people!.vehicles!.length > 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.people!.vehicles!.length,
                            itemBuilder: (context, i) {
                              return ListTile(
                                leading: Icon(Icons.motorcycle),
                                title: Text(widget.people!.vehicles![i]),
                              );
                            })
                        : Text('No Data'),
                  ],
                ),
              ),
      ),
    );
  }
}
