import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final outputController = TextEditingController();
  final translator = GoogleTranslator();
  String inputText = '';
  String inputLanguage = 'en';
  String outputLanguage = 'ur';

  Future<void> translateText() async {
    final translated = await translator.translate(inputText,
        from: inputLanguage, to: outputLanguage);
    setState(() {
      outputController.text = translated.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(20.0), // Set this height to the desired value
        child: AppBar(
          backgroundColor: Colors.transparent,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 170,
                  width: 270,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage(
                          'assets/translate.webp'), // Specify your image path
                      fit: BoxFit
                          .cover, // Ensures the image covers the container while maintaining aspect ratio
                    ),
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(
                        20), // Radius of the rounded corners
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Turbo Translator",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    maxLines: 5,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter Text To Translate"),
                    onChanged: (value) => {
                      setState(
                        () {
                          inputText = value;
                        },
                      )
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DropdownButton<String>(
                      value: inputLanguage,
                      onChanged: (newValue) {
                        setState(() {
                          inputLanguage = newValue!;
                        });
                      },
                      items: <String>[
                        'en',
                        'fr',
                        'es',
                        'de',
                        'ur',
                        'hi',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const Icon(Icons.arrow_forward_rounded),
                    DropdownButton<String>(
                      value: outputLanguage,
                      onChanged: (newValue) {
                        setState(() {
                          outputLanguage = newValue!;
                        });
                      },
                      items: <String>[
                        'en',
                        'fr',
                        'es',
                        'de',
                        'ur',
                        'hi',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                  ],
                ),
                ElevatedButton(
                    onPressed: translateText, child: Text("Translate")),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: outputController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Result here..."),
                    onChanged: (value) => {
                      setState(
                        () {
                          inputText = value;
                        },
                      )
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
