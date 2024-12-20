using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

/// <summary>
/// Summary description for ws_arduino2
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class ws_arduino2 : System.Web.Services.WebService
{

    public ws_arduino2()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }


    /// <summary>
    /// Metodo que consume Arduino esta son pruebas
    /// </summary>
    /// <param name="tarjeta"></param>
    /// <param name="acceso"></param>
    /// <returns></returns>
    [WebMethod]
    public int setProximityCard3(string tarjeta, int acceso)
    {
        int salida = 1;

        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnStr"]))
        {
            using (SqlCommand cmd = new SqlCommand("sp_tarjetas_agregar", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@acceso", acceso);
                cmd.Parameters.AddWithValue("@tarjeta", DecimalToCardNumber(tarjeta));
                con.Open();

                cmd.ExecuteNonQuery();
            }
        }

        return salida;
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

}
