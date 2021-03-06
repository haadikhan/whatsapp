package com.example.app_tracker

import android.app.AppOpsManager
import android.app.usage.UsageStats
import android.app.usage.UsageStatsManager
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.os.Process
import android.provider.Settings
import android.util.ArrayMap
import android.util.Log
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result
import java.util.*
import kotlin.collections.ArrayList
import kotlin.time.ExperimentalTime


class MainActivity: FlutterActivity() {
    private val channel = "getUsageDataChannel"
    private var usageStatsManager : UsageStatsManager? = null
    private var mPm : PackageManager? = null
    private var granted: Boolean = false

    @ExperimentalTime
    @RequiresApi(Build.VERSION_CODES.Q)
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger, channel).setMethodCallHandler {
                call, result ->
            when(call.method){
                "CheckPermission" -> result.success(checkPermission())
                "GetPermission" -> {
                    if(!checkPermission()){
                        val intent = Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS)
                        startActivityForResult(intent, 1)
                    } else {
                        result.success(true)
                    }
                }
                "GetData" -> {
                    val days = call.argument<Int>("days")
                    getData(result, days!!)
                }
                else ->{
                    result.notImplemented()
                }
            }
        }
    }


    @ExperimentalTime
    @RequiresApi(Build.VERSION_CODES.Q)
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler {
                call, result ->
                when(call.method){
                    "CheckPermission" -> result.success(checkPermission())
                    "GetPermission" -> {
                        val intent = Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS)
                        startActivityForResult(intent, 1)
                    }
                    "GetData" -> {
                        val days = call.argument<Int>("days")
                        getData(result, days!!)
                    }
                    else ->{
                        result.notImplemented()
                    }
            }
        }
    }

    @RequiresApi(Build.VERSION_CODES.M)
    @ExperimentalTime
    private fun checkPermission() : Boolean {
        if(ActivityCompat.checkSelfPermission(this, android.Manifest.permission.PACKAGE_USAGE_STATS) != PackageManager.PERMISSION_GRANTED){
                    val appOps = context
                .getSystemService(Context.APP_OPS_SERVICE) as AppOpsManager
            val mode = appOps.checkOpNoThrow(
                AppOpsManager.OPSTR_GET_USAGE_STATS,
                Process.myUid(), context.packageName
            )
            return if (mode == AppOpsManager.MODE_DEFAULT) {
                granted
            } else {
                granted = (mode == AppOpsManager.MODE_ALLOWED)
                granted
            }
        } else {
            return true
        }
    }


    @ExperimentalTime
    @RequiresApi(Build.VERSION_CODES.Q)
    private fun  getData(methodCall: Result, days: Int) {
//        val mAppLabelMap = ArrayMap<String, String>()
//        val mPackageStats = ArrayList<UsageStats>()
        mPm = packageManager
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP_MR1) {
            usageStatsManager = getSystemService(USAGE_STATS_SERVICE) as UsageStatsManager
        }
        val cal = Calendar.getInstance()
        Log.e("Calender", cal.toString())
        cal.add(Calendar.DAY_OF_YEAR, -days)
        Log.e("Calender", cal.toString())
        val stats = if(days == 1) {
            usageStatsManager!!.queryUsageStats(
                UsageStatsManager.INTERVAL_BEST,
                cal.timeInMillis, System.currentTimeMillis()
            )
        } else {
            usageStatsManager!!.queryUsageStats(
                UsageStatsManager.INTERVAL_WEEKLY,
                cal.timeInMillis, System.currentTimeMillis()
            )
        }
        val map = ArrayMap<String, UsageStats>()
        val statCount = stats!!.size
        val packageStatsMap = ArrayList<String>()
        for (i in 0 until statCount) {
            val pkgStats = stats[i]

            try {
                val appInfo = mPm!!.getApplicationInfo(pkgStats.packageName, 0)
                val label = appInfo.loadLabel(mPm!!).toString()

                if(checkLabel(label)){
                    packageStatsMap.add(label);
                    packageStatsMap.add(pkgStats.totalTimeInForeground.toString())
                }

//                mAppLabelMap[pkgStats.packageName] = label
//                val existingStats = map[pkgStats.packageName]
//                if (existingStats == null) {
//                    map[pkgStats.packageName] = pkgStats
//                } else {
//                    existingStats.add(pkgStats)
//                }
            } catch (e: PackageManager.NameNotFoundException) {
                // This package may be gone.
            }
        }
//        mPackageStats.addAll(map.values)

//        repeat(mPackageStats.size){
//            packageStatsMap.add(mPackageStats[it].packageName)
//            packageStatsMap.add(mPackageStats[it].totalTimeForegroundServiceUsed.toString())

//            packageStatsMap[mPackageStats[it].packageName] = mPackageStats[it].totalTimeForegroundServiceUsed.toString()
//        }
        methodCall.success(packageStatsMap)
    }

    private fun getTime(milliseconds : Long) : String {
        val seconds = (milliseconds / 1000)  % 60
        val minutes = (milliseconds / (1000 * 60) % 60)
        val hours = (milliseconds / (1000 * 60 * 60) % 24)
        return "${hours}: ${minutes}:$seconds"
    }


    private fun checkLabel(label: String) : Boolean {
        return when(label) {
            "YouTube" -> true
            "WhatsApp" -> true
            "Facebook" -> true
            "Snapchat" -> true
            "Instagram" -> true
            else -> false
        }
    }

}
