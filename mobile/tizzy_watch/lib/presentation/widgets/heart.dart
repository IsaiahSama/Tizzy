import "package:flutter/material.dart";

class Heart extends StatelessWidget {
  const Heart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.favorite),
          label: const Text("I love you"),
          onPressed: () {},
        ),
      ),
    );
  }
}