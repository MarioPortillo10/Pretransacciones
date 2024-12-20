using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace disa_ws_01
{
    public partial class arduino_post : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            string salida;

            if (!string.IsNullOrEmpty(Request.QueryString["tarjeta"]) && !string.IsNullOrEmpty(Request.QueryString["acceso"]))
            {
                string tarjeta = Request.QueryString["tarjeta"];
                int acceso = int.Parse(Request.QueryString["acceso"]);
                salida = "acceso:" + acceso.ToString() + ";tarjeta=" + tarjeta;
            }                
            else
                salida = "0";

            Response.Clear();
            Response.ClearHeaders();
            Response.AddHeader("Content-Type", "text/plain");
            Response.Write(salida);
            Response.Flush();
            Response.End();
        }

        


    }
}