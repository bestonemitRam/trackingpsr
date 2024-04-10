//package com.app.bmitserp
//
//
//// LocationWorker.kt
//
//import android.content.Context
//import android.util.Log
//import androidx.work.CoroutineWorker
//import androidx.work.Worker
//import androidx.work.WorkerParameters
//import com.google.android.gms.location.LocationServices
//
//class LocationWorker(context: Context, params: WorkerParameters) :
//    CoroutineWorker(context, params) {
//
//    override suspend fun doWork(): Result {
//        try {
//            val fusedLocationClient = LocationServices.getFusedLocationProviderClient(applicationContext)
//
//
//            val location = fusedLocationClient.lastLocation.await()
//            Log.d("LocationWorker", "Location: $location")
//            return Result.success()
//        } catch (e: Exception) {
//            Log.e("LocationWorker", "Failed to get location: ${e.message}", e)
//            return Result.failure()
//        }
//    }
//}
