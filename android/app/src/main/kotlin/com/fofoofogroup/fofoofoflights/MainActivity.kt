package com.fofoofogroup.fofoofoflights

import io.flutter.embedding.android.FlutterActivity

// class MainActivity: FlutterActivity() {
// }

import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterFragmentActivity() {
   override fun configureFlutterEngine(@NonNull flutterEngine: 
     FlutterEngine) {
     GeneratedPluginRegistrant.registerWith(flutterEngine)
   }
}