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

public partial class Basculas_Default3 : System.Web.UI.Page
{
    bascula ob_bascula = new bascula();


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //BindListView(1);
            DataBind();
       
        }
    }

    protected void lnkBuscar_Click(object sender, EventArgs e)
    {

        DataBind();

    }

    private void DataBind()
    {
        string query = "SELECT TOP 100 * FROM vw_Leverans_PreTransacciones";
        string where = "";
        string order = " ORDER BY PK_PreTransaccion DESC";

        if (!string.IsNullOrEmpty(txtTransaccion.Text))
        {
            if (where.Length > 0)
                where += " AND cod_transaccion=" + txtTransaccion.Text;
            else
                where += " WHERE cod_transaccion=" + txtTransaccion.Text;
        }
        ////Concatena el estado.
        //if (ddl_Estado.SelectedIndex > 0)
        //    if (where.Length > 0)
        //        where += " AND (cod_estado=" + ddl_Estado.SelectedValue + ")";
        //    else
        //        where += " WHERE (cod_estado=" + ddl_Estado.SelectedValue + ")";      

        SqlDataSource1.SelectCommand = query + where + order;
        ListView1.DataBind();
    }

    public void BindListView(int pageNo)
    {
 
        int pageSize = 6;

        dtpPrincipal.PageSize = pageSize;
       // gvw_transacciones.PageSize = pageSize;

        string ConnectionString = ConfigurationManager.AppSettings["ConnProduccion"];
        SqlConnection conn = new SqlConnection(ConnectionString);


        SqlCommand cmd = new SqlCommand();
        DataSet dataSet = new DataSet();


        cmd.Connection = conn;
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.CommandText = "[dbo].[sp_GetLEVERANS_trans_documentoByCustomPaging]";




        cmd.Parameters.AddWithValue("@PageNo", pageNo);
        cmd.Parameters.AddWithValue("@pageSize", pageSize);



        SqlDataAdapter sqlDataAdapter = new SqlDataAdapter();
        sqlDataAdapter.SelectCommand = cmd;

        try
        {
            sqlDataAdapter.Fill(dataSet);
            var resul = sqlDataAdapter.Fill(dataSet);
            //.
            //dtpPrincipal.PagedControlID= Convert.ToInt32(dataSet.Tables[1].Rows[0]["Total"]);
            //gvw_trans.VirtualItemCount = Convert.ToInt32(dataSet.Tables[1].Rows[0]["Total"]);
            //ListView1.
            ListView1.DataSource = dataSet.Tables[0];
            ListView1.DataBind();
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
        finally
        {
        }
    }



    protected void lvwPrincipal_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {

        dtpPrincipal.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        DataBind();
    }

    protected void autoriza_ServerClick(object sender, EventArgs e)
    {
        Response.Redirect(Request.RawUrl);
    }


    [System.Web.Services.WebMethod]
    public static void GetData(string username, string bascula)
    {
        //using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnStr"]))
        //{
        //    using (SqlCommand cmd = new SqlCommand("sp_PreTransaccion_Autorizar", con))
        //    {
        //        cmd.CommandType = CommandType.StoredProcedure;
        //        cmd.Parameters.AddWithValue("@ip", dato.ip);
        //        cmd.Parameters.AddWithValue("@acceso", dato.acceso);
        //        cmd.Parameters.AddWithValue("@obstaculo", dato.obstaculo);
        //        con.Open();

        //        cmd.ExecuteNonQuery();
        //    }
        //}

        //return string.Format("Username: {0}{2}Bascula: {1}", username, bascula, Environment.NewLine);
    }

    protected void Button1_Click(object sender, EventArgs e)
    {

    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        FormsAuthentication.RedirectToLoginPage();
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        FormsAuthentication.RedirectToLoginPage();
    }

    protected void LinkButton2_Click(object sender, EventArgs e)
    {

    }

    protected void lnk_autorizar_Click(object sender, EventArgs e)
    {
        LinkButton lnk_autorizar_Click = (LinkButton)sender;

        int cod_pretransaccion = Convert.ToInt32(lnk_autorizar_Click.CommandArgument);

        int cod_bascula = Convert.ToInt32(Request.Cookies["cod_bascula"].Value);
        string username = Request.Cookies["username"].Value;



        //Autoriza y crea transaccion en NAV
        ob_bascula.AUTORIZA_INGRESO_EN_ACCESO(cod_pretransaccion, username, cod_bascula, 1);


        DataBind();

    }


    protected void lnk_autorizar2_Click(object sender, EventArgs e)
    {
        LinkButton lnk_autorizar2_Click = (LinkButton)sender;
        string[] arg = new string[2];
        arg = lnk_autorizar2_Click.CommandArgument.ToString().Split(';');


        //int cod_pretransaccion = Convert.ToInt32(lnk_autorizar2_Click.CommandArgument);


        int cod_pretransaccion = Convert.ToInt32(arg[0]);
        int id = Convert.ToInt32(arg[1]);
        string username = Request.Cookies["username"].Value;

        //Autoriza pesaje
        ob_bascula.Autorizar(cod_pretransaccion,id,username);

        //int cod_bascula = Convert.ToInt32(Request.Cookies["cod_bascula"].Value);//Response.Cookies["cod_bascula"].Value;
        //string username = Request.Cookies["username"].Value;//Response.Cookies["username"].Value;




        DataBind();

    }




    //Metodo para Ocultar btn Autorizar
    protected void ListView1_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        if (e.Item.ItemType == ListViewItemType.DataItem)
        {
            LinkButton lnk_autorizar = e.Item.FindControl("lnk_autorizar") as LinkButton;
            LinkButton lnk_autorizar2 = e.Item.FindControl("lnk_autorizar2") as LinkButton;
            Label lbl_cod_estado = e.Item.FindControl("lbl_cod_estado") as Label;

            if (lbl_cod_estado.Text == "1")
            {
                lnk_autorizar.Visible = false;
                lnk_autorizar2.Visible = true;

            }

            if (lbl_cod_estado.Text == "2")
            {
                lnk_autorizar2.Visible = false;
            }

            if (lbl_cod_estado.Text == "4")
            {
                lnk_autorizar.Visible = false;
                lnk_autorizar2.Visible = false;
            }

        }

        }
}