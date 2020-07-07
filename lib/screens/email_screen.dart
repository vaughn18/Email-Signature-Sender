import 'package:flutter/material.dart';

import '../models/email_model.dart';

class EmailScreen extends StatefulWidget {
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
  void _saveEmail(EmailModel email) {
    final newEmail = EmailModel(
      email: email.email,
      msg: email.msg,
      subject: email.subject,
    );

    _initValues = newEmail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email & Signature Sender'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {},
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
                child: TextFormField(
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
                      if (!value.contains('@') || !value.contains('.com')) {
                        return 'This is an invalid email';
                      }
                      return null;
                    },

                    //On Saved function for this form
                    onSaved: (value) {
                      _editedEmail = EmailModel(
                          email: value,
                          subject: _editedEmail.subject,
                          msg: _editedEmail.msg);
                    }),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
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

                  //
                  validator: (value) {},
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
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
                  validator: (value) {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
