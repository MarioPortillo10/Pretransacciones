using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de bitacora
/// </summary>
public class bitacora
{
    public bitacora()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }





    public void AgregaBitacora(string Descripcion, int cod_usuario) {


        string ConnectionString = ConfigurationManager.AppSettings["ConnStr_LEVERANS_prod"];



        // Add en bitacora la acción
        using (SqlConnection con = new SqlConnection(ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("INSERT INTO [LEVERANS_Bitacora] ([Descripcion],[Fk_usuario]) VALUES (@descripcion,@cod_usuario);", con))
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@cod_usuario", cod_usuario);
                cmd.Parameters.AddWithValue("@descripcion", Descripcion);
                con.Open();

                cmd.ExecuteNonQuery();
            }
        }
    }





    
}