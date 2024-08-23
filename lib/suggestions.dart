import 'package:flutter/material.dart';
import 'package:friends/components/mytext.dart';

class Suggestions extends StatefulWidget {
  const Suggestions({super.key});

  @override
  State<Suggestions> createState() => _SuggestionsState();
}

class _SuggestionsState extends State<Suggestions> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: MyText(
        data: "Suggestions",
        fontSize: 30,
      ),
    );
  }
}
