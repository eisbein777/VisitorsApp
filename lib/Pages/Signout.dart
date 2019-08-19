import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fitzroy_visitors/Dto/User.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fitzroy_visitors/Dto/Visitor.dart';
import 'package:fitzroy_visitors/Business/API.dart';

class SignOutForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: MyCustomForm()));
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final TextEditingController _typeAheadController = TextEditingController();
  String _selectedPerson;
  final _formKey = GlobalKey<FormState>();

  _getUsers() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        users = list.map((model) => User.fromJson(model)).toList();
      });
    });
  }

  _saveVisitor(Visitor vis) {
    API.saveVisistor(vis).then((response) {
      Navigator.pop(context);
    });
  }

  List<String> _selectUsers(String pattern) {
    List<String> concatnames =
        users.map((users) => users.firstname + ' ' + users.lastname).toList();

    concatnames
        .retainWhere((s) => s.toLowerCase().contains(pattern.toLowerCase()));

    return concatnames;
  }

  initState() {
    super.initState();
    _getUsers();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.all(5),
      //padding: const EdgeInsets.all(10.0),
      decoration: new BoxDecoration(
          border: new Border.all(
        color: Color(0xFF00888A), //Color(0xFF05827E)
        width: 15,
      )),
      // child: SingleChildScrollView(

      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(150, 50, 150, 50),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TypeAheadFormField(
                      textFieldConfiguration: TextFieldConfiguration(
                          controller: this._typeAheadController,
                          style: TextStyle(fontSize: 25),
                          decoration: InputDecoration(
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 25.0, horizontal: 10.0),
                              border: OutlineInputBorder(),
                              labelText: 'Person Visiting')),
                      suggestionsCallback: (pattern) {
                        return _selectUsers(pattern);
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          leading: Icon(Icons.person),
                          title: Text(suggestion),
                          //  subtitle: Text('\$${suggestion['price']}'),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        this._typeAheadController.text = suggestion;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please select Person visiting';
                        }
                        return null;
                      },
                      onSaved: (value) => this._selectedPerson = value,
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(130, 10, 20, 10),
                  child: ButtonTheme(
                      minWidth: 200.0,
                      height: 100.0,
                      buttonColor: Color(0xFF00888A),
                      child: RaisedButton(
                        child: Text(
                          'Submit',
                          style: TextStyle(fontSize: 30.0, color: Colors.white),
                        ),
                        shape: StadiumBorder(),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            /*      SignOut newvis = new SignOut(         
                                _typeAheadController.text,
                                "",
                                img);
                            _saveVisitor(newvis);
                        */
                          }
                        },
                      )),
                )
              ],
            ),
          ),
        ),
      ]),

      // )
    );
  }
}
