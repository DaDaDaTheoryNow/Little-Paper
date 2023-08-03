package com.dadadadev.little_paper

import android.app.WallpaperManager
import android.content.ClipData
import android.content.Context
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.os.Environment
import androidx.core.content.FileProvider
import java.io.File
import java.io.FileOutputStream


class WallpaperManager(private val context: Context) {

     fun setWallpaper(imageBytes: ByteArray?) : Boolean {
        if (imageBytes != null) {
            val imageFromBytes = imageFromBytes(imageBytes = imageBytes)

            if (imageFromBytes != null) {
                val wallpaperIntent = Intent(WallpaperManager.ACTION_CROP_AND_SET_WALLPAPER)
                val imageFromBytesUri = FileProvider.getUriForFile(
                        context,
                        context.applicationContext.packageName + ".provider",
                        imageFromBytes,
                )
                wallpaperIntent.setDataAndType(imageFromBytesUri, "image/")
                wallpaperIntent.putExtra("mimeType", "image/")
                wallpaperIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION or Intent.FLAG_ACTIVITY_MULTIPLE_TASK)

                return try {
                    context.startActivity(wallpaperIntent)
                    true
                } catch (e: Exception) {
                    e.printStackTrace()
                    false
                }
            }
            return false
        }
         return false
    }

    fun shareWallpaper(imageBytes: ByteArray?) : Boolean {
        if (imageBytes != null) {
            val imageFromBytes = imageFromBytes(imageBytes = imageBytes)

            if (imageFromBytes != null) {
                val shareIntent = Intent(Intent.ACTION_SEND)
                val imageFromBytesUri = FileProvider.getUriForFile(
                        context,
                        context.applicationContext.packageName + ".provider",
                        imageFromBytes,
                )
                shareIntent.type = "image/"
                shareIntent.putExtra(Intent.EXTRA_STREAM, imageFromBytesUri)
                shareIntent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION or Intent.FLAG_ACTIVITY_MULTIPLE_TASK)
                shareIntent.clipData = ClipData.newRawUri("", imageFromBytesUri)

                val chooserIntent = Intent.createChooser(shareIntent, "Share Image")

                return try {
                    context.startActivity(chooserIntent)
                    true
                } catch (e: Exception) {
                    e.printStackTrace()
                    false
                }
            }
            return false
        }
        return false
    }

    // compress bytes to image in external storage
    private fun imageFromBytes(imageBytes: ByteArray) : File? {
        val fileName = "little_paper_cache_image.jpg"

         try {
            val picturesDir = Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_PICTURES)

             if (!picturesDir.exists()) {
                 picturesDir.mkdirs()
             }

             val destinationFile = File(picturesDir, fileName)

             // set bitmap
             val bitmap = BitmapFactory.decodeByteArray(imageBytes, 0, imageBytes.size)
             // set output stream to destination image
             val outputStream = FileOutputStream(destinationFile)
             // compress bytes to destination image
             bitmap.compress(Bitmap.CompressFormat.JPEG, 100, outputStream)
             return destinationFile
        } catch (ex: Exception) {
             ex.printStackTrace()
             return null
        }
    }

}