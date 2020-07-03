import 'package:flutter/material.dart';

import '../widgets/signature_widget.dart';

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
                  validator: (value) {},
                ),
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
              Padding(
                padding: EdgeInsets.all(8.0),
                child: SignatureBox(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
