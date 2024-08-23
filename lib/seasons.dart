import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'package:friends/components/mytext.dart';
import 'dart:convert';

class Seasons extends StatefulWidget {
  const Seasons({super.key});

  @override
  State<Seasons> createState() => _SeasonsState();
}

class _SeasonsState extends State<Seasons> {
  List<List<dynamic>> _data = [];
  List<int> _seasons = [];
  int? _selectedSeason;

  @override
  void initState() {
    super.initState();
    _loadCSV();
  }

  void _loadCSV() async {
    try {
      final rawData =
          await rootBundle.loadString('assets/data/data.csv', cache: false);
      final decodedData = utf8.decode(rawData.codeUnits, allowMalformed: true);

      List<List<dynamic>> listData =
          const CsvToListConverter().convert(decodedData);

      final seasons =
          listData.skip(1).map((row) => row[1] as int).toSet().toList();

      setState(() {
        _data = listData;
        _seasons = seasons;
      });
    } catch (e) {}
  }

  void _showEpisodeDetails(Map<String, dynamic> episode) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${episode['title']}",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                "Episode: ${episode['episode']}",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                "Duration: ${episode['duration']} min",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[300],
                ),
              ),
              Text(
                "Rating: ${episode['rating']}",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[300],
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                "Summary:",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                "${episode['summary']}",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[300],
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final episodes = _selectedSeason == null
        ? []
        : _data.where((row) => row[1] == _selectedSeason).toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          const MyText(data: "Select a Season", fontSize: 12),
          if (_seasons.isNotEmpty)
            Container(
              color: Colors.transparent,
              height: 80,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _seasons.map((season) {
                    return Container(
                      width: 80,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        color: _selectedSeason == season
                            ? Colors.black45
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(
                            12.0), // Adjust the radius as needed
                      ),
                      child: ListTile(
                        title: MyText(data: 'S$season', fontSize: 18),
                        onTap: () {
                          setState(() {
                            _selectedSeason = season;
                          });
                        },
                        textColor:
                            _selectedSeason == season ? Colors.white : null,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          Expanded(
            child: _selectedSeason == null
                ? const Center(child: Text("Select a season"))
                : ListView.builder(
                    itemCount: episodes.length,
                    itemBuilder: (context, index) {
                      final row = episodes[index];
                      final episode = {
                        'title': row[3],
                        'episode': row[2],
                        'duration': row[4],
                        'rating': row[7],
                        'summary': row[5],
                      };

                      return Card(
                        color: Colors.black54,
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: MyText(
                            data: "${row[3]} (${row[0]})",
                            fontSize: 20.0,
                          ),
                          subtitle: MyText(
                            data: "Episode ${row[2]}\nDuration: ${row[4]} min",
                            fontSize: 14.0,
                          ),
                          onTap: () => _showEpisodeDetails(episode),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
