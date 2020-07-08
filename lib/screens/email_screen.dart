import 'package:flutter/material.dart';

import '../models/email_model.dart';

import './signature_screen.dart';

class EmailScreen extends StatefulWidget {
  //route name
  static const routeName = '/emailForm';

  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  //defining email properties
  List<String> attachments = [];
  bool isHTML = false;

  //focus nodes
  final _recipientFocusNode = FocusNode();
  final _sbjFocusNode = FocusNode();
  final _msgFocusNode = FocusNode();

  final _form = GlobalKey<FormState>();

  //variable to save and check if there is already data entered
  var _editedEmail = EmailModel(
    email: '',
    msg: '',
    subject: '',
  );

  var _initValues = EmailModel(
    email: '',
    msg: '',
    subject: '',
  );

  //checks initialisation
  var _isInit = true;

//runs just after initialisatio
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _initValues = EmailModel(
        email: _editedEmail.email,
        msg: _editedEmail.msg,
        subject: _editedEmail.subject,
      );
    }
    super.didChangeDependencies();
  }

//this function is called when saved
  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }

    _form.currentState.save();
    Navigator.of(context)
        .pushNamed(SignatureScreen.routeName, arguments: _editedEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email & Signature Sender'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: _saveForm,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child:

                    //-------------THis is the recepient field------//
                    TextFormField(
                        initialValue: _initValues.email,
                        decoration: InputDecoration(
                          labelText: 'Recipient\'s Email',
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                        focusNode: _recipientFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_sbjFocusNode);
                        },

                        //Validates Form
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide a value.';
                          }
                          if (!value.contains('@') || !value.contains('.')) {
                            return 'This is an invalid email';
                          }
                          return null;
                        },

                        //On Saved function for this form
                        onSaved: (value) {
                          _editedEmail = EmailModel(
                            email: value,
                            subject: _editedEmail.subject,
                            msg: _editedEmail.msg,
                          );
                        }),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child:
                    //--------This is the subject field --------//
                    TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Subject',
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  focusNode: _sbjFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_msgFocusNode);
                  },

                  //Validates form
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a value.';
                    }
                    return null;
                  },

                  onSaved: (value) {
                    _editedEmail = EmailModel(
                      email: _editedEmail.email,
                      subject: value,
                      msg: _editedEmail.msg,
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),

                //-----------This is the body field--------//
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Body',
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  focusNode: _msgFocusNode,
                  maxLines: 10,
                  onFieldSubmitted: (_) {},

                  //Validates form
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a value.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editedEmail = EmailModel(
                      email: _editedEmail.email,
                      subject: _editedEmail.subject,
                      msg: value,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
