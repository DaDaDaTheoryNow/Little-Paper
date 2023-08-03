package com.dadadadev.little_paper

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import android.widget.Toast

class WallpaperPermissionManager(private val context: Context) {

    fun requiredPermission() : Boolean {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R &&
                !android.os.Environment.isExternalStorageManager()
        ) {
            Toast.makeText(context, "You have not given all permissions!", Toast.LENGTH_SHORT).show()
            setPermission()
            return false
        }
        return true
    }


    private fun setPermission() {
        val intent = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            Intent(Settings.ACTION_MANAGE_APP_ALL_FILES_ACCESS_PERMISSION)
        } else {
            throw UnsupportedOperationException("VERSION.SDK_INT < R")
        }
        val uri = Uri.fromParts("package", context.packageName, null)
        intent.data = uri

        context.startActivity(intent)
    }

}