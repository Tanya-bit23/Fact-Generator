import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Генератор случайных фактов',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: FactsPage(),
    );
  }
}

class FactsPage extends StatefulWidget {
  @override
  _FactsPageState createState() => _FactsPageState();
}

class _FactsPageState extends State<FactsPage> {
  String _fact = 'Выберите категорию и нажмите кнопку!';

  final Map<String, List<String>> _factsByCategory = {
    'Наука': [
      'Вода состоит из двух атомов водорода и одного атома кислорода.',
      'Солнце - это звезда, а не планета.',
      'Человеческий мозг на 75% состоит из воды.',
    ],
    'История': [
      'Древний Египет известен своими пирамидами.',
      'Год 1776 считается годом независимости США.',
      'Первый человек, ступивший на Луну — Нил Армстронг.',
    ],
    'Природа': [
      'Самое высокое дерево в мире - секвойя.',
      'Океаны занимают около 71% поверхности Земли.',
      'Совы могут поворачивать голову на 270 градусов.',
    ],
  };

  String _selectedCategory = 'Наука';

  void _getRandomFact() {
    final facts = _factsByCategory[_selectedCategory];
    if (facts != null && facts.isNotEmpty) {
      final randomIndex = Random().nextInt(facts.length);
      setState(() {
        _fact = facts[randomIndex];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Генератор случайных фактов'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    value: _selectedCategory,
                    isExpanded: true,
                    underline: Container(),
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                    items:
                        _factsByCategory.keys.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCategory = newValue!;
                        _fact = 'Выберите категорию и нажмите кнопку!';
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    _fact,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _getRandomFact,
                    child: Text('Получить случайный факт!'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
