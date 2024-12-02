import 'package:flutter/material.dart';
import 'package:photo_shader/photo_shader.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: Colors.grey.shade100,
          child: RebuildingShaderExample(),
        ),
      ),
    );
  }
}

class RebuildingShaderExample extends StatefulWidget {
  const RebuildingShaderExample({super.key});

  @override
  State<RebuildingShaderExample> createState() => _RebuildingShaderExampleState();
}

class _RebuildingShaderExampleState extends State<RebuildingShaderExample> {

  PhotoStyle imageStyle = PhotoStyle.noEffects();

  AssetImage image = AssetImage('assets/images/test_image.jpg');

  void setHue(double value) {
    setState(() {
      imageStyle = imageStyle.copyWith(hue: value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: PhotoShader.provider(
              style: imageStyle,
              imageProvider: image,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {
                if(imageStyle.hue == 1) {
                  setHue(0.5);
                } else {
                  setHue(1);
                }
              }, child: Text('Rebuild Shader')),
              ElevatedButton(onPressed: () {
                if(image.assetName == 'assets/images/test_image.jpg') {
                  setState(() {
                    image = AssetImage('assets/images/test_image_2.jpg');
                  });
                } else {
                  setState(() {
                    image = AssetImage('assets/images/test_image.jpg');
                  });
                }
              }, child: Text('Change Image')),
            ],
          ),
        ),
      ],
    );
  }
}
