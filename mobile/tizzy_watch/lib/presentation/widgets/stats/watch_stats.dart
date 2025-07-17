import 'package:flutter/material.dart';

class WatchStats extends StatelessWidget {
  const WatchStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Stats", style: TextStyle(fontSize: 20)),
            OutlinedButton(
              style: OutlinedButton.styleFrom(minimumSize: const Size(40, 20)),
              onPressed: (){},
              child: const Text("Refresh", style: TextStyle(fontSize: 17)),
            ),
          ],
        ),
        Table(
          defaultColumnWidth: FlexColumnWidth(1),
          children: [
            TableRow(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(), // Only bottom border
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Stats",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Tity",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Izzy",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Steps"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("1920"),
                ),
                Padding(padding: const EdgeInsets.all(8.0), child: Text("???")),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Heart Rate"),
                ),
                Padding(padding: const EdgeInsets.all(8.0), child: Text("86")),
                Padding(padding: const EdgeInsets.all(8.0), child: Text("88")),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Phone %"),
                ),
                Padding(padding: const EdgeInsets.all(8.0), child: Text("93%")),
                Padding(padding: const EdgeInsets.all(8.0), child: Text("76%")),
              ],
            ),
            TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Watch %"),
                ),
                Padding(padding: const EdgeInsets.all(8.0), child: Text("85%")),
                Padding(padding: const EdgeInsets.all(8.0), child: Text("90%")),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
