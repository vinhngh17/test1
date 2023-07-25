import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _userPoint = 0;
  int _botPoint = 0;
  late int value;
  int count = 0;
  String? botString;
  String? userString;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tro choi"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cau thu ${count + 1}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('Diem cua ban: ${_userPoint}'),
              ],
            ),
          ),
          const SizedBox(
            height: 180,
          ),
          if (botString != null)
            Text(
              'May$botString',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          if (userString != null)
            Text(
              'Ban$userString',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          const SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    value = 0;
                    int bot = botPlay();
                    bool b = result(value, bot);
                    botString = printRs(bot);
                    userString = printRs(value);
                    count++;
                    if (value != bot) {
                      (b == true) ? _userPoint += 1 : _botPoint += 1;
                    }
                    if (count > 8) _showMaterialDialog(_userPoint);
                    setState(() {});
                  },
                  child: const Text("Keo")),
              ElevatedButton(
                  onPressed: () {
                    value = 1;
                    int bot = botPlay();
                    bool b = result(value, bot);
                    botString = printRs(bot);
                    userString = printRs(value);
                    count++;
                    if (value != bot) {
                      (b == true) ? _userPoint += 1 : _botPoint += 1;
                    }
                    if (count > 8) _showMaterialDialog(_userPoint);
                    setState(() {});
                  },
                  child: const Text("Bua")),
              ElevatedButton(
                  onPressed: () {
                    value = 2;
                    int bot = botPlay();
                    bool b = result(value, bot);
                    botString = printRs(bot);
                    userString = printRs(bot);
                    count++;
                    if (value != bot) {
                      (b == true) ? _userPoint += 1 : _botPoint += 1;
                    }
                    if (count > 8) _showMaterialDialog(_userPoint);
                    setState(() {});
                  },
                  child: const Text("Bao")),
            ],
          ),
        ],
      ),
    );
  }

  int botPlay() {
    int i = Random().nextInt(3);
    return i;
  }

  bool result(int player, int bot) {
    int playerPoint = 0, botPoint = 0;
    if (player == 0 && player != bot) {
      (bot == 1) ? botPoint += 1 : playerPoint += 1;
    } else if (player == 1 && player != bot) {
      (bot == 0) ? playerPoint += 1 : botPoint += 1;
    } else if (player == 2 && player != bot) {
      (bot == 1) ? playerPoint += 1 : botPoint += 1;
    }
    return playerPoint > botPoint;
  }

  String printRs(int rs) {
    if (rs == 0) {
      return " chon: keo";
    } else if (rs == 1) {
      return " chon: bua";
    } else {
      return " chon: la";
    }
  }

  void _showMaterialDialog(int uPoint) {
    String s = (uPoint >= 5) ? "Ban win" : "Ban thua";
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(s),
            content: Text('Diem cua ban: ${uPoint} '),
            actions: <Widget>[
              TextButton(onPressed: () {}, child: const Text('Close')),
              TextButton(
                onPressed: () {
                  setState(() {
                    count = 0;
                    _userPoint = 0;
                    _botPoint = 0;
                    botString = "";
                    userString = "";
                    Navigator.pop(context);
                  });
                },
                child: const Text('Choi lai'),
              )
            ],
          );
        });
  }
}
