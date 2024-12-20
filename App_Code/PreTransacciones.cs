using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de PreTransacciones
/// </summary>
public class PreTransacciones
{
    public PreTransacciones()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }


    public int PK_PreTransaccion { get; set; }
    public string ntarjeta { get; set; }
    public string cod_actividad { get; set; }
    public string desc_actividad { get; set; }
    public string buque { get; set; }
    public string boleta_cepa { get; set; }
    public string viaje_cepa { get; set; }
    public string producto { get; set; }
    public string vehiculo { get; set; }
    public string peso_cepa { get; set; }
    public DateTime fecha_creacion { get; set; }
    public DateTime fecha_update { get; set; }
    public int FK_PreTransaccion_Estado { get; set; }
    public int nbascula { get; set; }
    public string username { get; set; }
    public string cod_producto { get; set; }
    public string cod_buque { get; set; }
    public bool manual { get; set; }




    //recuperamos Datos de la Pretransaccion
    public PreTransacciones GET_Pre_Transaccion(int PK_PreTransaccion) {
        PreTransacciones obj_preTransacciones = new PreTransacciones();


        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnStr_LEVERANS_prod"]))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM vw_LEVERANS_PreTransacciones2 WHERE PK_PreTransaccion=" + PK_PreTransaccion, con))
            {
                cmd.CommandType = CommandType.Text;
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                //Valida si existen registros.
                if (reader.HasRows)
                {
                    //Recorre todos los registros.
                    while (reader.Read())
                    {

                        obj_preTransacciones.PK_PreTransaccion = Convert.ToInt32(reader["PK_PreTransaccion"]);
                        obj_preTransacciones.ntarjeta = reader["ntarjeta"].ToString();
                        obj_preTransacciones.cod_actividad = reader["cod_actividad"].ToString();
                        obj_preTransacciones.desc_actividad = reader["desc_actividad"].ToString();
                        obj_preTransacciones.buque = reader["buque"].ToString();
                        obj_preTransacciones.boleta_cepa = reader["boleta_cepa"].ToString();
                        obj_preTransacciones.viaje_cepa = reader["viaje_cepa"].ToString();
                        obj_preTransacciones.producto = reader["producto"].ToString();
                        obj_preTransacciones.vehiculo = reader["vehiculo"].ToString();
                        obj_preTransacciones.peso_cepa = reader["peso_cepa"].ToString();
                        obj_preTransacciones.FK_PreTransaccion_Estado = Convert.ToInt32(reader["FK_PreTransaccion_Estado"]);
                        obj_preTransacciones.username = reader["username"].ToString();
                        obj_preTransacciones.cod_producto = reader["cod_producto"].ToString();
                        obj_preTransacciones.cod_buque = reader["cod_buque"].ToString();
                        obj_preTransacciones.manual = Convert.ToBoolean(reader["manual"]);

                        //Envía el correo al usuario.
                        //requisicion.intCodigo = Convert.ToInt32(id_req);
                        //requisicion.email = reader["correo"].ToString();


                    }
                }

                else {
                    obj_preTransacciones = null;
                }

            }


        }

        return obj_preTransacciones;


    }



    public void UpdatePreTransacciones(int codigo, string ntarjeta, string cod_actividad, string actividad)
    {

        string ConnectionString = ConfigurationManager.AppSettings["ConnStr_LEVERANS_prod"];

        using (SqlConnection con02 = new SqlConnection(ConnectionString))
        {
            using (SqlCommand cmd02 = new SqlCommand("sp_PreTransaccionesUpdate", con02))
            {
                cmd02.CommandType = CommandType.StoredProcedure;
                cmd02.Parameters.Add("@codigo", SqlDbType.Int).Value = codigo;
                cmd02.Parameters.Add("@ntarjeta", SqlDbType.NVarChar).Value = ntarjeta;
                cmd02.Parameters.Add("@cod_actividad", SqlDbType.NVarChar).Value = cod_actividad;
                cmd02.Parameters.Add("@actividad", SqlDbType.NVarChar).Value = actividad;
                con02.Open();

                cmd02.ExecuteNonQuery();
            }
        }
    }


    public void DeletePreTransaccion(int codigo)
    {
        string ConnectionString = ConfigurationManager.AppSettings["ConnStr_LEVERANS_prod"];

        using (SqlConnection con02 = new SqlConnection(ConnectionString))
        {
            using (SqlCommand cmd02 = new SqlCommand("sp_LEVERANS_PreTransacciones_Delete", con02))
            {
                cmd02.CommandType = CommandType.StoredProcedure;
                cmd02.Parameters.Add("@codigo", SqlDbType.Int).Value = codigo;
                con02.Open();

                cmd02.ExecuteNonQuery();
            }
        }

    }


    public void DisponibilidadTarjeta() {

    }


 




}