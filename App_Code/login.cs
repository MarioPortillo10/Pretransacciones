using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de login
/// </summary>
public class login
{
    public login()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }



    public int verificacion(string usuario, string contraseña)
    {

        int resultado = 0;

        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnStr_LEVERANS_prod"]))
        {


            using (SqlCommand cmd = new SqlCommand("sp_loginBascula", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@usuario", SqlDbType.VarChar, 50).Value = usuario;
                cmd.Parameters.Add("@contraseña", SqlDbType.VarChar, 50).Value = contraseña;
                con.Open();
                //busca usuario y contrasena. 
                resultado = Convert.ToInt16(cmd.ExecuteScalar());


            }
        }
        return resultado;

    }


    public int rol(int cod_usuario)
    {
        int resultado = 0;

        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnStr_LEVERANS_prod"]))
        {

            using (SqlCommand cmd = new SqlCommand("select Fk_rol from [dbo].[LEVERANS_UsuariosBascula] where Pk_Usuario="+ cod_usuario, con))
            {

                con.Open();
                //busca usuario y contrasena. 
                var get_x = cmd.ExecuteScalar();

                if (get_x != null)
                {
                    resultado = Convert.ToInt32(get_x);
                }
            }
        }

        return resultado;

    }



    public void ActualizarContraseña(int cod_usuario, string pass)
    {

        string ConnectionString = ConfigurationManager.AppSettings["ConnStr_LEVERANS_prod"];

        using (SqlConnection con02 = new SqlConnection(ConnectionString))
        {
            using (SqlCommand cmd02 = new SqlCommand("sp_LEVERANS_UsuariosBasculaUpdate", con02))
            {
                cmd02.CommandType = CommandType.StoredProcedure;
                cmd02.Parameters.Add("@codigo", SqlDbType.Int).Value = cod_usuario;
                cmd02.Parameters.Add("@contrasena", SqlDbType.NVarChar).Value = pass;
                con02.Open();

                cmd02.ExecuteNonQuery();
            }
        }

    }


}