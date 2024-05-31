import 'package:flutter/services.dart';
import 'package:js/js.dart';

@JS()
class TensorFlowJS {
  external static Future loadGraphModel(String url);
}

class Heart {
  Heart();

  Future<void> loadModel() async {
    try {
      // Load model architecture JSON
      String architectureJson = await rootBundle.loadString(
          'lib/conf/func/NeuralNetwork/compiler/model_architecture.json');

      // Load model weights
      ByteData weightsData = await rootBundle.load(
          'lib/conf/func/NeuralNetwork/compiler/model_weights.weights.h5');
      List<int> weightsBytes =
          weightsData.buffer.asUint8List(weightsData.offsetInBytes);

      // Instantiate the model
      var modelUrl =
          'lib/conf/func/NeuralNetwork/compiler/model_architecture.json'; // This should be the path to your JSON file
      var model = await TensorFlowJS.loadGraphModel(modelUrl);

      print('Model loaded successfully');
    } catch (e) {
      print('Error loading model: $e');
    }
  }

  // Add other methods to interact with the model
}

void main() {
  Heart heart = Heart();
  heart.loadModel();
}
