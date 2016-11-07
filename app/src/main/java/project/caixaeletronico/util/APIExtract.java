package project.caixaeletronico.util;

import java.util.List;

import project.caixaeletronico.activity.ExtractActivity;
import retrofit.Callback;
import retrofit.RestAdapter;
import retrofit.client.OkClient;
import retrofit.http.GET;

public class APIExtract {
    private static RestAdapter REST_ADAPTER;
    private static void createAdapterIfNeeded() {
        if (REST_ADAPTER == null) {
            REST_ADAPTER = new RestAdapter.Builder()
                    .setEndpoint(
                            "http://www.qpainformatica.com.br/exemplorest/rest")
                    .setLogLevel(RestAdapter.LogLevel.FULL)
                    .setClient(new OkClient())
                    .build();
        }
    }
    public APIExtract() {
        createAdapterIfNeeded();
    }
    public RestServices getRestService() {
        return REST_ADAPTER.create(RestServices.class);
    }
    public interface RestServices {
        @GET("/extract")
        void getExtract(Callback<List<ExtractActivity>> callbackExtract);
    }
}

