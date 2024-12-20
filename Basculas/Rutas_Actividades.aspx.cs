using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Basculas_Rutas_Actividades : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataBind();
        }
    }

    private void DataBind()
    {

        sql_rutas_actividades.SelectCommand = "SELECT * FROM [dbo].[ALMAPAC$Work Type]";
        sql_rutas_actividades.DataBind();
        gvw_rutas_plantillas.DataSource = sql_rutas_actividades;
        gvw_rutas_plantillas.DataBind();

    }


    protected void lnk_VerRuta_Click(object sender, EventArgs e)
    {
        LinkButton lnk_VerRuta = (LinkButton)sender;
        GridViewRow row = (GridViewRow)lnk_VerRuta.NamingContainer;
        GridView gvw = (GridView)row.NamingContainer;


        ////Guarda el valor de la llave primaria.
        hfCodigo.Value = gvw_rutas_plantillas.DataKeys[row.RowIndex].Value.ToString();

        //Hace el Binding.
       DataBindRutasDetalles();

        //Muestra el modal una vez hecho click en la fila.
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal-convertir", "$('#modal-detalle').modal();", true);
    }


    private void DataBindRutasDetalles()
    {
        //Delcara las variables.
        string strWhere = " WHERE Fk_Actividad =" + hfCodigo.Value;
        string strSQL = "SELECT * FROM vw_LEVERANS_PLANTILLA_RUTAS";
        string strOrder = "";

        ////Ejecuta la consulta.
        sql_rutas_actividadesDetalles.SelectCommand = strSQL + strWhere + strOrder;
        sql_rutas_actividadesDetalles.Select(new DataSourceSelectArguments());

        //Relaciona el recordset con el GridView
        sql_rutas_actividadesDetalles.DataBind();
        gvw_rutasDetalles.DataBind();
    }


    protected void gvw_rutasDetalles_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        GridView gvw_rutasDetalles = (GridView)sender;
        sql_rutas_actividadesDetalles.DeleteParameters["PK_Rutas"].DefaultValue = gvw_rutasDetalles.DataKeys[e.RowIndex].Value.ToString();
        sql_rutas_actividadesDetalles.Delete();

        gvw_rutasDetalles.EditIndex = -1;
        DataBindRutasDetalles();
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
        DataBindRutasDetalles();
    }


    protected void btn_agregar_Click(object sender, EventArgs e)
    {
        LinkButton btnAgregar = (LinkButton)sender;
        GridViewRow gvw_row = (GridViewRow)btnAgregar.NamingContainer;

        //asignamos los valores a los parametros
        sql_rutas_actividadesDetalles.InsertParameters["Correlativo"].DefaultValue = (gvw_row.FindControl("txt_correlativo") as TextBox).Text;
        sql_rutas_actividadesDetalles.InsertParameters["FK_Acceso"].DefaultValue = "1";
        sql_rutas_actividadesDetalles.InsertParameters["FK_Actividad"].DefaultValue = hfCodigo.Value;
        //Ejecutamos el query

        sql_rutas_actividadesDetalles.Insert();
        DataBindRutasDetalles();
        //Response.Redirect(Request.RawUrl, false);
    }


}