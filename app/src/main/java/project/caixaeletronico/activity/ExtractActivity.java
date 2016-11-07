package project.caixaeletronico.activity;

import android.app.DatePickerDialog;
import android.app.Dialog;
import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.BaseAdapter;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.Toast;

import project.caixaeletronico.util.APIExtract;
import retrofit.Callback;
import retrofit.RetrofitError;
import retrofit.client.Response;

import project.caixaeletronico.adpter.ExtractAdapter;
import project.caixaeletronico.util.Data;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import project.caixaeletronico.R;
import project.caixaeletronico.model.Extrato;
import project.caixaeletronico.servelet.ExtractRequester;

public class ExtractActivity extends AppCompatActivity {

    //DatePicker
    private EditText edt_fromDate;
    private EditText edt_toDate;
    private ImageButton btn_fromDate;
    private ImageButton btn_toDate;
    private Calendar startDate;
    private Calendar endDate;
    private EditText activeDateDisplay;
    private Calendar activeDate;
    boolean flag = false;
    static final int DATE_DIALOG_ID = 0;

    // ShowHide LinearLayoutDate
    private LinearLayout linearLayout;

    // Para o REST
    Callback callbackExtract;
    ExtractAdapter adapter;
    ExtractRequester requester;
    private final String RECURSO = "/extract";
    String chave = "?chave=7";
    public static final String LISTA = "package project.caixaeletronico.lista";

    // ArrayExtract
    List<Extrato> listExtract;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_extract);

        //listExtract = new ArrayList<Extrato>();
        configurarCallbackExtract();

        /*  capture our View elements for the start date function   */
        edt_fromDate = (EditText) findViewById(R.id.edt_fromDate);
        btn_fromDate = (ImageButton) findViewById(R.id.btn_fromData_calendar);

        /* get the current date */
        startDate = Calendar.getInstance();

        /* add a click listener to the button   */
        btn_fromDate.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                showDateDialog(edt_fromDate, startDate);
            }
        });

        /* capture our View elements for the end date function */
        edt_toDate = (EditText) findViewById(R.id.edt_toDate);
        btn_toDate = (ImageButton) findViewById(R.id.btn_toData_calendar);

        /* get the current date */
        endDate = Calendar.getInstance();

        /* add a click listener to the button   */
        btn_toDate.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                showDateDialog(edt_toDate, endDate);
            }
        });

        /* display the current date (this method is below)  */
        updateDisplay(edt_fromDate, startDate);
        updateDisplay(edt_toDate, endDate);

        new APIExtract().getRestService().getExtract(callbackExtract);
    }

    private void updateDisplay(EditText dateDisplay, Calendar date) {

        int day = date.get(Calendar.DAY_OF_MONTH);
        int month = date.get(Calendar.MONTH);
        int year = date.get(Calendar.YEAR);

        String builderDate = (day < 10 ? ("0" + day) : (day)) + "/" + (month < 10 ? ("0" + month) : (month)) + "/" + year;

        dateDisplay.setText(builderDate);
    }

    public void showDateDialog(EditText dateDisplay, Calendar date) {
        activeDateDisplay = dateDisplay;
        activeDate = date;
        showDialog(DATE_DIALOG_ID);
    }

    private DatePickerDialog.OnDateSetListener dateSetListener = new DatePickerDialog.OnDateSetListener() {
        @Override
        public void onDateSet(DatePicker view, int year, int monthOfYear, int dayOfMonth) {
            activeDate.set(Calendar.YEAR, year);
            activeDate.set(Calendar.MONTH, monthOfYear);
            activeDate.set(Calendar.DAY_OF_MONTH, dayOfMonth);
            updateDisplay(activeDateDisplay, activeDate);
            unregisterDateDisplay();
        }
    };

    private void unregisterDateDisplay() {
        activeDateDisplay = null;
        activeDate = null;
    }

    @Override
    protected Dialog onCreateDialog(int id) {
        switch (id) {
            case DATE_DIALOG_ID:
                return new DatePickerDialog(this, dateSetListener, activeDate.get(Calendar.YEAR), activeDate.get(Calendar.MONTH), activeDate.get(Calendar.DAY_OF_MONTH));
        }
        return null;
    }

    @Override
    protected void onPrepareDialog(int id, Dialog dialog) {
        super.onPrepareDialog(id, dialog);
        switch (id) {
            case DATE_DIALOG_ID:
                ((DatePickerDialog) dialog).updateDate(activeDate.get(Calendar.YEAR), activeDate.get(Calendar.MONTH), activeDate.get(Calendar.DAY_OF_MONTH));
                break;
        }
    }

    private void configurarCallbackExtract() {
        callbackExtract = new Callback<List<Extrato>>() {

            @Override
            public void success(List<Extrato> lista, Response response) {
                if(response.getStatus()==200) {
                    adapter.updateExtractList(lista);
                } else {
                    Toast.makeText (
                            ExtractActivity.this, "Falha na comunicação com o servidor!", Toast.LENGTH_LONG).show();
                }
            }
            @Override
            public void failure(RetrofitError error) {
                Toast.makeText(
                        ExtractActivity.this, "Falha na comunicação com o servidor!", Toast.LENGTH_LONG).show();
                Log.e("RETROFIT", "Error:"+error.getMessage());
            }
        };
    }

    // Consult Extract into seven days
    public void extractSevenDays(View view) {
        showExtractOnListView();
    }

    // Consult Extract into seven days
    public void extractFifteenDays(View view) {
        showExtractOnListView();
    }

    // Consult Extract into seven days
    public void consultPeriodExtract(View view) {
        showExtractOnListView();
    }

    public  void showExtractOnListView() {

        requester = new ExtractRequester();
        if(requester.isConnected(this)) {
            new Thread(new Runnable() {
                @Override
                public void run() {
                    try {
                        listExtract = requester.get(LoginActivity.SERVIDOR + LoginActivity.APLICACAO + RECURSO, chave);
                        runOnUiThread(new Runnable(){
                            @Override
                            public void run(){
                                adapter = new ExtractAdapter(this, listExtract.toArray(new Extrato[0]));
                                ListView listView = (ListView) findViewById(R.id.lsv_extract);
                                listView.setAdapter(adapter);
                            }
                        });
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }).start();
        } else {
            Toast toast = Toast.makeText(this, "Rede indisponível", Toast.LENGTH_LONG);
            toast.show();
        }


        /*//Extrato[] lista = Data.buscaExtrato();
        adapter = new ExtractAdapter(this, listExtract);
        ListView listView = (ListView) findViewById(R.id.lsv_extract);
        listView.setAdapter(adapter);*/
    }

    public void showHideLinearDateFilter(View view) {

        linearLayout = (LinearLayout) findViewById(R.id.date_filter);

        if (flag) {

            linearLayout.setVisibility(View.GONE);
            flag = false;
        } else {

            //linearLayout.getLayoutParams().height = 160;
            //linearLayout.getLayoutParams().width = 700;

            linearLayout.setVisibility(View.VISIBLE);
            flag = true;
        }
    }

}

