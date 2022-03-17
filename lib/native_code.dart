import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeScreenCode extends StatefulWidget {
  const NativeScreenCode({Key? key}) : super(key: key);

  @override
  _NativeScreenCodeState createState() => _NativeScreenCodeState();
}

class _NativeScreenCodeState extends State<NativeScreenCode> {
  static const platform = MethodChannel('samples.flutter.dev/battery');

  String _batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: const Text('Get Battery Level'),
              onPressed: _getBatteryLevel,
            ),
            Text(_batteryLevel),
          ],
        ),
      ),
    );
  }
}
