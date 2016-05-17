// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   ConnectionManager.java

package gymstyledb.model;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionManager
{

    public static ConnectionManager getInstance()
    {
        if(instance == null)
            instance = new ConnectionManager();
        return instance;
    }

    private ConnectionManager()
    {
        url = null;
        driver = null;
        usuario = null;
        senha = null;
        connection = null;
        String porta = "5432";
        senha = "postgres";
        usuario = "postgres";
        String banco = "GymStyleDB";
        String host = "localhost";
        driver = "org.postgresql.Driver";
        url = (new StringBuilder()).append("jdbc:postgresql://").append(host).append(":").append(porta).append("/").append(banco).append("/").toString();
    }

    public Connection getConnection()
    {
        try
        {
            if(connection == null || connection.isClosed())
            {
                Class.forName(driver);
                connection = DriverManager.getConnection(url, usuario, senha);
            }
            if(!connection.getAutoCommit())
                connection.setAutoCommit(true);
        }
        catch(Exception ex) { }
        return connection;
    }

    private String url;
    private String driver;
    private String usuario;
    private String senha;
    private Connection connection;
    private static ConnectionManager instance = null;

}
