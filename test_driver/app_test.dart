import 'dart:io';
import 'package:path/path.dart';

// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

const path = r'C:\Users\omerg\AppData\Local\Android\Sdk';

Future<void> grantPermissions() async {
  final adbPath = join(
    path,
    'platform-tools',
    Platform.isWindows ? 'adb.exe' : 'adb',
  );
  await Process.run(adbPath, [
    'shell',
    'pm',
    'grant',
    'com.whatsappclone.WhatAppClone',
    'android.permission.INTERNET'
  ]);
}

void main() {
  group('NewsAPI App Test -', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      // grant device permission
      await grantPermissions();
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Load articles data and refresh articles', () async {});
  });
}
