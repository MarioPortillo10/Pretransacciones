using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;


/// <summary>
/// Summary description for ws_basculas
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class ws_basculas : System.Web.Services.WebService
{

    public ws_basculas()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }



    /// <summary>
    /// metodo para obtener la ultima tarjeta no esta implementado
    /// </summary>
    /// <param name="acceso"></param>
    /// <returns></returns>
    [WebMethod]
    public string ultimatarjeta(int acceso)
    {
        string tarjeta = "0";
        try
        {
            string query = "SELECT tarjeta FROM tarjetas where codigo=(SELECT MAX(codigo) FROM [dbo].[tarjetas] WHERE acceso=@acceso and estado=-1)";
            string ConnectionString = ConfigurationManager.AppSettings["ConnProduccion"];
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.Add("@acceso", SqlDbType.Int).Value = acceso;
                con.Open();
                string result = (string)cmd.ExecuteScalar();
                if (result != null)
                {
                    tarjeta = result;
                }


            }
        }
        catch (Exception ex)
        {
            tarjeta = "0";

        }

        return tarjeta;

    }

    [WebMethod]
    public void Save(string imagen2,
                string ntarjeta,
                string cod_actividad,
                string desc_actividad,
                string boleta_cepa,
                string viaje_cepa,
                string producto,
                string vehiculo,
                decimal peso_cepa,
                string buque)
    {


        int codigo_transaccion = 0;

        string nombre = Guid.NewGuid().ToString() + ".jpg";

        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnProduccion"]))
        {
            using (SqlCommand cmd = new SqlCommand("LEVERANS_sp_Registro_Interface_Add", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@tajeta", SqlDbType.Int).Value = ntarjeta;
                cmd.Parameters.Add("@actividad", SqlDbType.NVarChar).Value = cod_actividad;
                cmd.Parameters.Add("@des_actividad", SqlDbType.NVarChar).Value = desc_actividad;
                cmd.Parameters.Add("@boletacepa", SqlDbType.NVarChar).Value = boleta_cepa;
                cmd.Parameters.Add("@viajecepa", SqlDbType.NVarChar).Value = viaje_cepa;
                cmd.Parameters.Add("@desc_producto", SqlDbType.NVarChar).Value = producto;
                cmd.Parameters.Add("@vehiculo", SqlDbType.NVarChar).Value = vehiculo;
                cmd.Parameters.Add("@pesocepa", SqlDbType.Decimal).Value = peso_cepa;
                cmd.Parameters.Add("@buque", SqlDbType.NVarChar).Value = buque;


                var returnParameter = cmd.Parameters.Add("@ReturnVal", SqlDbType.Int);
                returnParameter.Direction = ParameterDirection.ReturnValue;



                con.Open();

                cmd.ExecuteNonQuery();


                codigo_transaccion = Convert.ToInt32(returnParameter.Value);
            }
        }



        //string filePath = "~/Upload/";
        string filePath = System.Web.HttpContext.Current.Server.MapPath("~/Upload/" + nombre);
        File.WriteAllBytes(filePath, Convert.FromBase64String(imagen2));

        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnProduccion"]))
        {
            using (SqlCommand cmd = new SqlCommand("INSERT INTO [dbo].[LEVERANS_trans_documento] (nombre,cod_transaccion) VALUES (@nombre,@cod_trasaccion)", con))
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@nombre", nombre);
                cmd.Parameters.AddWithValue("@cod_trasaccion", codigo_transaccion);
                con.Open();

                cmd.ExecuteNonQuery();
            }
        }


    }


    [WebMethod]
    public void Save2(string imagen2,
                string ntarjeta,
                string desc_actividad
)
    {


        int codigo_transaccion = 0;
        string nombre = Guid.NewGuid().ToString() + ".jpg";
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnProduccion"]))
        {
            using (SqlCommand cmd = new SqlCommand("LEVERANS_sp_Registro_Interface_Add2", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@tajeta", SqlDbType.Int).Value = ntarjeta;
                cmd.Parameters.Add("@des_actividad", SqlDbType.NVarChar).Value = desc_actividad;

                var returnParameter = cmd.Parameters.Add("@ReturnVal", SqlDbType.Int);
                returnParameter.Direction = ParameterDirection.ReturnValue;



                con.Open();

                cmd.ExecuteNonQuery();


                codigo_transaccion = Convert.ToInt32(returnParameter.Value);
            }
        }



        //string filePath = "~/Upload/";
        string filePath = System.Web.HttpContext.Current.Server.MapPath("~/Upload/" + nombre);
        File.WriteAllBytes(filePath, Convert.FromBase64String(imagen2));

        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnProduccion"]))
        {
            using (SqlCommand cmd = new SqlCommand("INSERT INTO [dbo].[LEVERANS_trans_documento] (nombre,cod_transaccion) VALUES (@nombre,@cod_trasaccion)", con))
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@nombre", nombre);
                cmd.Parameters.AddWithValue("@cod_trasaccion", codigo_transaccion);
                con.Open();

                cmd.ExecuteNonQuery();
            }
        }


    }




    /// <summary>
    /// metodo para crear pretransaccion 
    /// </summary>
    /// <param name="ntarjeta"></param>
    /// <param name="cod_actividad"></param>
    /// <param name="desc_actividad"></param>
    /// <param name="buque"></param>
    /// <param name="boleta_cepa"></param>
    /// <param name="viaje_cepa"></param>
    /// <param name="producto"></param>
    /// <param name="vehiculo"></param>
    /// <param name="peso_cepa"></param>
    /// <returns></returns>
    /// 

    [WebMethod]
    public int Save_Pretransaccion(
        string ntarjeta,
        string cod_actividad,
        string desc_actividad,
        string buque,
        string boleta_cepa,
        string viaje_cepa,
        string producto,
        string vehiculo,
        string peso_cepa, bool manual = false)
    {
        int cod_pre_transaccion = 0;


        bascula ob_bascula = new bascula();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnStr_LEVERANS_prod"]))
        {
            using (SqlCommand cmd = new SqlCommand("sp_LEVERANS_PreTransacciones_Add", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@ntarjeta", SqlDbType.NVarChar).Value = ntarjeta;
                cmd.Parameters.Add("@cod_actividad", SqlDbType.NVarChar).Value = cod_actividad;
                cmd.Parameters.Add("@desc_actividad", SqlDbType.NVarChar).Value = desc_actividad;
                cmd.Parameters.Add("@buque", SqlDbType.NVarChar).Value = buque;
                cmd.Parameters.Add("@boleta_cepa", SqlDbType.NVarChar).Value = boleta_cepa;
                cmd.Parameters.Add("@viaje_cepa", SqlDbType.NVarChar).Value = viaje_cepa;
                cmd.Parameters.Add("@producto", SqlDbType.NVarChar).Value = producto;
                cmd.Parameters.Add("@vehiculo", SqlDbType.NVarChar).Value = vehiculo;
                cmd.Parameters.Add("@peso_cepa", SqlDbType.NVarChar).Value = peso_cepa;
                cmd.Parameters.Add("@manual", SqlDbType.Bit).Value = manual;


                var returnParameter = cmd.Parameters.Add("@ReturnVal", SqlDbType.Int);
                returnParameter.Direction = ParameterDirection.ReturnValue;

                con.Open();

                cmd.ExecuteNonQuery();


                cod_pre_transaccion = Convert.ToInt32(returnParameter.Value);
            }
        }

        //descomentar despues solo se comenta para hacer pruebas
        //si la actividad es recepcion de cereales o manual 
        if (Convert.ToInt32(cod_actividad) == 4)
        {


            //crea transaccion y autoriza ingreso de vehiculo
            ob_bascula.AUTORIZA_INGRESO_EN_ACCESO(cod_pre_transaccion, "Administrador", 0, 2);

        }

        //else if (manual)
        //{
        //    ob_bascula.AUTORIZA_INGRESO_EN_ACCESO(cod_pre_transaccion, "", 1, 3);
        //}




        return cod_pre_transaccion;
    }


    //metodo para guardar el Documento Scanneado
    //parametros imagen, codigo de preTrans
    [WebMethod]
    public void Save_Documento(int codigo, string imgen_documento)
    {
        

        string nombre = Guid.NewGuid().ToString();



        //string filePath = "~/Upload/";
	//Disco c:
        //string filePath = System.Web.HttpContext.Current.Server.MapPath("~/Upload/" + nombre + ".jpg");
	//Guardamos imagenes en unidad E:
	string filePath = @"E:\Scanner-img\" + nombre + ".jpg";
        File.WriteAllBytes(filePath, Convert.FromBase64String(imgen_documento));


        //metodo para guardar la imagen en modo minatura.
        Image image = Image.FromFile(filePath);
        Image thumb = image.GetThumbnailImage(120, 120, () => false, IntPtr.Zero);
        //guarda
        thumb.Save(Path.ChangeExtension(filePath, "thumbnail.jpg"));


        //Image image = Image.Thumbnail("image.jpg", 300, 300);
        //image.WriteToFile("my-thumbnail.jpg");


        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnStr_LEVERANS_prod"]))
        {
            using (SqlCommand cmd = new SqlCommand("INSERT INTO [dbo].[LEVERANS_Documentos] (Documento,Documento_thumbnail,FK_PreTransaccion) VALUES (@nombre,@nombrethumbnail,@cod_trasaccion)", con))
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@nombre", nombre + ".jpg");
                cmd.Parameters.AddWithValue("@nombrethumbnail", nombre + ".thumbnail.jpg");
                cmd.Parameters.AddWithValue("@cod_trasaccion", codigo);
                con.Open();

                cmd.ExecuteNonQuery();
            }
        }

    }

    //WebService para obtener la data de actividades.
    //utiliza App_Android y scannerAppc#
    [WebMethod]
    public List<actividades> getActividades()
    {
        List<actividades> salida = new List<actividades>();

        string ConnectionString = ConfigurationManager.AppSettings["ConnStr_LEVERANS_prod"];
        using (SqlConnection con = new SqlConnection(ConnectionString))
        {
            string query = string.Format("SELECT * FROM [dbo].[LEVERANS_Actividades] where Fk_Actividad <> 4 ");
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    actividades datos = new actividades();
                    datos.codigo = int.Parse(reader["PkActividad"].ToString());
                    datos.descripcion = reader["Descripcion"].ToString();

                    salida.Add(datos);
                }
            }
            con.Close();
        }
        return salida;
    }


    //capturamos las basculas disponibles
    [WebMethod]
    public List<bascula> getBascula()
    {
        List<bascula> salida = new List<bascula>();

        string ConnectionString = ConfigurationManager.AppSettings["ConnStr_LEVERANS_prod"];
        using (SqlConnection con = new SqlConnection(ConnectionString))
        {
            string query = string.Format("SELECT * FROM [LEVERANS_Basculas]");
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    bascula datos = new bascula();
                    datos.N_Bascula = int.Parse(reader["N_Bascula"].ToString());
                    datos.Descripcion = reader["Descripcion"].ToString();

                    salida.Add(datos);
                }
            }
            con.Close();
        }
        return salida;



    }

    //get ip bascula
    [WebMethod]
    public string getIpBascula(int code)
    {
        string ip = "";
        string ConnectionString = ConfigurationManager.AppSettings["ConnStr_LEVERANS_prod"];


        //Obtiene todos los usuarios con el tipo de Rol: 6.
        using (SqlConnection con = new SqlConnection(ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("select IP FROM [LEVERANS_Basculas] WHERE [N_Bascula]="+ code, con))
            {
                con.Open();
                var get_ip = cmd.ExecuteScalar();

                if (get_ip != null)
                {
                    ip = get_ip.ToString();
                }


            }

        }

            return ip;

    }


    /// <summary>
    /// Tarjetas autorizadas
    /// </summary>
    /// <returns>tarjetas autorizadas</returns>
    [WebMethod]
    public List<Tarjetas_autorizadas> Tarjetas_Autorizadas()
    {
        List<Tarjetas_autorizadas> Tarjetas = new List<Tarjetas_autorizadas>();
        string ConnectionString = ConfigurationManager.AppSettings["ConnStr_LEVERANS_prod"];


        //Obtiene todos los usuarios con el tipo de Rol: 6.
        using (SqlConnection con = new SqlConnection(ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT ntarjeta,nbascula FROM [vw_Leverans_PreTransacciones] where cod_estado=2 order by PK_PreTransaccion desc", con))
            {
                cmd.CommandType = CommandType.Text;
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                //Valida si existen registros.
                if (reader.HasRows)
                {
                    //Recorre todos los registros.
                    while (reader.Read())
                    {
                        Tarjetas_autorizadas tarjeta = new Tarjetas_autorizadas();
                        tarjeta.NTarjeta = reader["ntarjeta"].ToString();
                        tarjeta.NBascula = reader["nbascula"].ToString();

                        // create and add images to the dataGridView C:\Leverans
                        //string tarjeta = reader["tarjetano"].ToString();
                        Tarjetas.Add(tarjeta);
                    }
                }

            }


        }

        return Tarjetas;

    }


    //get ip bascula
    [WebMethod]
    public int get_count_TarjetasAutorizadas()
    {
        int x = 0;
        string ConnectionString = ConfigurationManager.AppSettings["ConnStr_LEVERANS_prod"];


        //Obtiene todos los usuarios con el tipo de Rol: 6.
        using (SqlConnection con = new SqlConnection(ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT count(*) FROM vw_Leverans_PreTransacciones where cod_estado=1", con))
            {
                con.Open();
                var get_x = cmd.ExecuteScalar();

                if (get_x != null)
                {
                    x = Convert.ToInt32(get_x);
                }


            }

        }

        return x;

    }



    /// <summary>
    /// valida codigo de barra que es el codigo de la transaccion
    /// </summary>
    /// <param name="tarjeta"></param>
    /// <param name="acceso"></param>
    /// <returns>id de la transaccion</returns>
    [WebMethod]
    public int Valida_CodTransaccion(string tarjeta, int acceso)
    {
        int salida = 0;
        string ConnectionString = ConfigurationManager.AppSettings["ConnStr_LEVERANS_prod"];
        using (SqlConnection con = new SqlConnection(ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("sp_LEVERANS_valida_transaccion", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@acceso", acceso);
                //cmd.Parameters.AddWithValue("@tarjeta", "99");
                cmd.Parameters.AddWithValue("@id", tarjeta);



                SqlParameter returnParameter = cmd.Parameters.Add("Value", SqlDbType.Int);
                returnParameter.Direction = ParameterDirection.ReturnValue;
                con.Open();
                cmd.ExecuteNonQuery();
                salida = (int)returnParameter.Value;

            }
        }

        return salida;
    }


    [WebMethod]
    public bool DisponibilidadTarjeta(string ntarjeta)
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnStr_LEVERANS_prod"]))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM [dbo].[LEVERANS_PreTransacciones] where FK_PreTransaccion_Estado in (1,2,3,4) AND ntarjeta=@tarjeta", con))
            {
                cmd.Parameters.AddWithValue("tarjeta", ntarjeta);
                con.Open();

                int count = Convert.ToInt32(cmd.ExecuteScalar());
                if (count > 0)
                    return false;
                else
                    return true;
            }
        }

    }

    //metodo para guardar el Documento Scanneado
    //parametros imagen, codigo de preTrans
    [WebMethod]
    public void Save_Documento_dev2(int codigo)
    {
        

        string nombre = Guid.NewGuid().ToString();

        string imgen_documento = "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AFlL0fIL6QIAAECeFo9+LF0AAADIlGgBAACyJloAAICsiRYAACBrogUAAMiaaAEAALImWgAAgKyJFgAAIGuiBQAAyJpoAQAAsiZaAACArIkWAAAga6IFAADIWoqWn08XAAAA8iRaAACArIkWAAAga6IFAADImmgBAACytnj0o+kCAABApkQLAACQNdECAABkbfH+9A8AAECuRAsAAJA10QIAAGRNtAAAAFkTLQAAQNZECwAAkLUULT+XLgAAAORJtAAAAFkTLQAAQNZECwAAkDXRAgAAZE20AAAAWRMtAABA1kQLAACQNdECAABkTbQAAABZW7z/I+kCAABApkQLAACQNdECAABkTbQAAABZS9HylXQBAAAgT6IFAADImmgBAACyJloAAICsiRYAACBri0fSPwAAALkSLQAAQNZECwAAkDXRAgAAZE20AAAAWRMtAABA1kQLAACQNdECAABkTbQAAABZEy0AAEDWFo88+7MVAABArkQLAACQNdECAABkTbQAAABZEy0AAEDWRAsAAJA10QIAAGRNtAAAAFkTLQAAQNZECwAAkDXRAgAAZE20AAAAWRMtAABA1lK0HKYLAAAAeRItAABA1kQLAACQtcXD6R8AAIBciRYAACBrogUAAMja4uEPpwsAAACZEi0AAEDWRAsAAJA10QIAAGRNtAAAAFkTLQAAQNZECwAAkDXRAgAAZE20AAAAWUvR8uV0AQAAIE+iBQAAyJpoAQAAsiZaAACArIkWAAAga6IFAADImmgBAACyJloAAICsiRYAACBri4efSRcAAAAyJVoAAICsiRYAACBri4fSPwAAALkSLQAAQNZStLyYLgAAAORJtAAAAFkTLQAAQNZECwAAkDXRAgAAZE20AAAAWRMtAABA1kQLAACQNdECAABkTbQAAAAZe7H6/wF7MoU7g2EmKgAAAABJRU5ErkJggg==";
        //string filePath = "~/Upload/";
        string filePath = @"E:\Scanner-img\" + nombre + ".jpg";

        //string filePath = System.Web.HttpContext.Current.Server.MapPath("~/Upload/" + nombre + ".jpg");
        File.WriteAllBytes(filePath, Convert.FromBase64String(imgen_documento));

        //metodo para guardar la imagen en modo minatura.
        Image image = Image.FromFile(filePath);
        Image thumb = image.GetThumbnailImage(120, 120, () => false, IntPtr.Zero);
        //guarda
        thumb.Save(Path.ChangeExtension(filePath, "thumbnail.jpg"));


        //Image image = Image.Thumbnail("image.jpg", 300, 300);
        //image.WriteToFile("my-thumbnail.jpg");


        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnStr_LEVERANS_prod"]))
        {
            using (SqlCommand cmd = new SqlCommand("INSERT INTO [dbo].[LEVERANS_Documentos] (Documento,Documento_thumbnail,FK_PreTransaccion) VALUES (@nombre,@nombrethumbnail,@cod_trasaccion)", con))
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@nombre", nombre + ".jpg");
                cmd.Parameters.AddWithValue("@nombrethumbnail", nombre + ".thumbnail.jpg");
                cmd.Parameters.AddWithValue("@cod_trasaccion", codigo);
                con.Open();

                cmd.ExecuteNonQuery();
            }
        }

    }


    //SELECT COUNT(*) FROM [dbo].[LEVERANS_PreTransacciones] where FK_PreTransaccion_Estado in (1,2,3,4) AND ntarjeta = '1111'



}
