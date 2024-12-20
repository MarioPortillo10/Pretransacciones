using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Basculas_Rutas_Transacciones : System.Web.UI.Page
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

        SqlPrincipal.SelectCommand = "select top 1000 * from vw_Leverans_PreTransacciones where cod_estado not in(1) and codTransaccion <> null order by PK_PreTransaccion desc";

        SqlPrincipal.DataBind();

        gvw_principal.DataSource = SqlPrincipal;

        gvw_principal.DataBind();

    }


    private void DataBindRutasDetalles()
    {
        ////Delcara las variables.
        //string strWhere = " WHERE FK_Transaccion =" + hfcod_transaccion.Value;
        //string strSQL = " SELECT * FROM [LEVERANS].[dbo].[LEVERANS_RutasDetalles]";
        //string strOrder = "";

        //////Ejecuta la consulta.
        //SqlSubPrincipal.SelectCommand = strSQL + strWhere + strOrder;
        //SqlSubPrincipal.Select(new DataSourceSelectArguments());

        ////Relaciona el recordset con el GridView
        //SqlSubPrincipal.DataBind();
        //gvw_subprincipal.DataBind();
    }






    protected void lnk_verRuta_Click(object sender, EventArgs e)
    {
        LinkButton lnk_VerRuta = (LinkButton)sender;
        GridViewRow row = (GridViewRow)lnk_VerRuta.NamingContainer;
        GridView gvw = (GridView)row.NamingContainer;


        ////Guarda el valor de la llave primaria.
        hfcod_transaccion.Value = gvw_principal.DataKeys[row.RowIndex].Value.ToString();
        hfcod_Actividad.Value = lnk_VerRuta.CommandArgument;
        //Hace el Binding.
        DataBindRutasDetalles();

        //Muestra el modal una vez hecho click en la fila.
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal-convertir", "$('#modal-detalle').modal();", true);
    }

    protected void btn_agregar_Click(object sender, EventArgs e)
    {
        LinkButton btnAgregar = (LinkButton)sender;
        GridViewRow gvw_row = (GridViewRow)btnAgregar.NamingContainer;

        //asignamos los valores a los parametros
        SqlSubPrincipal.InsertParameters["Correlativo"].DefaultValue = (gvw_row.FindControl("txt_correlativo") as TextBox).Text;
        SqlSubPrincipal.InsertParameters["FK_Acceso"].DefaultValue = (gvw_row.FindControl("ddlAccesos") as DropDownList).SelectedValue;
        SqlSubPrincipal.InsertParameters["FK_Actividad"].DefaultValue = hfcod_Actividad.Value;
        SqlSubPrincipal.InsertParameters["FK_Transaccion"].DefaultValue = hfcod_transaccion.Value;
        //Ejecutamos el query

        SqlSubPrincipal.Insert();
        DataBindRutasDetalles();
        Response.Redirect(Request.RawUrl, false);
        //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "modal-convertir", "$('#modal-detalle').modal();", true);



    }

    protected void gvw_subprincipal_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        GridView gvw_Subgrid = (GridView)sender;
        SqlSubPrincipal.DeleteParameters["PK_RutaDetalle"].DefaultValue = gvw_Subgrid.DataKeys[e.RowIndex].Value.ToString();
        SqlSubPrincipal.Delete();

        gvw_Subgrid.EditIndex = -1;
        Response.Redirect(Request.RawUrl, false);
    }

    protected void gvw_subprincipal_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {

        GridView gvw_Subgrid = (GridView)sender;
        GridViewRow row = gvw_Subgrid.Rows[e.RowIndex];

        SqlSubPrincipal.UpdateParameters["PK_RutaDetalle"].DefaultValue = gvw_Subgrid.DataKeys[e.RowIndex].Value.ToString();
        SqlSubPrincipal.UpdateParameters["Correlativo"].DefaultValue = (row.FindControl("txt_correlativo") as TextBox).Text;
        SqlSubPrincipal.UpdateParameters["FK_Acceso"].DefaultValue = (row.FindControl("ddlAccesos") as DropDownList).SelectedValue;
        SqlSubPrincipal.UpdateParameters["Estado"].DefaultValue = ((row.FindControl("CheckBox1") as CheckBox).Checked).ToString();
        SqlSubPrincipal.Update();
        Response.Redirect(Request.RawUrl, false);
    }

    protected void gvw_principal_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvw_principal.PageIndex = e.NewPageIndex;
        DataBind();
    }



    protected void lnk_salir_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        FormsAuthentication.RedirectToLoginPage();
    }
}