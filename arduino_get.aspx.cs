using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Xml;

namespace disa_ws_01
{
    public partial class arduino_get : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string acceso = "1";
            string strURL = "http://192.168.1.8:8888/pluma/abrir/" + acceso;



            WebClient wc = new WebClient();
            byte[] data = wc.DownloadData(strURL);
            Response.Write( System.Text.Encoding.UTF8.GetString(data));
        }
    }
}