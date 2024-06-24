package com.example.flutter_app_manager

import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class FlutterAppManagerPlugin: FlutterPlugin, MethodCallHandler {
    private lateinit var channel : MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_app_manager")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "getInstalledApps" -> {
                result.success(getInstalledApps())
            }
            "openApp" -> {
                val packageName = call.argument<String>("packageName")
                if (packageName != null) {
                    try {
                        val intent = context.packageManager.getLaunchIntentForPackage(packageName)
                        if (intent != null) {
                            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                            context.startActivity(intent)
                            result.success(true)
                        } else {
                            result.error("APP_NOT_FOUND", "No app found with the given package name", null)
                        }
                    } catch (e: Exception) {
                        result.error("OPEN_FAILED", "Failed to open the app", e.message)
                    }
                } else {
                    result.error("INVALID_ARGUMENT", "Package name is required", null)
                }
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    private fun getInstalledApps(): List<Map<String, String>> {
        val pm = context.packageManager
        val packList = pm.getInstalledPackages(0)
        val installedApps = mutableListOf<Map<String, String>>()

        for (packInfo in packList) {
            val appName = packInfo.applicationInfo.loadLabel(pm).toString()
            val packageName = packInfo.packageName

            installedApps.add(mapOf(
                "packageName" to packageName,
                "name" to appName
            ))
        }

        return installedApps
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}