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


public partial class Basculas_Default : System.Web.UI.Page
{
    bascula ob_bascula = new bascula();
    login obj_login = new login();
    PreTransacciones obj_preTra = new PreTransacciones();
    bitacora obj_bitacora = new bitacora();
    string cod_rol = "";


    protected void Page_Load(object sender, EventArgs e)
    {
        cod_rol = Request.Cookies["cod_rol"].Value;

        if (IsPostBack)
        {
            //BindListView(1);
            DataBind();
            valida_rol();
        }
    }

    protected void lnkBuscar_Click(object sender, EventArgs e)
    {
        DataBind();
    }

    /// <summary>
    /// obtenien todas las pre transacciones
    /// </summary>

    private void DataBind()
    {
        string query = "SELECT top 100 * FROM vw_Leverans_PreTransacciones";
        string where = "";
        string order = " ORDER BY PK_PreTransaccion DESC";

        if (!string.IsNullOrEmpty(txtTransaccion.Text))
        {
            if (where.Length > 0)
                where += " AND codTransaccion=" + txtTransaccion.Text + "or PK_PreTransaccion="+ txtTransaccion.Text + "or ntarjeta=" + txtTransaccion.Text;
            else
                where += " WHERE codTransaccion=" + txtTransaccion.Text + "or PK_PreTransaccion=" + txtTransaccion.Text + "or ntarjeta=" + txtTransaccion.Text;
        }

        //Concatena el estado.
        if (ddl_Estado.SelectedIndex > 0)
            if (where.Length > 0)
                where += " AND (cod_estado=" + ddl_Estado.SelectedValue + ")";
            else
                where += " WHERE (cod_estado=" + ddl_Estado.SelectedValue + ")";

        //Concatena el estado.
        if (ddl_Estado.SelectedIndex == 0)
            if (where.Length > 0)
                where += " AND (cod_estado <> 5)";
            else
                where += " WHERE (cod_estado <> 5)";


        //Concatena la actividad. 
        if (ddl_Actividades2.SelectedIndex > 0)
            if (where.Length > 0)
                where += " AND (PkActividad=" + ddl_Actividades2.SelectedValue + ")";
            else
                where += " WHERE (PkActividad=" + ddl_Actividades2.SelectedValue + ")";


        //Concatena la bascula. 
        if (ddl_basculas.SelectedIndex > 0)
            if (where.Length > 0)
                where += " AND (nbascula=" + ddl_basculas.SelectedValue + ")";
            else
                where += " WHERE (nbascula=" + ddl_basculas.SelectedValue + ")";

        SqlDataSource1.SelectCommand = query + where + order;
        ListView1.DataBind();
    }





   



    protected void lvwPrincipal_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {

        dtpPrincipal.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        DataBind();
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
    /// Autoriza el ingreso del vehiculo
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void lnk_autorizar_Click(object sender, EventArgs e)
    {


        LinkButton lnk_autorizar2_Click = (LinkButton)sender;

        string[] arg = new string[2];
        arg = lnk_autorizar2_Click.CommandArgument.ToString().Split(';');


        //codigo
        int cod_pretransaccion = Convert.ToInt32(arg[0]);
        //codTransaccion
        int id = Convert.ToInt32(arg[1]);
        //usuario
        string username = Request.Cookies["username"].Value;

        //Autoriza ingreso de vehiculo
        ob_bascula.Autorizar_ingreso(cod_pretransaccion, id, username);


        DataBind();
    }



    /// <summary>
    /// Autoriza el pesaje
    /// </summary>
    protected void lnk_autorizar2_Click(object sender, EventArgs e)
    {

        //recuperamos parametro
        LinkButton lnk_autorizar2_Click = (LinkButton)sender;
        string[] arg = new string[2];
        arg = lnk_autorizar2_Click.CommandArgument.ToString().Split(';');


 
        int cod_pretransaccion = Convert.ToInt32(arg[0]);
        int id = Convert.ToInt32(arg[1]);
        string username = Request.Cookies["username"].Value;

        //Autoriza pesaje
        ob_bascula.Autorizar(cod_pretransaccion, id, username);


        DataBind();

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
                if (cod_trans != "" )
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




            sql_documetos.SelectCommand = "SELECT * FROM [dbo].[vw_LEVERANS_Transdocumentos] where [PK_PreTransaccion] = " + x;

            sql_documetos.DataBind();

            rpt_galeria.DataSource = sql_documetos;

            rpt_galeria.DataBind();



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




    protected void LinkButton3_Click(object sender, EventArgs e)
    {

    }



    /// <summary>
    /// Método de prueba
    /// </summary>
    /// <returns></returns>
    [System.Web.Services.WebMethod]
    public static string ddl_get_actividades()
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
        return JsonConvert.SerializeObject(salida);
    }



    /// <summary>
    /// Crea una nueva PreTransacción y la convierte en una Transacción 
    /// </summary>
    protected void btn_save_Click(object sender, EventArgs e)
    {

        //capturamos los parametros del modal #nuevaPretransaccionModal
        string value = ddl_actividades.SelectedValue;
        string  Item= ddl_actividades.SelectedItem.Text;
        int cod_pretransaccion = 0;
        int cod_bascula = Convert.ToInt32(Request.Cookies["cod_bascula"].Value);
        string username = Request.Cookies["username"].Value;

        
        ws_basculas wb = new ws_basculas();
 
        //creamos la pretransaccion
        cod_pretransaccion = wb.Save_Pretransaccion(txtTarjeta.Text, ddl_actividades.SelectedValue, Item, "", "", "", "", "", "", true);
     
        //creamos transaccion en NAV y autorizamos ingreso.
        ob_bascula.AUTORIZA_INGRESO_EN_ACCESO(cod_pretransaccion, username, cod_bascula, 2);

        DataBind();
        txtTarjeta.Text = "";
        ddl_actividades.SelectedValue = "0";
    }


    //protected void LinkButton2_Click(object sender, EventArgs e)
    //{
    //    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal-convertir", "$('#exampleModal').modal();", true);
    //}



    /// <summary>
    /// 
    /// </summary>

    protected void lnk_crearTransaccion_Click(object sender, EventArgs e)
    {

        LinkButton lnk_crearTransaccion_Click = (LinkButton)sender;

        //capturamos datos requeridos para autorizar
        int cod_pretransaccion = Convert.ToInt32(lnk_crearTransaccion_Click.CommandArgument);
        int cod_bascula = Convert.ToInt32(Request.Cookies["cod_bascula"].Value);
        string username = Request.Cookies["username"].Value;


        //Autoriza transaccion en NAV sin Acceso de ingreso.
        ob_bascula.AUTORIZA_INGRESO_EN_ACCESO(cod_pretransaccion, username, cod_bascula, 1);

        DataBind();
    }

    protected void LinkButton1_Click1(object sender, EventArgs e)
    {
        
    }

    protected void LinkButton2_Click1(object sender, EventArgs e)
    {
        Response.Redirect(Request.RawUrl, false);
    }

    protected void lnk_perfil_Click(object sender, EventArgs e)
    {

        txtUsuario.Text= Request.Cookies["username"].Value;

        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal-convertir", "$('#editPass').modal();", true);
    }



    protected void lnk_restablecer_Click(object sender, EventArgs e)
    {

        int cod_usuario = Convert.ToInt32(Request.Cookies["cod_usuario"].Value);

        obj_login.ActualizarContraseña(cod_usuario,txtPass.Text);
        txtPass.Text = "";

        FormsAuthentication.SignOut();
        FormsAuthentication.RedirectToLoginPage();
    }

    protected void lnk_editPreTransaccion_Click(object sender, EventArgs e)
    {


        int pk =  Convert.ToInt32(txt_codigoPreTransaccion.Value);

        string ntarjeta = txt_tarjetaEdit.Text;

        string cod_actividad = ddlActividadEdt.SelectedValue;

        string actividad = ddlActividadEdt.SelectedItem.Text;

        obj_preTra.UpdatePreTransacciones(pk,ntarjeta,cod_actividad,actividad);
        //Response.Redirect(Request.RawUrl, false);
        // int cod = 0;
    }

    protected void lnk_delete_Click(object sender, EventArgs e)
    {

        LinkButton lnk_delete_Click = (LinkButton)sender;

        //capturamos datos requeridos para autorizar
        int cod_pretransaccion = Convert.ToInt32(lnk_delete_Click.CommandArgument);
        int cod_usuario = Convert.ToInt32(Request.Cookies["cod_usuario"].Value);
        string username = Request.Cookies["username"].Value;

        obj_preTra.DeletePreTransaccion(cod_pretransaccion);
        String bitacora = String.Format("El usuario {0} elimino la Pretransacción # {1}",username, cod_pretransaccion);
        obj_bitacora.AgregaBitacora(bitacora,cod_usuario);

        //Response.Redirect(Request.RawUrl, false);

        DataBind();
    }

    protected void lnk_rotar_Click(object sender, EventArgs e)
    {
        LinkButton lnk_rotar_Click = (LinkButton)sender;

        string[] arg = new string[2];
        arg = lnk_rotar_Click.CommandArgument.ToString().Split(';');


        //Documentos
        string Documento = arg[0];
        string Documentothumbnail = arg[1];


        string Documento_sinFormato = Documento.Substring(0, Documento.Length-4);

        //rota 90° el primer Documento
        rotarImagen(Documento_sinFormato);
        //Documento_thumbnail
     
        string Documentothumbnail_sinFormato = Documentothumbnail.Substring(0,Documentothumbnail.Length-4);
        //rota 90° el segundo Documento
        rotarImagen(Documentothumbnail_sinFormato);

        //int codi = 4;

        


    }

    public void rotarImagen(string filename)
    {

      //  string filePath = Server.MapPath("~/Upload/" + filename+".jpg");

	//string filePath = @"E:\Scanner-img\" + filename+ ".jpg";

        string path = @"E:\Scanner-img\" + filename+ ".jpg";

        string nuevo_nombre = Guid.NewGuid().ToString() + ".jpg";

        string newpath = Server.MapPath(filename + ".01.jpg");

        System.Drawing.Image img = System.Drawing.Image.FromFile(path);
        img.Save(newpath);

        img.RotateFlip(RotateFlipType.Rotate90FlipNone);
        img.Save(path);
        img.Dispose();

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

        DataBind();
    }

    /// <summary>
    /// Metodo para dar privilegios a usuarios dependiendo de el rol q este tiene asignado
    /// </summary>
    public void valida_rol() {

        //Declaramos los controles a los q les aplicaremos los cambios 


        //accion dependiendo del tipo de rol del usuario
        switch (cod_rol)
        {
            case "1":
            case "2":
                Lnk_newTransaccon.Visible = true;
                break;
            default:
                break;
        }

    }


  
}