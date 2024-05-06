import 'dart:async';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechRecognitionProvider extends ChangeNotifier {
  final SpeechToText _speechToText = SpeechToText();
  bool _isListening = false;
  String _lastWords = '';

  bool get isListening => _isListening;
  String get lastWords => _lastWords;

  late Timer _timeoutTimer;

  SpeechRecognitionProvider() {
    initialize();
  }

  Future<void> initialize() async {
    try {
      bool available = await _speechToText.initialize(
        onError: (val) => print("Error: $val"),
        onStatus: (val) => print("Status: $val"),
      );
      if (!available) {
        print(
            "The user has denied the use of speech recognition or initialization failed.");
        return;
      }

      if (!_speechToText.isAvailable) {
        print("Speech recognition not available.");
      } else {
        print("Speech recognition available.");
      }
    } catch (e) {
      print("Error initializing speech recognition: $e");
    }
  }

  Future<void> startListening() async {
    if (!_isListening && _speechToText.isAvailable) {
      _isListening = true;
      _timeoutTimer = Timer(Duration(minutes: 1), () {
        print("Speech recognition timeout error occurred.");
        stopListening();
      });
      await _speechToText.listen(
        onResult: _onSpeechResult,
        listenFor: Duration(minutes: 1),
        pauseFor: Duration(seconds: 10),
        localeId: "en_US",
      );
      notifyListeners();
      print("Listening started");
    } else {
      print("Already listening or initialization not done.");
    }
  }

  Future<void> stopListening() async {
    if (_isListening) {
      _timeoutTimer.cancel();
      await _speechToText.stop();
      _isListening = false;
      notifyListeners();
      print("Listening stopped");
    }
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    try {
      _lastWords = result.recognizedWords;
      notifyListeners();
      print("Speech recognition result: " + result.recognizedWords);
      print("Is final result: " + result.finalResult.toString());
    } catch (e) {
      print("Error processing speech result: $e");
    }
  }
}
