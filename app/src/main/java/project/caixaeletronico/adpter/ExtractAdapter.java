package project.caixaeletronico.adpter;

import android.app.Activity;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.SectionIndexer;
import android.widget.TextView;

import java.text.NumberFormat;
import java.util.Hashtable;
import java.util.List;
import java.util.Locale;

import project.caixaeletronico.R;
import project.caixaeletronico.model.Extrato;
import project.caixaeletronico.util.ViewHolder;

/**
 * Created by asbonato on 9/6/15.
 */
public class ExtractAdapter extends BaseAdapter implements SectionIndexer {
    Activity context;
    List<Extrato> extratos;
    Object[] sectionHeaders;
    Hashtable<Integer, Integer> positionForSectionMap;
    Hashtable<Integer, Integer> sectionForPositionMap;

    public ExtractAdapter(Activity context, List<Extrato> extratos) {
        this.context = context;
        this.extratos = extratos;
        sectionHeaders = SectionIndexBuilder.BuildSectionHeaders(extratos);
        positionForSectionMap = SectionIndexBuilder.BuildPositionForSectionMap(extratos);
        sectionForPositionMap = SectionIndexBuilder.BuildSectionForPositionMap(extratos);

    }

    @Override
    public int getCount() {
        return extratos.size();
    }

    @Override
    public Object getItem(int position) {
        if (position >= 0 && position < extratos.size())
            return extratos.get(position);
        else
            return null;
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        //o list view recicla os layouts para melhor performance
        //o layout reciclado vem no parametro convert view
        View view = convertView;
        //se nao recebeu um layout para reutilizar deve inflar um
        if (view == null) {
            //um inflater transforma um layout em uma view
            LayoutInflater inflater = (LayoutInflater) context.getSystemService
                    (Context.LAYOUT_INFLATER_SERVICE);
            view = inflater.inflate(R.layout.extract_line, parent, false);

            TextView tipoMovimentacao = (TextView) view.findViewById(R.id.tipoMovimentacao);
            TextView tipoDebCred = (TextView) view.findViewById(R.id.tipoDebCred);
            TextView valorMovimentacao = (TextView) view.findViewById(R.id.valorMovimentacao);
            TextView saldoAtual = (TextView) view.findViewById(R.id.saldoAtual);
            TextView dataMovimentacao = (TextView) view.findViewById(R.id.dataMov);
            //faz cache dos widgets instanciados na tag da view para reusar quando houver reciclagem
            view.setTag(new ViewHolder(tipoMovimentacao, tipoDebCred, valorMovimentacao, saldoAtual, dataMovimentacao));
        }
        //usa os widgets cacheados na view reciclada
        ViewHolder holder = (ViewHolder) view.getTag();
        //carrega os novos valores
        Locale locale = new Locale("pt", "BR");
        NumberFormat formatter = NumberFormat.getCurrencyInstance(locale);
        holder.getTipoMov().setText(extratos.get(position).getTipoMovimentacao());
        holder.getTipoDebCred().setText(extratos.get(position).getTipo() + "");
        holder.getValorMov().setText(extratos.get(position).getValorMovimentacao() + "");
        holder.getSaldoAtual().setText(extratos.get(position).getSaldoAtual() + "");
        holder.getDataMov().setText(extratos.get(position).getDataMovimentacao());

        return view;
    }

    //metodos da interface SectionIndexer
    @Override
    public Object[] getSections() {
        return sectionHeaders;
    }

    @Override
    public int getPositionForSection(int sectionIndex) {
        return positionForSectionMap.get(sectionIndex).intValue();
    }

    @Override
    public int getSectionForPosition(int position) {
        return sectionForPositionMap.get(position).intValue();
    }

    public void updateExtractList(List<Extrato> newlist) {
        extratos.clear();
        extratos.addAll(newlist);
        this.notifyDataSetChanged();
    }


}
