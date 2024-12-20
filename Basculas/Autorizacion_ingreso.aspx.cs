using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Net;
using System.Diagnostics;
using System.IO;


public partial class Basculas_Autorizacion_ingreso : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // URL que deseas hacer el fetch
        string url = "http://192.168.200.112:3000/api/shipping/status/1";

        // Token
        string token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InByb2dyYW1hX3RyYW5zYWNjaW9uZXMiLCJzdWIiOjQsInJvbGVzIjpbImJvdCJdLCJpYXQiOjE3MjkwMjU5ODcsImV4cCI6MjUxNzk2NTk4N30.S5nkzIJPYKdJ7CsA2K1a-jz4xsuIglTEspao5jv1IBk";

        using (WebClient client = new WebClient())
        {
            // Add the token to the Authorization header
            client.Headers.Add("Authorization", "Bearer " + token);

            // Realizar la solicitud GET y leer la respuesta
            string responseBody = client.DownloadString(url);
            this.LogEvent("esta es la data: ");
            this.LogEvent(responseBody);

            // Deserialize the JSON response
            var data = JsonConvert.DeserializeObject<List<Post>>(responseBody);

            // Bind the data to the repeater control
            rptRutas.DataSource = data;
            rptRutas.DataBind();
        }

        if (!IsPostBack)
        {
            DataBind();
        }
    }

    private void DataBind()
    {
        sql_rutas_actividades.SelectCommand = "SELECT * FROM [dbo].[ALMAPAC$Work Type]";
        sql_rutas_actividades.DataBind();
    }

    // Método para escribir en el Visor de eventos
    public void LogEvent(string message)
    {
        string logFilePath = Server.MapPath("~/Logs/MyAppLog.txt");
        string logDirectory = Path.GetDirectoryName(logFilePath);
        if (!Directory.Exists(logDirectory))
        {
            Directory.CreateDirectory(logDirectory);
        }
        File.AppendAllText(logFilePath, DateTime.Now + ": " + message + Environment.NewLine);
    }

public class Post
{
    public int id { get; set; }
    public string codeGen { get; set; }
    public string product { get; set; }
    public string operationType { get; set; }
    public string loadType { get; set; }
    public string transporter { get; set; }
    public int productQuantity { get; set; }
    public long productQuantityKg { get; set; }
    public string unitMeasure { get; set; }
    public string requiresSweeping { get; set; }
    public DateTime createdAt { get; set; }
    public DateTime updatedAt { get; set; }
    public Driver driver { get; set; }
    public Vehicle vehicle { get; set; }
    public Ingenio ingenio { get; set; }
    public List<Status> statuses { get; set; }
}

public class Driver
{
    public int id { get; set; }
    public string license { get; set; }
    public string name { get; set; }
}

public class Vehicle
{
    public int id { get; set; }
    public string plate { get; set; }
    public string trailerPlate { get; set; }
    public string truckType { get; set; }
}

public class Ingenio
{
    public int id { get; set; }
    public string ingenioCode { get; set; }
    public User user { get; set; } // Asegúrate de que esta propiedad esté aquí
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

public class Status
{
    public int id { get; set; }
    public string status { get; set; }
    public DateTime createdAt { get; set; }
    public string date { get; set; }
    public string time { get; set; }
}


    protected void lnk_VerRuta_Click(object sender, EventArgs e)
    {

        this.LogEvent("HOLA TEST");

        LinkButton lnk_VerRuta = (LinkButton)sender;
        GridViewRow row = (GridViewRow)lnk_VerRuta.NamingContainer;
        GridView gvw = (GridView)row.NamingContainer;
      
        //Hace el Binding.
        DataBindRutasDetalles();

        //Muestra el modal una vez hecho click en la fila.
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal-convertir", "$('#modal-detalle').modal();", true);
    }


    private void DataBindRutasDetalles()
    {
        //Delcara las variables.
        // string strWhere = " WHERE Fk_Actividad =" + hfCodigo.Value;
        string strSQL = "SELECT * FROM vw_LEVERANS_PLANTILLA_RUTAS";
        string strOrder = "";

        ////Ejecuta la consulta.
        //sql_rutas_actividadesDetalles.SelectCommand = strSQL + strWhere + strOrder;
        sql_rutas_actividadesDetalles.Select(new DataSourceSelectArguments());

        //Relaciona el recordset con el GridView
        sql_rutas_actividadesDetalles.DataBind();
        //gvw_rutasDetalles.DataBind();
    }

    protected void btn_agregar_Click(object sender, EventArgs e)
    {
        LinkButton btnAgregar = (LinkButton)sender;
        GridViewRow gvw_row = (GridViewRow)btnAgregar.NamingContainer;

        //asignamos los valores a los parametros
        sql_rutas_actividadesDetalles.InsertParameters["Correlativo"].DefaultValue = (gvw_row.FindControl("txt_correlativo") as TextBox).Text;
        sql_rutas_actividadesDetalles.InsertParameters["FK_Acceso"].DefaultValue = "1";
        //sql_rutas_actividadesDetalles.InsertParameters["FK_Actividad"].DefaultValue = hfCodigo.Value;
        //Ejecutamos el query

        sql_rutas_actividadesDetalles.Insert();
        DataBindRutasDetalles();
        Response.Redirect(Request.RawUrl, false);
    }

    [System.Web.Services.WebMethod]

    public static object getactividades(string codigo)
    {
        List<actividades> salida = new List<actividades>();

        string ConnectionString = ConfigurationManager.AppSettings["ConnStr2"];
        using (SqlConnection con = new SqlConnection(ConnectionString))
        {
            string query = string.Format("SELECT * FROM [ALMAPAC$Work Type]");
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    actividades datos = new actividades();
                    datos.codigo = int.Parse(reader["Code"].ToString());
                    datos.descripcion = reader["Description"].ToString();
                    salida.Add(datos);
                }
            }
            con.Close();
        }
        object json = new { data = salida };
        return json;
    }

    protected void gvw_rutasDetalles_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        GridView gvw_rutasDetalles = (GridView)sender;
        sql_rutas_actividadesDetalles.DeleteParameters["PK_Rutas"].DefaultValue = gvw_rutasDetalles.DataKeys[e.RowIndex].Value.ToString();
        sql_rutas_actividadesDetalles.Delete();

        gvw_rutasDetalles.EditIndex = -1;
        Response.Redirect(Request.RawUrl, false);
    }

    protected void gvw_rutasDetalles_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridView gvw_rutasDetalles = (GridView)sender;
        GridViewRow row = gvw_rutasDetalles.Rows[e.RowIndex];

        sql_rutas_actividadesDetalles.UpdateParameters["PK_Rutas"].DefaultValue = gvw_rutasDetalles.DataKeys[e.RowIndex].Value.ToString();
        sql_rutas_actividadesDetalles.UpdateParameters["Correlativo"].DefaultValue = (row.FindControl("txt_correlativo") as TextBox).Text;
        sql_rutas_actividadesDetalles.UpdateParameters["FK_Acceso"].DefaultValue = (row.FindControl("ddlAccesos") as DropDownList).SelectedValue;
        sql_rutas_actividadesDetalles.UpdateParameters["Estado"].DefaultValue = ((row.FindControl("CheckBox1") as CheckBox).Checked).ToString();
        sql_rutas_actividadesDetalles.Update();
        Response.Redirect(Request.RawUrl, false);
    }

    protected void lnk_perfil_Click(object sender, EventArgs e)
    {
        txtUsuario.Text = Request.Cookies["username"].Value;
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal-convertir", "$('#editPass').modal();", true);
    }

    protected void LinkSalir1_Click(object sender, EventArgs e)
    {
        // FormsAuthentication.SignOut();
        // FormsAuthentication.RedirectToLoginPage();
    }
}