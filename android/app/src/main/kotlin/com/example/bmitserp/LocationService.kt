//package com.example.bmitserp

package com.app.bmitserp







import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.IBinder
import android.service.controls.ControlsProviderService.TAG
import androidx.core.app.NotificationCompat

import com.google.android.gms.location.LocationServices
import io.flutter.Log
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.cancel
import kotlinx.coroutines.flow.catch
import kotlinx.coroutines.flow.launchIn
import kotlinx.coroutines.flow.onEach
import java.io.OutputStreamWriter
import java.net.HttpURLConnection
import java.net.URL

class LocationService: Service()
{

    private val serviceScope = CoroutineScope(SupervisorJob() + Dispatchers.IO)
    private lateinit var locationClient: LocationClient

    override fun onBind(p0: Intent?): IBinder? {
        return null
    }

    override fun onCreate() {
        super.onCreate()
        locationClient = DefaultLocationClient(
            applicationContext,
            LocationServices.getFusedLocationProviderClient(applicationContext)
        )
    }
    var token="";
    var userID ="";
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int
    {
        when(intent?.action)
        {

            ACTION_START -> start()
            ACTION_STOP -> stop()

        }



         token = intent?.getStringExtra("token").toString()
         userID = intent?.getStringExtra("userID").toString()

        println("check  ${token} ${userID}");

        return super.onStartCommand(intent, flags, startId)
    }


    private fun start() {
        Log.d(TAG, "Starting background location tracking...")
        val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

        // Check if the notification channel exists, if not, create it
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O)
        {
            val channel = NotificationChannel(
                "location",
                "Location Service Channel",
                NotificationManager.IMPORTANCE_DEFAULT
            )
            notificationManager.createNotificationChannel(channel)
        }

        val notification = NotificationCompat.Builder(this, "location")
            .setContentTitle("Tracking location...")
            .setContentText("Location: null")
            .setSmallIcon(R.drawable.launch_background)
            .setPriority(NotificationCompat.PRIORITY_DEFAULT) // Set notification priority
            .setOngoing(true)
            .build()
        locationClient
            .getLocationUpdates(1000L)
            .catch { e -> e.printStackTrace() }
            .onEach { location ->
               val userId = userID
                val userToken = token

                val lat = location.latitude.toString()
                val long = location.longitude.toString()

                sendData(location.latitude.toString(), location.longitude.toString(),userId,userToken)

               // val lat = "20.847365"
              // val long ="46.378465"

//                Log.d(TAG, "Latitude:  check data $lat, Longitude: is working properly or not $long")
//
//
//
//                val locationData = LocationData(long,lat )
//                Log.d(TAG, "Latitude:  check data $locationData  fjghkfgh  : $lat, Longitude: is working properly or not $long")
//
//                val userId = userID
//                val userToken = token
//                GlobalScope.launch(Dispatchers.IO)
//                {
//                    try {
//
//                        println("dfjhgdjfh   $userToken  $userId $locationData  $lat ");
//                        println("dfjhgdjfh   $userToken  $userId $locationData  $lat $long ${RetrofitClient.apiService.saveLocation(userId, userToken, locationData)}");
//
//                        Log.d(TAG, "check fdsidhfsdgfuydjsfhgjdfjghj:  api  $userId $userToken, Longitude: is working properly or not $long")
//
//
//                        val response = RetrofitClient.apiService.saveLocation(userId, userToken, locationData)
//                        // Handle response if needed
//
//                        Log.d(TAG, "Latitude:  api response $response, Longitude: is working properly or not $long")
//                        if (response.isSuccessful)
//                        {
//                            // Request successful, handle the response
//                            val responseBody: ResponseBody? = response.body()
//                           // Log.d("susseccc", "susseccc: ${response.message()}")
//                            // Process responseBody
//                        } else
//                        {
//                            // Request failed, handle the error
//                            Log.e("API REQUEST error", "Error: ${response.message()}")
//                        }
//                    } catch (e: Exception)
//                    {
//                        // Handle network or unexpected errors
//                        Log.e("API REQUEST exception", "Error: ${e.message}  $userId, $userToken    ", e)
//
//                    }
//                }

                val updatedNotification = NotificationCompat.Builder(this, "location")
                    .setContentTitle("Tracking location...")
                    .setContentText("Location data: ($lat, $long)")
                    .setSmallIcon(R.drawable.launch_background)
                    .setPriority(NotificationCompat.PRIORITY_DEFAULT) // Set notification priority
                    .setOngoing(true)
                    .build()

                notificationManager.notify(1, updatedNotification)
            }
            .launchIn(serviceScope)


        // Start foreground service
        startForeground(1, notification)
    }


    private fun stop() {
        print("jdhfjkgjdhgf");
        stopForeground(true)
        stopSelf()
    }

    override fun onDestroy() {
        super.onDestroy()
        serviceScope.cancel()
    }

    companion object {
        const val ACTION_START = "ACTION_START"
        const val ACTION_STOP = "ACTION_STOP"
    }





    fun sendData(lat: String, long: String, userId: String, userToken: String)
    {

        println("fjhdgkjfgh  ${userId} ${userToken}  ${lat} $long");
        val url = URL("http://sales.meestdrive.in/api/sales/locationSaver")
        val conn = url.openConnection() as HttpURLConnection

        conn.requestMethod = "POST"
        conn.setRequestProperty("Content-Type", "application/json")
        conn.setRequestProperty("user_id", userId.toString())
        conn.setRequestProperty("user_token", userToken.toString())
        conn.doOutput = true

        val data = """
        {
            "user_longitude": $long,
            "user_latitude": $lat
        }
    """.trimIndent()

        val os = conn.outputStream
        val osw = OutputStreamWriter(os, "UTF-8")
        osw.write(data)
        osw.flush()
        osw.close()

        val responseCode = conn.responseCode
        println("Response Code: $responseCode")

        if (responseCode == HttpURLConnection.HTTP_OK) {
            println("Data sent successfully")
        } else {
            println("Failed to send data. Response Code: $responseCode")
        }

        conn.disconnect()
    }

// Call the function to send data


}

