package project.caixaeletronico.activity;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;

import project.caixaeletronico.R;

public class AccountActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_account);
    }

    public void extractActivity(View view) {

        Intent intent = new Intent(this, ExtractActivity.class);

        startActivity(intent);

    }

    public void transferActivity(View view) {

        Intent intent = new Intent(this, TransferActivity.class);

        startActivity(intent);

    }

}
