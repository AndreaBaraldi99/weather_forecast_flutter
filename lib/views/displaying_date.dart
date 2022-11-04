import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatefulWidget {
  const DateWidget({super.key});

  @override
  State<DateWidget> createState() => DateWidgetState();
}

class DateWidgetState extends State<DateWidget> {
  final ScrollController _firstController = ScrollController();
  List<String> dates = List.empty(growable: true); //test value

  List<DateSelected> dateSelected = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    dates.addAll({
      "2022-11-04T03:02",
      "2022-11-05T03:02",
      "2022-11-06T03:02",
      "2022-11-07T03:02",
      "2022-11-08T03:02",
      "2022-11-09T03:02",
      "2022-11-10T03:02"
    });
    for (var element in dates) {
      if (element == dates[0]) {
        dateSelected.add(DateSelected(element, true));
      } else {
        dateSelected.add(DateSelected(element, false));
      }
    }
  }

  onPressed(int index) {
    if (mounted) {
      setState(() {
        for (var value in dateSelected) {
          value.selected = false;
        }
        dateSelected[index].selected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: 7,
      controller: _firstController,
      separatorBuilder: (context, index) => const SizedBox(
        width: 10,
      ),
      itemBuilder: ((context, index) {
        return day(
            dateSelected[index].date, dateSelected[index].selected, index);
      }),
    );
  }

  Container day(String date, bool selected, int index) {
    var dateValue = DateFormat("yyyy-MM-ddTHH:mm").parseUTC(date);
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: selectedBackgroundColor(selected),
            border: Border.all(
              color: (Colors.white),
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: TextButton(
            onPressed: (() {
              if (mounted) {
                onPressed(index);
              }
            }),
            child: Text(
              DateFormat("EEEE, d MMMM").format(dateValue),
              style: const TextStyle(color: Colors.white),
            )));
  }

  Color selectedBackgroundColor(bool selected) {
    if (selected) {
      return Colors.pink[200]!;
    } else {
      return Colors.transparent;
    }
  }
}

class DateSelected {
  String date;
  bool selected;

  DateSelected(this.date, this.selected);
}
