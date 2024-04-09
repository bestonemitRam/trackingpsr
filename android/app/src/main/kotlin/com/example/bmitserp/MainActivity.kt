package com.app.bmitserp

import android.Manifest
import android.content.Intent
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import androidx.work.PeriodicWorkRequestBuilder
import androidx.work.WorkManager

import io.flutter.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.concurrent.TimeUnit

class MainActivity: FlutterActivity()
{
    private val CHANNEL = "location_channel"
    private val TAG = "BackgroundLocationService"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {

        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL).setMethodCallHandler { call, result ->
            when (call.method)
            {
                "startBackgroundLocation" ->
                {

                    val token = call.argument<String>("token")
                    val userID = call.argument<String>("userID")

                    // startBackgroundLocation()
                    Log.d(TAG, "Starting background location tracking")
                    ActivityCompat.requestPermissions(
                        this,
                        arrayOf(
                            Manifest.permission.ACCESS_COARSE_LOCATION,
                            Manifest.permission.ACCESS_FINE_LOCATION,
                        ),
                        0
                    )
                    Log.d(TAG, "Starting background location tracking")
                    if (token != null && userID != null) {
                        // Handle token and userID here

                        Intent(applicationContext, LocationService::class.java).apply {
                            action = LocationService.ACTION_START
                            putExtra("token", "${token}")
                            putExtra("userID", "${userID}")
                            startService(this)

                        }
                        println("Received token: $token, userID: $userID")
                    } else {
                        println("Token or userID is null")
                    }




                    result.success(null)
                }
                "stopService" ->
                {
                    // Stop your service here
                    Intent(applicationContext, LocationService::class.java).apply {
                        action = LocationService.ACTION_STOP
                        putExtra("token", "0")
                        putExtra("userID", "0")
                        startService(this)
                    }

                    //  result.success(null)
                }
                else -> {
                    result.notImplemented()
                }

            }
        }
    }

    private fun startBackgroundLocation()
    {
//        Log.d(TAG, "Starting background location tracking")
//
//        val locationWorker = PeriodicWorkRequestBuilder<LocationWorker>(15, TimeUnit.MINUTES)
//            .build()
//
//        WorkManager.getInstance(applicationContext).enqueue(locationWorker)
    }
}
