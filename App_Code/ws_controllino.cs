using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;

/// <summary>
/// Descripción breve de ws_controllino
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
// [System.Web.Script.Services.ScriptService]
public class ws_controllino : System.Web.Services.WebService
{

    public ws_controllino()
    {

        //Elimine la marca de comentario de la línea siguiente si utiliza los componentes diseñados 
        //InitializeComponent(); 
    }


    [WebMethod]
    public int setProximityCardBascula(int n_bascula, int n_lectora, string n_tarjeta)
    {
        int salida = 0;

        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnStr_prod"]))
        {
            using (SqlCommand cmd = new SqlCommand("[sp_LEVERANS_Tarjetas_Bascula_Add]", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@tarjeta", n_tarjeta);
                cmd.Parameters.AddWithValue("@lectora", n_lectora);
                cmd.Parameters.AddWithValue("@bacula", n_bascula);
                con.Open();

                cmd.ExecuteNonQuery();
                salida = 1;
            }
        }

        return salida;
    }



    [WebMethod]
    public int Tarjetas_Bascula_Update(int codigo, int cod_estado)
    {
        int salida = 0;

        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnStr_prod"]))
        {
            using (SqlCommand cmd = new SqlCommand("LEVERANS_Tarjetas_Bascula_update", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@codigo", codigo);
                cmd.Parameters.AddWithValue("@cod_estado", cod_estado);
                con.Open();

                cmd.ExecuteNonQuery();
                salida = 1;
            }
        }

        return salida;
    }




    //Metodo que consume el cliente de bascula para obtenr todas las tarjetas
    [WebMethod]
    public List<tarjetas> getTarjetas_bascula()
    {
      //  try
      //  {


            List<tarjetas> salida = new List<tarjetas>();

            string ConnectionString = ConfigurationManager.AppSettings["ConnStr_prod"];
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = string.Format("SELECT TOP 5 * FROM [LEVERANS_Tarjetas_Bascula] where Estado=0 and FK_Bascula=3");
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        tarjetas datos = new tarjetas();
                        datos.PK_TarjetaBascula = int.Parse(reader["PK_TarjetaBascula"].ToString());
                        datos.N_tarjeta = reader["N_tarjeta"].ToString();
                        datos.FK_Bascula = int.Parse(reader["FK_Bascula"].ToString());
                        datos.N_Lectora = int.Parse(reader["N_Lectora"].ToString());
                        datos.Fecha = Convert.ToDateTime(reader["Fecha"]);
                        datos.Estado = int.Parse(reader["Estado"].ToString());
                        salida.Add(datos);
                    }
                }
                con.Close();
            }
            return salida;
       // }
        //catch (Exception ex)
        //{
        //    using (System.IO.StreamWriter _testData = new System.IO.StreamWriter(System.Web.HttpContext.Current.Server.MapPath("~/log.txt"), true))
        //    {
        //        _testData.WriteLine(DateTime.Now + " " + ex.Message);
        //    }
        //}
    }


    //Metodo que consume el cliente de bascula para obtenr todas las tarjetas
    [WebMethod]
    public List<tarjetas> getTarjetas_bascula2(int nbascula)
    {
        //  try
        //  {


        List<tarjetas> salida = new List<tarjetas>();

        string ConnectionString = ConfigurationManager.AppSettings["ConnStr_prod"];
        using (SqlConnection con = new SqlConnection(ConnectionString))
        {
            string query = string.Format("SELECT TOP 10 * FROM [LEVERANS_Tarjetas_Bascula] where Estado=0 and [FK_Bascula]="+nbascula);
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    tarjetas datos = new tarjetas();
                    datos.PK_TarjetaBascula = int.Parse(reader["PK_TarjetaBascula"].ToString());
                    datos.N_tarjeta = reader["N_tarjeta"].ToString();
                    datos.FK_Bascula = int.Parse(reader["FK_Bascula"].ToString());
                    datos.N_Lectora = int.Parse(reader["N_Lectora"].ToString());
                    datos.Fecha = Convert.ToDateTime(reader["Fecha"]);
                    datos.Estado = int.Parse(reader["Estado"].ToString());
                    salida.Add(datos);
                }
            }
            con.Close();
        }
        return salida;
        // }
        //catch (Exception ex)
        //{
        //    using (System.IO.StreamWriter _testData = new System.IO.StreamWriter(System.Web.HttpContext.Current.Server.MapPath("~/log.txt"), true))
        //    {
        //        _testData.WriteLine(DateTime.Now + " " + ex.Message);
        //    }
        //}
    }


}
