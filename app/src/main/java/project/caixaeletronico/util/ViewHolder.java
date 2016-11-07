package project.caixaeletronico.util;

import android.widget.ImageView;
import android.widget.TextView;

/**
 * Created by Maael on 06/11/2016.
 */

public class ViewHolder {

    private TextView tipoMov;
    private TextView tipoDebCred;
    private TextView valorMov;
    private TextView saldoAtual;
    private TextView dataMov;


    public ViewHolder(TextView tipoMov, TextView tipoDebCred, TextView valorMov, TextView saldoAtual, TextView dataMov) {
        this.tipoMov = tipoMov;
        this.tipoDebCred = tipoDebCred;
        this.valorMov = valorMov;
        this.saldoAtual = saldoAtual;
        this.dataMov = dataMov;
    }

    public TextView getTipoMov() {
        return tipoMov;
    }

    public void setTipoMov(TextView tipoMov) {
        this.tipoMov = tipoMov;
    }

    public TextView getTipoDebCred() {
        return tipoDebCred;
    }

    public void setTipoDebCred(TextView tipoDebCred) {
        this.tipoDebCred = tipoDebCred;
    }

    public TextView getValorMov() {
        return valorMov;
    }

    public void setValorMov(TextView valorMov) {
        this.valorMov = valorMov;
    }

    public TextView getSaldoAtual() {
        return saldoAtual;
    }

    public void setSaldoAtual(TextView saldoAtual) {
        this.saldoAtual = saldoAtual;
    }

    public TextView getDataMov() {
        return dataMov;
    }

    public void setDataMov(TextView dataMov) {
        this.dataMov = dataMov;
    }

}

