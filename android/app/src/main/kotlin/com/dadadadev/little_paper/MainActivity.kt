package com.dadadadev.little_paper

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant



class MainActivity : FlutterActivity() {
    private val methodChannel = "wallpaper_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        val wallpaperManager = WallpaperManager(this)
        val wallpaperPermissionManager = WallpaperPermissionManager(this)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, methodChannel).setMethodCallHandler { call, result ->
            when (call.method) {
                "setWallpaper" -> {
                    val imageBytes = call.argument<ByteArray>("imageBytes")
                    val success = wallpaperManager.setWallpaper(imageBytes = imageBytes)
                    if (success) {
                        result.success(true)
                    } else {
                        result.error("ERROR", "Failed to set wallpaper", null)
                    }
                }
                "shareWallpaper" -> {
                    val imageBytes = call.argument<ByteArray>("imageBytes")
                    val success = wallpaperManager.shareWallpaper(imageBytes = imageBytes)
                    if (success) {
                        result.success(true)
                    } else {
                        result.error("ERROR", "Failed to set wallpaper", null)
                    }
                }
                "permissionsForWallpaper" -> {
                    val success = wallpaperPermissionManager.requiredPermission()
                    if (success) {
                        result.success(true)
                    } else {
                        result.success(false)
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
