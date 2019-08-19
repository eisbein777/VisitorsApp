import 'dart:convert';
import 'package:fitzroy_visitors/Widgets/CustomFormText.dart';
import 'package:flutter/material.dart';
import 'package:fitzroy_visitors/Dto/User.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:signature/signature.dart';
import 'package:fitzroy_visitors/Dto/Visitor.dart';

import 'package:fitzroy_visitors/Business/API.dart';

class SigninForm extends StatelessWidget {
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
  final fncontroller = TextEditingController();
  final lncontroller = TextEditingController();
  final cpcontroller = TextEditingController();
  final tgcontroller = TextEditingController();
  final TextEditingController _typeAheadController = TextEditingController();
  String _selectedPerson;

  final _formKey = GlobalKey<FormState>();

  var users = new List<User>();

  var _signatureCanvas = Signature(
    width: 600,
    height: 150,
    backgroundColor: Colors.grey,
    penColor: Colors.black,
  );

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
        Container(
          constraints: new BoxConstraints.expand(
            height: 90,
            width: 90,
          ),
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/DFLogo.jpg'),
              // fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(150, 50, 150, 50),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomFormText(fncontroller, 'First Name'),
                CustomFormText(lncontroller, 'Last Name'),
                CustomFormText(cpcontroller, 'Company'),
                // CustomFormText(tgcontroller, 'Tag Number'),
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
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*2*/
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          'Signature:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      _signatureCanvas
                    ],
                  ),
                ),
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
                        onPressed: () async {
                          var img = await _signatureCanvas.exportBytes();

                          if (_formKey.currentState.validate()) {
                            Visitor newvis = new Visitor(
                                fncontroller.text,
                                lncontroller.text,
                                cpcontroller.text,
                                _typeAheadController.text,
                                "",
                                img);
                            _saveVisitor(newvis);
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
