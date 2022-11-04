import 'package:flutter/material.dart';

class DataWidget extends StatefulWidget {
  const DataWidget({super.key});

  @override
  State<DataWidget> createState() => DataWidgetState();
}

class DataWidgetState extends State<DataWidget> {
  String maxTemp = "18°";
  String minTemp = "16°";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 20, 8, 20),
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 18, 26, 44),
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: GridView.count(
        padding: const EdgeInsets.all(8),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 20, 0),
            alignment: Alignment.topCenter,
            child: Image.asset('resources/images/sun.png'),
          ),
          Container(
            alignment: Alignment.center,
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    maxTemp,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 201, 12, 12),
                        fontSize: 35,
                        fontFamily: 'Lato'),
                  ),
                ),
                Text(
                  minTemp,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 8, 131, 193),
                      fontSize: 35,
                      fontFamily: 'Lato'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
