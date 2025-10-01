import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(AngleConverterApp());
}

class AngleConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Convertor Unghiuri',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AngleConverterHome(),
    );
  }
}

class AngleConverterHome extends StatefulWidget {
  @override
  _AngleConverterHomeState createState() => _AngleConverterHomeState();
}

class _AngleConverterHomeState extends State<AngleConverterHome> {
  final TextEditingController _inputController = TextEditingController();
  bool _isDegreesToRadians = true; // true = grade->radiani, false = radiani->grade
  String _result = '';

  double _degreesToRadians(double degrees) {
    return degrees * (math.pi / 180);
  }

  double _radiansToDegrees(double radians) {
    return radians * (180 / math.pi);
  }

  void _convertAngle() {
    String inputText = _inputController.text;

    if (inputText.isEmpty) {
      setState(() {
        _result = 'Introduceți o valoare!';
      });
      return;
    }

    double? inputValue = double.tryParse(inputText);
    if (inputValue == null) {
      setState(() {
        _result = 'Valoare invalidă!';
      });
      return;
    }

    double convertedValue;
    String fromUnit;
    String toUnit;
    if (_isDegreesToRadians) {
      convertedValue = _degreesToRadians(inputValue);
      fromUnit = 'grade';
      toUnit = 'radiani';
    } else {
      convertedValue = _radiansToDegrees(inputValue);
      fromUnit = 'radiani';
      toUnit = 'grade';
    }

    setState(() {
      _result = '$inputValue $fromUnit = ${convertedValue.toStringAsFixed(6)} $toUnit';
    });
  }

  void _clearAll() {
    setState(() {
      _inputController.clear();
      _result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Convertor Unghiuri'),
        ),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Card pentru input
              Card(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Introduceți valoarea:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 15),
                      TextField(
                        controller: _inputController,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          labelText: 'Valoarea unghiului',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: Icon(Icons.straighten),
                          hintText: _isDegreesToRadians ? 'Ex: 90 (grade)' : 'Ex: 1.57 (radiani)',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              Card(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Selectați tipul conversiei:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 15),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Text(
                                'Radiani → Grade',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: !_isDegreesToRadians ? FontWeight.bold : FontWeight.normal,
                                  color: !_isDegreesToRadians ? Colors.blue : Colors.black54,
                                ),
                              ),
                            ),
                            Switch(
                              value: _isDegreesToRadians,//boolean, t- radian,
                              onChanged: (value) {
                                setState(() {
                                  _isDegreesToRadians = value;
                                  _result = ''; // Resetează
                                });
                              },
                              activeColor: Colors.blue,
                            ),
                            Expanded(
                              child: Text(
                                'Grade → Radiani',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: _isDegreesToRadians ? FontWeight.bold : FontWeight.normal,
                                  color: _isDegreesToRadians ? Colors.blue : Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Butoane
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _convertAngle,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.calculate),
                            SizedBox(width: 8),
                            Text('CONVERTEȘTE'),
                          ],
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _clearAll,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: Icon(Icons.clear),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade600,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30),

              // Card pentru rezultat
              Card(
                elevation: 4,
                color: Colors.blue.shade50,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.trending_flat,
                            color: Colors.blue.shade700,
                            size: 24,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'REZULTAT',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue.shade200),
                        ),
                        child: Text(
                          _result.isEmpty ? 'Rezultatul va apărea aici...' : _result,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: _result.isEmpty ? FontWeight.normal : FontWeight.bold,
                            color: _result.isEmpty ? Colors.grey.shade600 : Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Footer informativ
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'π ≈ 3.14159... • 1 radiant ≈ 57.296°',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}