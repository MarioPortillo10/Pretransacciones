using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Net;
using System.Diagnostics;
using System.IO;
using System.Web.Services;


public partial class Basculas_Prechequeo : System.Web.UI.Page
{
    bascula ob_bascula = new bascula();
    login obj_login = new login();
    PreTransacciones obj_preTra = new PreTransacciones();
    bitacora obj_bitacora = new bitacora();
    string cod_rol = "";

    string baseUrl = "http://192.168.200.112:3000/api/";
    string token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InByb2dyYW1hX3RyYW5zYWNjaW9zbmVzIiwic3ViIjozLCJyb2xlcyI6WyJib3QiXSwiaWF0IjoxNzI5ODkxNDQ1LCJleHAiOjI1MTg4MzE0NDV9.iTVACWXaGz7xiKu59autzZZ-0OCv0cep37zQBxkSKOs";


    public static string baseUrlStatic = "http://192.168.200.112:3000/api/";
    public static string tokenStatic = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InByb2dyYW1hX3RyYW5zYWNjaW9zbmVzIiwic3ViIjozLCJyb2xlcyI6WyJib3QiXSwiaWF0IjoxNzI5ODkxNDQ1LCJleHAiOjI1MTg4MzE0NDV9.iTVACWXaGz7xiKu59autzZZ-0OCv0cep37zQBxkSKOs";

    protected void Page_Load(object sender, EventArgs e)
    {
        cod_rol = Request.Cookies["cod_rol"].Value;
        if (IsPostBack)
        {
            //BindListView(1);
            DataBind1();
            valida_rol();
        }
    }


    protected void lnkBuscar_Click(object sender, EventArgs e)
    {
        // Obtener el valor de la transacción
        LogEvent("Es esto: ");
        LogEvent(txtTransaccion.Text);
        string transaccion = txtTransaccion.Text.Trim();

        // Validar que la transacción no esté vacía
        if (string.IsNullOrEmpty(transaccion))
        {
            LogEvent("Error: La transacción no puede estar vacía.");
            return; // Salir del método
        }

        // URL que deseas hacer el fetch
        string url = this.baseUrl + "shipping/" + transaccion;

        using (WebClient client = new WebClient())
        {
            client.Headers.Add("Authorization", "Bearer " + this.token);
            try
            {
                string responseBody = client.DownloadString(url);
                var data = JsonConvert.DeserializeObject<Post>(responseBody);


                // Asignación de valores desde el JSON `data`
                txt_ingenio.Text = data.ingenio.ingenioCode;
                txt_producto.Text = data.nameProduct;
                txt_transporte.Text = data.transporter;
                txt_motorista.Text = data.driver.name;
                txt_licencia.Text = data.driver.license;
                txt_placaCamion.Text = data.vehicle.plate;
                txt_placaRemolque.Text = data.vehicle.trailerPlate;
                txt_tipoUnidad.Text = data.truckType;

                // Actualizar el UpdatePanel si es necesario
                UpdatePanel2.Update();



                LogEvent("La data es: ");
                LogEvent(JsonConvert.SerializeObject(data));
            }
            catch (WebException webEx)
            {
                // Manejar el error 404
                var response = webEx.Response as HttpWebResponse;
                if (response != null && response.StatusCode == HttpStatusCode.NotFound)
                {
                    LogEvent("Error: La transacción no se encontró (404).");

                }
                else
                {
                    using (var stream = webEx.Response.GetResponseStream())
                    using (var reader = new StreamReader(stream))
                    {
                        string errorResponse = reader.ReadToEnd();
                        LogEvent("Error en DownloadString: " + webEx.Message);
                        LogEvent("Respuesta del servidor: " + errorResponse);
                    }
                }
            }

            catch (Exception ex)
            {
                LogEvent("Error en DownloadString: " + ex.Message);
            }
        }

        LogEvent("hola si entre tabien llegue hasta aca xdxd");
    }


    [WebMethod]
    public static string UploadPhoto(string imageData, string codeGen)
    {
        try
        {
            // Eliminar el prefijo "data:image/jpeg;base64," de la cadena base64
            //string base64String = imageData.Replace("data:image/jpeg;base64,", "");

            // Construir mensaje de log para la primera solicitud (shipping/upload)
            var uploadPayload = new
            {
                urlfileOrbase64file = imageData,
                type = "P",
                isBase64 = true,
                codeGen = codeGen
            };

 
            LogEventS(new
            {
                url = baseUrlStatic + "shipping/upload",
                method = "POST",
                headers = new
                {
                    ContentType = "application/json",
                    Authorization = "Bearer " + tokenStatic
                },
                payload = uploadPayload
            }, HttpContext.Current);

            // Realizar la primera petición hacia `shipping/upload`
            using (WebClient client = new WebClient())
            {
                client.Headers[HttpRequestHeader.ContentType] = "application/json";
                client.Headers[HttpRequestHeader.Authorization] = "Bearer " + tokenStatic;

                string uploadResponse = client.UploadString(baseUrlStatic + "shipping/upload", "POST", JsonConvert.SerializeObject(uploadPayload));
            }

            // Construir mensaje de log para la segunda solicitud (status/push)
            var statusPayload = new
            {
                codeGen = codeGen,
                predefinedStatusId = 2
            };

            // Log de la segunda solicitud
            LogEventS(new
            {
                url = baseUrlStatic + "status/push",
                method = "POST",
                headers = new
                {
                    ContentType = "application/json",
                    Authorization = "Bearer " + tokenStatic
                },
                payload = statusPayload
            }, HttpContext.Current);

            // Realizar la segunda petición hacia `status/push`
            using (WebClient client = new WebClient())
            {
                client.Headers[HttpRequestHeader.ContentType] = "application/json";
                client.Headers[HttpRequestHeader.Authorization] = "Bearer " + tokenStatic;

                string statusResponse = client.UploadString(baseUrlStatic + "status/push", "POST", JsonConvert.SerializeObject(statusPayload));
            }

            // Retornar éxito si ambas solicitudes son exitosas
            return "success";
        }
        catch (Exception ex)
        {
            // Manejar errores y registrar el error
            LogEventS(new
            {
                error = ex.Message,
                stackTrace = ex.StackTrace
            }, HttpContext.Current);

            return "error";
        }
    }



    public void LogEvent(object message)
    {
        string logFilePath = Server.MapPath("~/Logs/MyAppLog.txt");
        string logDirectory = Path.GetDirectoryName(logFilePath);

        // Crear el directorio si no existe
        if (!Directory.Exists(logDirectory))
        {
            Directory.CreateDirectory(logDirectory);
        }

        // Convertir el mensaje a string
        string logMessage;
        try
        {
            logMessage = JsonConvert.SerializeObject(message, Formatting.Indented);
        }
        catch
        {
            // Si la serialización falla, usar el método ToString() o "null" si es nulo
            logMessage = (message != null) ? message.ToString() : "null";
        }

        // Formatear el mensaje de log
        string formattedLog = String.Format("{0:yyyy-MM-dd HH:mm:ss} - {1}{2}", DateTime.Now, logMessage, Environment.NewLine);

        // Escribir el log en el archivo
        File.AppendAllText(logFilePath, formattedLog);
    }

    public static void LogEventS(object message, HttpContext context)
    {
        string logFilePath = context.Server.MapPath("~/Logs/MyAppLog.txt");
        string logDirectory = Path.GetDirectoryName(logFilePath);

        // Crear el directorio si no existe
        if (!Directory.Exists(logDirectory))
        {
            Directory.CreateDirectory(logDirectory);
        }

        // Convertir el mensaje a string
        string logMessage;
        try
        {
            logMessage = JsonConvert.SerializeObject(message, Formatting.Indented);
        }
        catch
        {
            // Si la serialización falla, usar el método ToString() o "null" si es nulo
            logMessage = (message != null) ? message.ToString() : "null";
        }

        // Formatear el mensaje de log
        string formattedLog = String.Format("{0:yyyy-MM-dd HH:mm:ss} - {1}{2}", DateTime.Now, logMessage, Environment.NewLine);

        // Escribir el log en el archivo
        File.AppendAllText(logFilePath, formattedLog);
    }




    public class Post
    {
        public string nameProduct { get; set; }
        public string truckType { get; set; }
        public int id { get; set; }
        public string codeGen { get; set; }
        public string product { get; set; }
        public string operationType { get; set; }
        public string loadType { get; set; }
        public string transporter { get; set; }
        public int productQuantity { get; set; }
        public int productQuantityKg { get; set; }
        public string unitMeasure { get; set; }
        public DateTime createdAt { get; set; }
        public DateTime updatedAt { get; set; }
        public Driver driver { get; set; }
        public Vehicle vehicle { get; set; }
        public Status[] statuses { get; set; }
        public Ingenio ingenio { get; set; }
    }

    public class Driver
    {
        public int id { get; set; }
        public string license { get; set; }
        public string name { get; set; }
        public DateTime createdAt { get; set; }
        public DateTime updatedAt { get; set; }
    }

    public class Vehicle
    {
        public int id { get; set; }
        public string plate { get; set; }
        public string trailerPlate { get; set; }
        public string truckType { get; set; }
        public DateTime createdAt { get; set; }
        public DateTime updatedAt { get; set; }
    }

    public class Status
    {
        public int id { get; set; }
        public string status { get; set; }
        public DateTime createdAt { get; set; }
        public string date { get; set; }
        public string time { get; set; }
    }

    public class Ingenio
    {
        public int id { get; set; }
        public string ingenioCode { get; set; }
        public DateTime createdAt { get; set; }
        public DateTime updatedAt { get; set; }
        public User user { get; set; }
    }

    public class User
    {
        public int id { get; set; }
        public string username { get; set; }
        public string password { get; set; }
        public string role { get; set; }
        public DateTime createdAt { get; set; }
        public DateTime updatedAt { get; set; }
    }

    private void DataBind1()
    {
        string query = "SELECT top 100 * FROM vw_Leverans_PreTransacciones";
        string where = "";
        string order = " ORDER BY PK_PreTransaccion DESC";

        SqlDataSource1.SelectCommand = query + where + order;
        //ListView1.DataBind1();
    }

    protected void lvwPrincipal_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        dtpPrincipal.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        DataBind1();
    }

    /// <summary>
    /// Metodo para cerrar la session
    /// </summary>

    protected void LinkSalir1_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        FormsAuthentication.RedirectToLoginPage();
    }

    /// <summary>
    /// Metodo para ocultar botones dependiento del estado y rol
    /// </summary>
    protected void ListView1_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        if (e.Item.ItemType == ListViewItemType.DataItem)
        {
            LinkButton lnk_autorizar = e.Item.FindControl("lnk_autorizar") as LinkButton;
            LinkButton lnk_autorizar2 = e.Item.FindControl("lnk_autorizar2") as LinkButton;
            LinkButton lnk_crearTransaccion = e.Item.FindControl("lnk_crearTransaccion") as LinkButton;
            LinkButton lnk_update_pret = e.Item.FindControl("lnk_update_pret") as LinkButton;
            LinkButton lnk_delete = e.Item.FindControl("lnk_delete") as LinkButton;

            HtmlButton btn_edi = (HtmlButton)e.Item.FindControl("btn_edi");

            Label lbl_cod_estado = e.Item.FindControl("lbl_cod_estado") as Label;
            Label lblNombre = e.Item.FindControl("lblNombre") as Label;
            Label lblCodT = e.Item.FindControl("lblCodT") as Label;
            int x = 0;

            Repeater rpt_galeria = e.Item.FindControl("rpt_galeria") as Repeater;

            string username = Request.Cookies["username"].Value;
            string cod_trans = lblNombre.Text;

            //pendiente de Autorizar Ingreso
            if (lbl_cod_estado.Text == "1")
            {
                //si ya se creo la transaccion habilitamos estas opciones
                if (cod_trans != "")
                {
                    lnk_autorizar.Visible = true;
                    lnk_autorizar2.Visible = false;
                }
                else
                {
                    lnk_crearTransaccion.Visible = true;
                    lnk_autorizar2.Visible = false;
                    lnk_autorizar.Visible = false;
                    btn_edi.Visible = true;
                }
                //lnk_autorizar2.Visible = false;
            }

            //ingreso Autorizado
            else if (lbl_cod_estado.Text == "2")
            {
                lnk_autorizar.Visible = false;
                lnk_autorizar2.Visible = true;
                lnk_update_pret.Visible = true;
            }

            //pendiente Autorizar Pesaje
            else if (lbl_cod_estado.Text == "3")
            {
                lnk_autorizar.Visible = false;
                lnk_autorizar2.Visible = true;
            }
            //en proceso
            else if (lbl_cod_estado.Text == "4")
            {
                lnk_autorizar.Visible = false;
                lnk_autorizar2.Visible = false;
            }

            //finalizado
            else
            {
                lnk_autorizar.Visible = false;
                lnk_autorizar2.Visible = false;
            }

            if (lblCodT.Text != "")
            {
                x = Convert.ToInt32(lblCodT.Text);
            }

            //activamos las acciones para el superAdmin
            if (cod_rol.Equals("1"))
            {
                btn_edi.Visible = true;
                lnk_delete.Visible = true;
            }

            //activamos las acciones para el superAdmin
            if (cod_rol.Equals("2"))
            {
                btn_edi.Visible = true;
                lnk_delete.Visible = true;
            }

            //activamos las acciones para el superAdmin a pesadores
            if (cod_rol.Equals("3"))
            {
                lnk_delete.Visible = true;
            }

            //activamos las acciones para el supervisor
            //Admin   btn_edi.Visible = true;
            //sql_documetos.SelectCommand = "SELECT * FROM [dbo].[vw_LEVERANS_Transdocumentos] where [PK_PreTransaccion] = " + x;
            //sql_documetos.DataBind1();
            //rpt_galeria.DataSource = sql_documetos;
            //rpt_galeria.DataBind1();
        }
    }
    /// <summary>
    /// Método para notificar al usuario las PreTransaciones q esperan autorizacion
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int GetCount()
    {
        int x = 0;
        string ConnectionString = ConfigurationManager.AppSettings["ConnStr_LEVERANS_prod"];

        using (SqlConnection con = new SqlConnection(ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT count (*) FROM [LEVERANS_PreTransacciones] where [FK_PreTransaccion_Estado]=1", con))
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
    /// Método para refrescar la pagina cuando un registro cambia de estado
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static int pendientes_autorizacion2()
    {
        int y = 0;
        string ConnectionString = ConfigurationManager.AppSettings["ConnStr_LEVERANS_prod"];

        //Obtiene todos los usuarios con el tipo de Rol: 6.
        using (SqlConnection con = new SqlConnection(ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT count (*) FROM [LEVERANS_PreTransacciones] where [FK_PreTransaccion_Estado]=3", con))
            {
                con.Open();
                var get_x = cmd.ExecuteScalar();

                if (get_x != null)
                {
                    y = Convert.ToInt32(get_x);
                }
            }
        }
        return y;
    }

    /// <summary>
    /// Método de prueba
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]

    protected void lnk_perfil_Click(object sender, EventArgs e)
    {
        txtUsuario.Text = Request.Cookies["username"].Value;
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal-convertir", "$('#editPass').modal();", true);
    }




    protected void lnk_delete_Click(object sender, EventArgs e)
    {
        LinkButton lnk_delete_Click = (LinkButton)sender;

        //capturamos datos requeridos para autorizar
        int cod_pretransaccion = Convert.ToInt32(lnk_delete_Click.CommandArgument);
        int cod_usuario = Convert.ToInt32(Request.Cookies["cod_usuario"].Value);
        string username = Request.Cookies["username"].Value;

        obj_preTra.DeletePreTransaccion(cod_pretransaccion);
        String bitacora = String.Format("El usuario {0} elimino la Pretransacción # {1}", username, cod_pretransaccion);
        obj_bitacora.AgregaBitacora(bitacora, cod_usuario);

        //Response.Redirect(Request.RawUrl, false);
        DataBind1();
    }


    protected void lnk_update_pret_Click(object sender, EventArgs e)
    {
        LinkButton lnk_update_pret_Click = (LinkButton)sender;
        //capturamos datos requeridos para autorizar
        int cod_pretransaccion = Convert.ToInt32(lnk_update_pret_Click.CommandArgument);
        int cod_usuario = Convert.ToInt32(Request.Cookies["cod_usuario"].Value);
        string username = Request.Cookies["username"].Value;

        ob_bascula.UpdateEstadoPreTransaccion(cod_pretransaccion, 3);

        String bitacora = String.Format("El usuario {0} simulo ingreso para la Pretransacción # {1}", username, cod_pretransaccion);
        obj_bitacora.AgregaBitacora(bitacora, cod_usuario);

        //Response.Redirect(Request.RawUrl, false);

        DataBind1();
    }

    /// <summary>
    /// Metodo para dar privilegios a usuarios dependiendo de el rol q este tiene asignado
    /// </summary>
    public void valida_rol()
    {
        //Declaramos los controles a los q les aplicaremos los cambios 

        //accion dependiendo del tipo de rol del usuario
        switch (cod_rol)
        {
            case "1":
            case "2":
                // Lnk_newTransaccon.Visible = true;
                break;
            default:
                break;
        }
    }
}