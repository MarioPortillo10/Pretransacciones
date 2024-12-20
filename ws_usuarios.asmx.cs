using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


namespace disa_ws_01
{
    /// <summary>
    /// Summary description for ws_usuarios
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class ws_usuarios : System.Web.Services.WebService
    {
        
        public ws_usuarios() {

            //Uncomment the following line if using designed components 
            //InitializeComponent(); 
        }

        //WebService para obtener la data.
        [WebMethod]
        public List<usuarios> getData()
        {
            List<usuarios> salida = new List<usuarios>();
            string ConnectionString = ConfigurationManager.AppSettings["ConnStr"];
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = string.Format("SELECT codigo, usuario, nombres, apellidos, clave FROM usuarios");
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        usuarios datos = new usuarios();
                        datos.codigo = int.Parse(reader[0].ToString());
                        datos.usuario = reader[1].ToString();
                        datos.nombres = reader[2].ToString();
                        datos.apellidos = reader[3].ToString();
                        datos.clave = reader[4].ToString();
                        salida.Add(datos);
                    }
                }
                con.Close();
            }
            return salida;
        }

        //WebService para obtener la data.
        [WebMethod]
        public void setData()
        {

        }
    }

    public class usuarios
    {
        string _nombres;
        public string nombres
        {
            get { return _nombres; }
            set { _nombres = value; }
        }

        string _apellidos;
        public string apellidos
        {
            get { return _apellidos; }
            set { _apellidos = value; }
        }

        string _usuario;
        public string usuario
        {
            get { return _usuario; }
            set { _usuario = value; }
        }

        int _codigo;
        public int codigo
        {
            get { return _codigo; }
            set { _codigo = value; }
        }

        string _clave;
        public string clave
        {
            get { return _clave; }
            set { _clave = value; }
        }

    }
}
