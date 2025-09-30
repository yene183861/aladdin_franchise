package jsc.aladdin.aladdin_franchise

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.os.Handler
import android.os.Looper
import java.io.BufferedReader
import java.io.InputStreamReader

class MainActivity : FlutterActivity() {
    companion object {
        private const val CHANNEL = "native_ping"
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "ping") {
                    val ip: String? = call.argument("ip")
                    Thread {
                        val success = ip?.let { ping(it) } ?: false
                        Handler(Looper.getMainLooper()).post {
                            result.success(success)
                        }
                    }.start()
                } else {
                    result.notImplemented()
                }
            }
    }

    private fun ping(ip: String): Boolean {
        var process: Process? = null
        var success = false
        try {
            process = Runtime.getRuntime().exec("/system/bin/ping -c 4 -W 1 $ip")
            BufferedReader(InputStreamReader(process.inputStream)).use { reader ->
                var line: String?
                while (reader.readLine().also { line = it } != null) {
                    if (line!!.contains("bytes from") || line!!.contains("ttl=")) {
                        success = true
                        break
                    }
                }
            }
            process.waitFor()
        } catch (e: Exception) {
            e.printStackTrace()
        } finally {
            process?.destroy()
        }
        return success
    }
}
