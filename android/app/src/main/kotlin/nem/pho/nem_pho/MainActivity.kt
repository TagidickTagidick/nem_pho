package nem.pho.nem_pho

import android.util.Log
import androidx.annotation.NonNull
import com.google.android.gms.tasks.OnCompleteListener
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import ru.rustore.sdk.core.tasks.OnCompletionListener
import ru.rustore.sdk.core.tasks.Task
import ru.rustore.sdk.install.referrer.InstallReferrerClient
import ru.rustore.sdk.install.referrer.model.InstallReferrer
import kotlin.coroutines.cancellation.CancellationException

class MainActivity: FlutterActivity() {
    private val CHANNEL = "samples.flutter.dev/battery"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "getBatteryLevel") {
                CoroutineScope(Dispatchers.Main).launch {
                    try {
                        Log.d("тест1", "тест1")
                        val installReferrer = getInstallReferrer()
                        Log.d("тест3", "тест3 $installReferrer")
                        result.success(installReferrer?.referrerId.toString())
                        Log.d("тест4", "тест4")
                    } catch (e: CancellationException) {
                        result.success(e.toString())
                    }
                }
            } else {
                result.notImplemented()
            }
            // This method is invoked on the main thread.
            // TODO
        }
    }

    private suspend fun getInstallReferrer(): InstallReferrer? {
        return withContext(Dispatchers.IO) {
            val client = InstallReferrerClient(context)
            val task: Task<InstallReferrer?> = client.getInstallReferrer()
            task.await()
        }
    }
}
