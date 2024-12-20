using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

/// <summary>
/// Summary description for ws_arduino
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class ws_arduino : System.Web.Services.WebService
{

    public ws_arduino()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    //WebService para definir el obstáculo.
    [WebMethod]
    public void setObstacle(arduino dato)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnStr"]))
        {
            using (SqlCommand cmd = new SqlCommand("sp_log_agregar", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ip", dato.ip);
                cmd.Parameters.AddWithValue("@acceso", dato.acceso);
                cmd.Parameters.AddWithValue("@obstaculo", dato.obstaculo);
                con.Open();

                cmd.ExecuteNonQuery();
            }
        }
    }

    /// <summary>
    /// Webservice para obtener la última tarjeta leída.
    /// </summary>
    /// <param name="dato"></param>
    [WebMethod]
    public int setProximityCard(arduino dato)
    {
        int salida = 0;

        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnStr_LEVERANS_prod"]))
        {
            using (SqlCommand cmd = new SqlCommand("sp_LEVERANS_valida_tarjeta", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@acceso", dato.acceso);
                //cmd.Parameters.AddWithValue("@tarjeta", "99");
                cmd.Parameters.AddWithValue("@tarjeta", DecimalToCardNumber(dato.tarjeta));
                con.Open();

                cmd.ExecuteNonQuery();
            }
        }

        return salida;
    }

    /// <summary>
    /// metodo q captura consume arduino para insertar tarjeta en db
    /// </summary>
    /// <param name="tarjeta"></param>
    /// <param name="acceso"></param>
    /// <returns></returns>
    [WebMethod]
    public int setProximityCard2(string tarjeta, int acceso)
    {
        int salida = 0;

        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnStr_LEVERANS_prod"]))
        {
            using (SqlCommand cmd = new SqlCommand("sp_LEVERANS_valida_tarjeta", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@acceso", acceso);
                //cmd.Parameters.AddWithValue("@tarjeta", "99");
                //cmd.Parameters.AddWithValue("@tarjeta", DecimalToCardNumber(tarjeta));
				cmd.Parameters.AddWithValue("@tarjeta", tarjeta);
                con.Open();

                cmd.ExecuteNonQuery();
            }
        }

        return salida;
    }



    /// <summary>
    /// Webservice para saber si el arduino está vivo.
    /// </summary>
    /// <param name="acceso"></param>
    /// <param name="ip"></param>
    /// <returns></returns>
    [WebMethod]
    public void setHeartbeat(int acceso, string ip)
    {

        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnStr"]))
        {
            using (SqlCommand cmd = new SqlCommand("sp_heartbeat_agregar", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ip", ip);
                cmd.Parameters.AddWithValue("@acceso", acceso);
                con.Open();

                cmd.ExecuteNonQuery();
            }
        }

    }


    private string DecimalToCardNumber(string numero)
    {
        string salida = "0";

        try
        {
            //int fromBase = 10;
            //int toBase = 2;
            string binario = Convert.ToString(Convert.ToInt32(numero, 10), 2);

            salida = Convert.ToString(Convert.ToInt32(binario.Substring(7), 2), 10);

            return salida;
        }
        catch (Exception ex)
        {
            return salida;
        }
    }





    /// <summary>
    /// Obtiene la tarjeta previamente validada para el acceso
    /// </summary>
    /// <param name="acceso"></param>
    /// <returns>List<Tarjetas_arduino></returns>
    [WebMethod]
    public List<Tarjetas_arduino> getTarjetasArduino(int acceso)
    {
        List<Tarjetas_arduino> salida = new List<Tarjetas_arduino>();

        string ConnectionString = ConfigurationManager.AppSettings["ConnStr_LEVERANS_prod"];
        using (SqlConnection con = new SqlConnection(ConnectionString))
        {
            //string query = string.Format("SELECT * FROM [LEVERANS_Tarjetas_Accesos] where Estado <> 3 and Fk_Acceso=" + acceso+ " order by Pk_TarjetaAcceso desc");
            string query = string.Format("SELECT * FROM [LEVERANS_Tarjetas_Accesos] WHERE (Estado <> 3) AND (Fk_Acceso={0}) AND ((SELECT COUNT(*) FROM [LEVERANS_RutasDetalles] WHERE FK_Transaccion=[LEVERANS_Tarjetas_Accesos].Fk_transaccion AND Completado=0) >0 OR  (N_tarjeta IN (SELECT [N_tarjeta] FROM [dbo].[LEVERANS_TarjetasMaestras] where [N_tarjeta]=[LEVERANS_Tarjetas_Accesos].N_tarjeta and Estado=1 AND Fk_acceso={0}) ) ) ORDER BY Pk_TarjetaAcceso DESC", acceso);
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    Tarjetas_arduino datos = new Tarjetas_arduino();

                    datos.codigo = Convert.ToInt32(reader["Pk_TarjetaAcceso"]);
                    datos.tarjeta = reader["N_tarjeta"].ToString();
                    datos.acceso = Convert.ToInt32(reader["Fk_Acceso"]);
                    datos.estado = Convert.ToInt32(reader["Estado"]);
					datos.transaccion = Convert.ToInt32(reader["Fk_transaccion"]);
                    salida.Add(datos);
                }
            }
            con.Close();
        }

        return salida;
    }






    //Actualiza estado de la tarjeta 
    [WebMethod]
    public void Update_EstadoTarjeta(int codigo, int cod_estado)
    {
        string ConnectionString = ConfigurationManager.AppSettings["ConnStr_LEVERANS_prod"];

        using (SqlConnection con02 = new SqlConnection(ConnectionString))
        {
            using (SqlCommand cmd02 = new SqlCommand("sp_LEVERANS_Tarjetas_Accesos_UpdateEstado", con02))
            {
                cmd02.CommandType = CommandType.StoredProcedure;
                cmd02.Parameters.Add("@codigo", SqlDbType.Int).Value = codigo;
                cmd02.Parameters.Add("@cod_estado", SqlDbType.Int).Value = cod_estado;
                con02.Open();

                cmd02.ExecuteNonQuery();
            }
        }

    }

    /// <summary>
    /// Cambia el estado del detalle de la ruta a Completado, el unico parametro es la TX;
    /// </summary>
    /// <param name="tx"></param>
    [WebMethod]
    public void setAccesoCompletado(int tx)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnStr_LEVERANS_prod"]))
        {
            //using (SqlCommand cmd = new SqlCommand(string.Format("SELECT * FROM [LEVERANS_RutasDetalles] WHERE FK_Transaccion={0} ORDER BY Correlativo ASC", tx), con))
            using (SqlCommand cmd = new SqlCommand(string.Format("UPDATE LEVERANS_RutasDetalles SET Completado=1 WHERE PK_RutaDetalle = (SELECT TOP 1 PK_RutaDetalle FROM [LEVERANS_RutasDetalles] WHERE FK_Transaccion={0} AND Completado=0 ORDER BY Correlativo ASC)", tx), con))
            {
                //Abre la conexion.
                con.Open();

                //Ejecuta la consulta.
                cmd.CommandType = CommandType.Text;
                cmd.ExecuteNonQuery();

            }
        }
    }
}
