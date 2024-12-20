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
    /// Summary description for ws_proyectos_equipos
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class ws_proyectos_equipos : System.Web.Services.WebService
    {
        public ws_proyectos_equipos()
        {

            //Uncomment the following line if using designed components 
            //InitializeComponent(); 
        }

        //WebService para obtener la data.
        [WebMethod]
        public List<proyectos_equipos> getData()
        {
            List<proyectos_equipos> salida = new List<proyectos_equipos>();
            string ConnectionString = ConfigurationManager.AppSettings["ConnStr"];
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                string query = string.Format("SELECT codigo, cod_vehiculo, fecha_hora_inicio, fecha_hora_fin, cod_proyecto FROM proyectos_equipos");
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        proyectos_equipos datos = new proyectos_equipos();
                        datos.codigo = int.Parse(reader[0].ToString());
                        datos.cod_vehiculo = int.Parse(reader[1].ToString());
                        datos.fecha_hora_inicio = DateTime.Parse(reader[2].ToString()).ToString("s");
                        datos.fecha_hora_fin = DateTime.Parse(reader[3].ToString()).ToString("s");
                        datos.cod_proyecto = int.Parse(reader[4].ToString());
                        salida.Add(datos);
                    }
                }
                con.Close();
            }
            return salida;
        }

        //WebService para ingresar la data.
        [WebMethod]
        public void setData(List<proyectos_equipos> arreglo)
        {
            foreach (proyectos_equipos dato in arreglo)
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnStr"]))
                {
                    using (SqlCommand cmd = new SqlCommand("sp_ws_proyectos_equipos", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@codigo", dato.codigo);
                        cmd.Parameters.AddWithValue("@cod_vehiculo", dato.cod_vehiculo);
                        cmd.Parameters.AddWithValue("@fecha_hora_inicio", dato.fecha_hora_inicio);
                        cmd.Parameters.AddWithValue("@fecha_hora_fin", dato.fecha_hora_fin);
                        cmd.Parameters.AddWithValue("@cod_proyecto", dato.cod_vehiculo);
                        cmd.Parameters.AddWithValue("@merged", dato.merged);
                        con.Open();

                        cmd.ExecuteNonQuery();
                    }
                }
            }
        }
    }

    public class proyectos_equipos
    {
        int _codigo;
        public int codigo
        {
            get { return _codigo; }
            set { _codigo = value; }
        }

        int _cod_vehiculo;
        public int cod_vehiculo
        {
            get { return _cod_vehiculo; }
            set { _cod_vehiculo = value; }
        }

        string _fecha_hora_inicio;
        public string fecha_hora_inicio
        {
            get { return _fecha_hora_inicio; }
            set { _fecha_hora_inicio = value; }
        }

        string _fecha_hora_fin;
        public string fecha_hora_fin
        {
            get { return _fecha_hora_fin; }
            set { _fecha_hora_fin = value; }
        }

        int _cod_proyecto;
        public int cod_proyecto
        {
            get { return _cod_proyecto; }
            set { _cod_proyecto = value; }
        }

        bool _merged;
        public bool merged
        {
            get { return _merged; }
            set { _merged = value; }
        }
    }
}
