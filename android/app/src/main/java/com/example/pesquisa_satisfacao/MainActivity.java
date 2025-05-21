package com.example.pesquisa_satisfacao;

import android.os.Bundle;
import android.util.Log;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "pesquisa.satisfacao/resultado";

    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("registrarNota")) {
                                int nota = call.argument("nota");
                                Log.d("PesquisaSatisfacao", "Nota recebida: " + nota);
                                result.success(null);
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }
}
