// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   VerificaStatusBD.java

package gymstyledb;

import java.io.*;
import java.sql.*;
import java.util.*;

public class VerificaStatusBD
{

    public static VerificaStatusBD getInstance()
    {
        if(instance == null)
        {
            instance = new VerificaStatusBD();
            tableUsuarios = new HashMap();
            tableUsuarios.put(MATRICULA, MATRICULA_SQL);
        }
        return instance;
    }

    private VerificaStatusBD()
    {
    }

    public Boolean analisar(Connection conn)
    {
        if(conn != null)
            try
            {
                int qtdeTabelas = 0;
                Statement stm = conn.createStatement();
                ResultSet rs = stm.executeQuery("SELECT count(tablename) as qtde FROM pg_catalog.pg_tables WHERE schemaname NOT IN ('pg_catalog', 'information_schema', 'pg_toast')");
                if(rs.next())
                    qtdeTabelas = rs.getInt("qtde");
                executeSql(getSqlDataBase(TABLES), conn);
                String aux = getSqlDataBase(TABLES_V1_6);
                executeSql(aux, conn);
                executeSql(getSqlDataBase(TABLES_V1_7), conn);
                executeSql(getSqlDataBase(TABLES_PERMISSOES), conn);
                executeSql(getSqlDataBase(FUNCOES), conn);
                if(qtdeTabelas == 0)
                    executeSql(getSqlDataBase(POVOAMENTO), conn);
                executeSql(getSqlDataBase(POVOAMENTO_V1_6), conn);
                stm = conn.createStatement();
                rs = stm.executeQuery("select * from usuarios");
                Iterator i$ = tableUsuarios.entrySet().iterator();
                do
                {
                    if(!i$.hasNext())
                        break;
                    java.util.Map.Entry entry = (java.util.Map.Entry)i$.next();
                    String coluna = (String)entry.getKey();
                    String sql = (String)entry.getValue();
                    if(!hasColumn(rs, coluna))
                        executeSql(sql, conn);
                } while(true);
                if(!rs.next())
                    executeSql(getSqlDataBase(POVOAMENTO), conn);
                rs = stm.executeQuery("select count(nome) as matricula,(select count(id_usuarios) from usuarios where true) as usuarios from usuarios where true and matricula isnull");
                if(rs.next() && rs.getInt("matricula") == rs.getInt("usuarios"))
                {
                    Statement stm2 = conn.createStatement();
                    ResultSet rs2 = stm2.executeQuery("select id_usuarios from usuarios where true order by id_usuarios");
                    int i = 1;
                    for(; rs2.next(); executeSql((new StringBuilder()).append("UPDATE usuarios SET  matricula = ").append(i++).append(" WHERE id_usuarios=").append(rs2.getInt("id_usuarios")).append(";").toString(), conn));
                }
                return Boolean.valueOf(true);
            }
            catch(SQLException e)
            {
                e.printStackTrace();
            }
        return Boolean.valueOf(false);
    }

    public void executeSql(String sql, Connection conn)
    {
        if(!sql.isEmpty() && conn != null)
            try
            {
                Statement stm = conn.createStatement();
                stm.execute(sql);
            }
            catch(SQLException e)
            {
                e.printStackTrace();
            }
    }

    private boolean hasColumn(ResultSet rs, String columnName)
        throws SQLException
    {
        ResultSetMetaData rsmd = rs.getMetaData();
        int columns = rsmd.getColumnCount();
        for(int x = 1; x <= columns; x++)
            if(columnName.equals(rsmd.getColumnName(x)))
                return true;

        return false;
    }

    public static String getSqlDataBase(String arquivo)
    {
        String sql = "";
        try
        {
            InputStream caminho = null;
            caminho = getInstance().getClass().getResourceAsStream(arquivo);
            BufferedReader br;
            for(br = new BufferedReader(new InputStreamReader(caminho, "UTF-8")); br.ready();)
            {
                String linha = br.readLine();
                sql = (new StringBuilder()).append(sql).append(linha).toString();
            }

            br.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return sql;
    }

    public static void escreve(String aux)
    {
        File arquivo = new File("c:\\log.txt");
        try
        {
            if(!arquivo.exists())
                arquivo.createNewFile();
            FileReader fileR = new FileReader(arquivo);
            BufferedReader buffR = new BufferedReader(fileR);
            String dados;
            for(dados = ""; buffR.ready(); dados = (new StringBuilder()).append(dados).append("\n").toString())
                dados = (new StringBuilder()).append(dados).append(buffR.readLine()).toString();

            buffR.close();
            FileWriter fileW = new FileWriter(arquivo);
            BufferedWriter buffW = new BufferedWriter(fileW);
            buffW.write((new StringBuilder()).append(dados).append(aux).toString());
            buffW.newLine();
            buffW.close();
        }
        catch(IOException io) { }
    }

    private static Map tableUsuarios;
    private static String MATRICULA = "matricula";
    private static String MATRICULA_SQL = "ALTER TABLE usuarios ADD COLUMN matricula bigint";
    public static VerificaStatusBD instance = null;
    public static String TABLES = "GymStyleCreateTables.sql";
    public static String TABLES_V1_6 = "GymStyleCreateTablesV1_6.sql";
    public static String TABLES_V1_7 = "GymStyleCreateTablesV1_7.sql";
    public static String TABLES_PERMISSOES = "GymStyleCreateTablesPermissoes.sql";
    public static String FUNCOES = "GymStyleCreateFuncoes.sql";
    public static String POVOAMENTO = "GymStylePovoamento.sql";
    public static String POVOAMENTO_V1_6 = "GymStylePovoamentoV1_6.sql";
    public static int i = 0;

}
