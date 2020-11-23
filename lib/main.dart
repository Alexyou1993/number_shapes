import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Number Shapes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _inputNumber = TextEditingController();
  String _currentMessage = '';
  bool _validate = false;

  bool _isSquare(int _number) {
    final double c = sqrt(_number);
    if (_number / c == c) {
      return true;
    }
    return false;
  }

  bool _isTriangular(int _number) {
    if (_number < 0) {
      return false;
    }
    int sum = 0;
    for (int n = 1; sum <= _number; n++) {
      sum = sum + n;
      if (sum == _number) {
        return true;
      }
    }
    return false;
  }

  void _checkNumberShape(int _number) {
    if (_isSquare(_number) && _isTriangular(_number)) {
      setState(() {
        _currentMessage = 'Number $_number is square and triangular';
      });
    } else if (_isSquare(_number) == true) {
      setState(() {
        _currentMessage = 'Number $_number is only square';
      });
    } else if (_isTriangular(_number) == true) {
      setState(() {
        _currentMessage = 'Number $_number is only Triangular';
      });
    } else {
      setState(() {
        _currentMessage = 'Number $_number is neither square or triangular';
      });
    }
    _inputNumber.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset('assets/image/TriSquare36.png'),
            const Text(
              'Please input a number to see if it is triangular or square',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            TextField(
              controller: _inputNumber,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: 'Enter the Value',
                errorText: _validate ? 'Value Can\'t Be Empty' : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _currentMessage,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  wordSpacing: 5,
                ),
              ),
            ),
            FlatButton(
              color: Colors.grey,
              child: const Text(
                'Test Number',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                setState(() {
                  _inputNumber.text.isEmpty
                      ? _validate = true
                      : _validate = false;
                });
                if (_validate == false) {
                  _checkNumberShape(int.parse(_inputNumber.text));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
