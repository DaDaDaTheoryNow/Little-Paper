package com.dadadadev.little_paper

import android.app.WallpaperManager
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.opengl.EGL14.eglMakeCurrent
import android.os.Build
import android.os.Environment
import android.provider.Settings
import androidx.core.content.FileProvider
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.io.File
import java.io.FileInputStream
import java.io.FileOutputStream
import java.io.InputStream
import java.io.OutputStream


class MainActivity : FlutterActivity() {
    private val methodChannel = "wallpaper_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, methodChannel).setMethodCallHandler { call, result ->
            when (call.method) {
                "setWallpaper" -> {
                    val imageUri = call.argument<String>("imageUri")
                    val success = setWallpaper(imageUri = imageUri, context = this)
                    if (success) {
                        result.success(true)
                    } else {
                        result.error("ERROR", "Failed to set wallpaper", null)
                    }
                }
                "permissionsForWallpaper" -> {
                    val isGranted: Boolean = checkPermissionsForWallpaper()
                    if (isGranted) {
                        result.success(true)
                    } else {
                        setPermissionsForWallpaper()
                        result.success(false)
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun setWallpaper(imageUri: String?, context: Context) : Boolean {
        if (imageUri != null) {
            val fileName = "little_paper_cache_image.jpg"

            val success = copyFileToExternalStorage(sourceLocation = imageUri, fileName = fileName)

            if (success) {
                val storageDir =
                    Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES)
                val destLocation = File(storageDir, fileName).path

                // setting wallpaper intent
                // set file for intent
                val wallpaperIntent = Intent(WallpaperManager.ACTION_CROP_AND_SET_WALLPAPER)
                val externalImageUri = FileProvider.getUriForFile(
                    context,
                    context.applicationContext.packageName + ".provider",
                    File(destLocation),
                )
                wallpaperIntent.setDataAndType(externalImageUri, "image/")
                wallpaperIntent.putExtra("mimeType", "image/")
                wallpaperIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION or Intent.FLAG_ACTIVITY_MULTIPLE_TASK)

                return try {
                    startActivity(wallpaperIntent)
                    true
                } catch (e: Exception) {
                    e.printStackTrace()
                    false
                }
            } else {
                return false
            }
        } else {
            return false
        }
    }

    // copy file from cache dir to external storage
    // need for wallpaper manager (fix file not found error)
    private fun copyFileToExternalStorage(sourceLocation: String?, fileName: String): Boolean {
        return try {
            val storageDir = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES)
            if (storageDir != null && storageDir.exists()) {
                val source = File(sourceLocation)
                val destFile = File(storageDir, fileName)

                // delete past file
                if (destFile.exists()) {
                    destFile.delete()
                }

                if (source.exists()) {
                    val src: InputStream = FileInputStream(source)
                    val dst: OutputStream = FileOutputStream(destFile)
                    // Copy the bits from instream to outstream
                    val buf = ByteArray(1024)
                    var len: Int
                    while (src.read(buf).also { len = it } > 0) {
                        dst.write(buf, 0, len)
                    }
                    src.close()
                    dst.close()
                }
            }
            true
        } catch (ex: Exception) {
            ex.printStackTrace()
            false
        }
    }

    private fun checkPermissionsForWallpaper() : Boolean {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R &&
            !Environment.isExternalStorageManager()
        ) {
            // permissions wasn't granted
            return false
        }

        // permissions was granted or android version is lower than R
        return true
    }

    private fun setPermissionsForWallpaper() {
        val intent = Intent(Settings.ACTION_MANAGE_APP_ALL_FILES_ACCESS_PERMISSION)
        val uri = Uri.fromParts("package", packageName, null)
        intent.data = uri

        // start settings with permissions switcher
        startActivity(intent)
    }

}
