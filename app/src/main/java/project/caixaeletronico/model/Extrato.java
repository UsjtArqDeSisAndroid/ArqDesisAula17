package project.caixaeletronico.model;

import java.io.Serializable;

/**
 * Created by Maael on 12/09/2016.
 */
public class Extrato {

    private String tipoMovimentacao;
    private int tipo;
    private double valorMovimentacao;
    private double saldoAtual;
    private String dataMovimentacao;

    public Extrato(String tipoMovimentacao, int tipo, double valorMovimentacao, double saldoAtual, String dataMovimentacao) {
        this.tipoMovimentacao = tipoMovimentacao;
        this.tipo = tipo;
        this.valorMovimentacao = valorMovimentacao;
        this.saldoAtual = saldoAtual;
        this.dataMovimentacao = dataMovimentacao;
    }

    public Extrato() {
    }

    public String getTipoMovimentacao() {
        return tipoMovimentacao;
    }

    public void setTipoMovimentacao(String tipoMovimentacao) {
        this.tipoMovimentacao = tipoMovimentacao;
    }

    public int getTipo() {
        return tipo;
    }

    public void setTipo(int tipo) {
        this.tipo = tipo;
    }

    public double getValorMovimentacao() {
        return valorMovimentacao;
    }

    public void setValorMovimentacao(double valorMovimentacao) {
        this.valorMovimentacao = valorMovimentacao;
    }

    public double getSaldoAtual() {
        return saldoAtual;
    }

    public void setSaldoAtual(double saldoAtual) {
        this.saldoAtual = saldoAtual;
    }

    public String getDataMovimentacao() {
        return dataMovimentacao;
    }

    public void setDataMovimentacao(String dataMovimentacao) {
        this.dataMovimentacao = dataMovimentacao;
    }

    @Override
    public String toString() {
        return "package project.caixaeletronico.model.Extrato{" +
                "Tipo Movimentacao = '" + tipoMovimentacao + '\'' +
                ", Tipo Cred/Deb = '" + tipo + '\'' +
                ", Valor Movimentacao = '" + valorMovimentacao+ '\'' +
                ", SaldoAtual = '" + saldoAtual + '\'' +
                ", Data Movimentacao = '" + dataMovimentacao + '\'' +
                '}';
    }

   /* @Override
    public int compareTo(Extrato cerveja) {
        if (tipoMovimentacao.equals(cerveja.getDataMovimentacao())
                && tipo == cerveja.getTipo()
                && valorMovimentacao == cerveja.getValorMovimentacao()
                && saldoAtual == cerveja.getSaldoAtual()
                && dataMovimentacao.equals(cerveja.getDataMovimentacao())) {
            return 0;
        }
        return this.getDataMovimentacao().compareTo(cerveja.getDataMovimentacao());
    }*/
}
