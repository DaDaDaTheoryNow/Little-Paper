package com.dadadadev.little_paper

import android.app.WallpaperManager
import android.content.Context
import android.content.Intent
import android.graphics.BitmapFactory
import android.net.Uri
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.io.File

class MainActivity : FlutterActivity() {
    private val CHANNEL = "wallpaper_channel"
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "setWallpaper") {
                val imageUri = call.argument<String>("imageUri")

                if (imageUri != null) {
                    val wallpaperIntent = Intent(Intent.ACTION_ATTACH_DATA)
                    wallpaperIntent.setDataAndType(Uri.parse(imageUri), "image/jpeg")
                    wallpaperIntent.putExtra("mimeType", "image/jpeg")
                    wallpaperIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION or Intent.FLAG_ACTIVITY_NEW_TASK)

                    val wallpaperManager = WallpaperManager.getInstance(applicationContext)

                    try {
                        val file = File(imageUri)
                        val bitmap = BitmapFactory.decodeFile(file.path)

                        wallpaperManager.setBitmap(bitmap)
                        applicationContext.startActivity(wallpaperIntent)
                        result.success(true)
                    } catch (e: Exception) {
                        e.printStackTrace()
                        result.error("ERROR", "Failed to set wallpaper", null)
                    }
                } else {
                    result.error("INVALID_ARGUMENT", "Invalid image URI", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}
