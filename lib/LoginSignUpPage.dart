import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@override
Widget build(BuildContext context) {
  _isIos = Theme.of(context).platform == TargetPlatform.iOS;
  return new Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter login demo'),
      ),
      body: Stack(
        children: <Widget>[
          _showBody(),
          _showCircularProgress(),
        ],
      ));
}