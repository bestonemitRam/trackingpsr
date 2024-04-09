//package com.example.bmitserp.db
//
//import android.content.ContentValues
//import android.content.Context
//import android.database.Cursor
//import android.database.sqlite.SQLiteDatabase
//import android.database.sqlite.SQLiteOpenHelper
//
//class DBHelper(context: Context) : SQLiteOpenHelper(context, DATABASE_NAME, null, DATABASE_VERSION) {
//
//    companion object {
//        private const val DATABASE_VERSION = 1
//        private const val DATABASE_NAME = "LocationDB"
//        private const val TABLE_NAME = "LocationData"
//        private const val KEY_ID = "id"
//        private const val KEY_LATITUDE = "latitude"
//        private const val KEY_LONGITUDE = "longitude"
//    }
//
//    override fun onCreate(db: SQLiteDatabase) {
//        val createTable = "CREATE TABLE $TABLE_NAME ($KEY_ID INTEGER PRIMARY KEY, $KEY_LATITUDE REAL, $KEY_LONGITUDE REAL)"
//        db.execSQL(createTable)
//    }
//
//    override fun onUpgrade(db: SQLiteDatabase, oldVersion: Int, newVersion: Int) {
//        db.execSQL("DROP TABLE IF EXISTS $TABLE_NAME")
//        onCreate(db)
//    }
//
//    fun insertLocation(latitude: Double, longitude: Double): Long {
//        val db = this.writableDatabase
//        val contentValues = ContentValues()
//        contentValues.put(KEY_LATITUDE, latitude)
//        contentValues.put(KEY_LONGITUDE, longitude)
//        return db.insert(TABLE_NAME, null, contentValues)
//    }
//
//    fun deleteLocation(id: Long): Int {
//        val db = this.writableDatabase
//        return db.delete(TABLE_NAME, "$KEY_ID=?", arrayOf(id.toString()))
//    }
//
//    fun getAllLocations(): ArrayList<LocationData> {
//        val locationList = ArrayList<LocationData>()
//        val selectQuery = "SELECT * FROM $TABLE_NAME"
//        val db = this.readableDatabase
//        val cursor: Cursor? = db.rawQuery(selectQuery, null)
//        cursor?.let {
//            if (cursor.moveToFirst())
//            {
//                do {
//                    val id = cursor.getLong(cursor.getColumnIndex(KEY_ID))
//                    val latitude = cursor.getDouble(cursor.getColumnIndex(KEY_LATITUDE))
//                    val longitude = cursor.getDouble(cursor.getColumnIndex(KEY_LONGITUDE))
//                    val location = LocationData(id, latitude, longitude)
//                    locationList.add(location)
//                } while (cursor.moveToNext())
//            }
//            cursor.close()
//        }
//        return locationList
//    }
//}
//
//data class LocationData(val id: Long, val latitude: Double, val longitude: Double)
