import 'package:flutter/material.dart';

final class Runner {
  Future<void> run() async {
    final bindings = WidgetsBinding.instance;



    try {} on Object catch (e) {
      
    } finally {
          bindings.allowFirstFrame();
    }
  }
}
