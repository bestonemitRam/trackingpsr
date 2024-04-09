package com.app.bmitserp.api

import okhttp3.ResponseBody
import retrofit2.http.Body
import retrofit2.http.Header
import retrofit2.http.POST


import retrofit2.Response
import retrofit2.http.Headers


interface ApiService
{
    @Headers("Content-Type: application/json")
    @POST("sales/locationSaver")
    suspend fun saveLocation(
        @Header("user_id") userId: String,
        @Header("user_token") userToken: String,
        @Body locationData: LocationData
    ): Response<ResponseBody>
}