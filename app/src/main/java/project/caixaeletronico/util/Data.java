package project.caixaeletronico.util;

import project.caixaeletronico.model.Extrato;

/**
 * Created by Maael on 06/11/2016.
 */
public class Data {
    public static Extrato[] _lista;

    public static Extrato[] geraListaExtrato(){
        if(_lista == null) {
            Extrato[] lista = new Extrato[21];
            lista[0] = new Extrato("1", 2, 250.00, 5000.00, "01.11.2016");
            lista[1] = new Extrato("2", 1, 350.00, 4850.00, "01.11.2016");
            lista[2] = new Extrato("3", 1, 150.00, 4820.00, "01.11.2016");
            lista[3] = new Extrato("4", 2, 200.00, 1169.00, "02.11.2016");
            lista[4] = new Extrato("1", 1, 370.00, 4097.00, "02.11.2016");
            lista[5] = new Extrato("2", 2, 400.00, 5000.00, "02.11.2016");
            lista[6] = new Extrato("3", 1, 120.00, 328.00, "03.11.2016");
            lista[7] = new Extrato("4", 2, 255.00, 4792.00, "03.11.2016");
            lista[8] = new Extrato("1", 1, 170.00, 5646.00, "03.11.2016");
            lista[9] = new Extrato("2", 2, 80.00, 4569.00, "04.11.2016");
            lista[10] = new Extrato("3", 2, 87.00, 9456.00, "04.11.2016");
            lista[11] = new Extrato("4", 1, 60.00, 6211.00, "04.11.2016");
            lista[12] = new Extrato("1", 2, 57.00, 5841.00, "05.11.2016");
            lista[13] = new Extrato("2", 1, 325.00, 9874.00, "05.11.2016");
            lista[14] = new Extrato("3", 2, 144.00, 5614.00, "05.11.2016");
            lista[15] = new Extrato("4", 1, 136.00, 5674.00, "05.11.2016");
            lista[16] = new Extrato("1", 2, 132.00, 1236.00, "06.11.2016");
            lista[17] = new Extrato("2", 1, 564.00, 8511.00, "06.11.2016");
            lista[18] = new Extrato("3", 2, 636.00, 4566.00, "06.11.2016");
            lista[19] = new Extrato("4", 1, 863.00, 9891.00, "06.11.2016");
            lista[20] = new Extrato("1", 1, 800.00, 9281.00, "06.11.2016");
            _lista = lista;
        }
        return _lista;
    }

    public static Extrato[] buscaExtrato(){
        Extrato[] lista = geraListaExtrato();
            return lista;
    }
}
