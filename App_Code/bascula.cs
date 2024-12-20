using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;

/// <summary>
/// Descripción breve de bascula
/// </summary>
public class bascula
{
    public int N_Bascula { get; set; }
    public string Descripcion { get; set; }

    string url_webserviceNav = ""; 


    //autorizacion para pesaje
    public void Autorizar(int cod_pretransaccion, int cod_transaccion, string usuario)
    {
        url_webserviceNav =  ConfigurationManager.AppSettings["ws_transacciones.Registro_Interfaz"];

        try
        {
            //actualizamos el estado de la pretransaccion
            ws_transacciones.Registro_Interfaz2_Service ws_transaccion = new ws_transacciones.Registro_Interfaz2_Service();


            //autorizamos estado de PreTransaccion
            UpdateEstadoPreTransaccion(cod_pretransaccion,4);



            //Actualizamos el campo estatus de la transaccion
            ws_transaccion.Url = url_webserviceNav; //"-http://10.10.21.10:7047/DynamicsNAV90/WS/ARDUINOS/Page/Registro_Interfaz2";
            NetworkCredential nc = new NetworkCredential("NAVadmin", ".4LmaP4c#20$23!", "ALMAPAC");
            ws_transaccion.Credentials = nc;
            ws_transacciones.Registro_Interfaz2 t = ws_transaccion.Read(cod_transaccion);
            t.estatus = 0;
            t.usuario = "ALMAPAC\\"+ usuario;
            ws_transaccion.Update(ref t);


        }
        catch (Exception)
        {
  
        }
    }



    //autoriza ingreso
    public void Autorizar_ingreso(int cod_pretransaccion, int cod_transaccion, string usuario)
    {
        url_webserviceNav = ConfigurationManager.AppSettings["ws_transacciones.Registro_Interfaz"];

        try
        {
            //actualizamos el estado de la pretransaccion
            ws_transacciones.Registro_Interfaz2_Service ws_transaccion = new ws_transacciones.Registro_Interfaz2_Service();


            //autorizamos ingreso de vehiculo
            UpdateEstadoPreTransaccion(cod_pretransaccion, 2);



            //Actualizamos el campo estatus de la transaccion
            ws_transaccion.Url = url_webserviceNav; //"-http://10.10.21.10:7047/DynamicsNAV90/WS/ARDUINOS/Page/Registro_Interfaz2";
            NetworkCredential nc = new NetworkCredential("NAVadmin", ".4LmaP4c#20$23!", "ALMAPAC");
            ws_transaccion.Credentials = nc;
            ws_transacciones.Registro_Interfaz2 t = ws_transaccion.Read(cod_transaccion);
            t.estatus = 1;
            t.semaforo2 = 2;
            t.usuario = "ALMAPAC\\" + usuario;
            ws_transaccion.Update(ref t);


        }
        catch (Exception)
        {

        }
    }




    public void AUTORIZA_INGRESO_EN_ACCESO(int cod_pretransaccion, string username, int cod_bascula, int cod_estado)
    {

        //try
        //{
        //    //creamos la transaccion
            

            if (Create_Transaccion(cod_pretransaccion,username))
            {
            //si creo la transaccion autorizamos
            update_preTransaccion(cod_pretransaccion,username,cod_bascula,cod_estado);
            }


      //  }
        //catch (Exception)
        //{

    
        //}

    }



    public void update_preTransaccion(int cod_pretransaccion, string username, int cod_bascula, int cod_estado)
    {
        //si creo la transaccion autorizamos
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnStr_LEVERANS_prod"]))
        {
            using (SqlCommand cmd = new SqlCommand("LEVERANS_Autoriza_ingreso_vehicular", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@codigo", cod_pretransaccion);
                cmd.Parameters.AddWithValue("@username", username);
                cmd.Parameters.AddWithValue("@bascula", cod_bascula);
                cmd.Parameters.AddWithValue("@cod_estado", cod_estado);
                con.Open();

                cmd.ExecuteNonQuery();
            }
        }

    }

    public void UpdateEstadoPreTransaccion(int codigo,int cod_estado)
    {
        //creamos el detalle de las rutas
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnStr_LEVERANS_prod"]))
        {
            using (SqlCommand cmd = new SqlCommand("sp_LEVERANS_UpdateEstadoPreTransaccion", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@codigo", codigo);
                cmd.Parameters.AddWithValue("@cod_estado", cod_estado);
               
                con.Open();

                cmd.ExecuteNonQuery();
            }
        }

    }




    public void AddRutasDetalle(int cod_transaccion, int cod_actividad, int PK_PreTransaccion)
    {
        //creamos el detalle de las rutas
        using (SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["ConnStr_LEVERANS_prod"]))
        {
            using (SqlCommand cmd = new SqlCommand("sp_LEVERANS_AddRutasDetalle", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@cod_transaccion", cod_transaccion);
                cmd.Parameters.AddWithValue("@cod_actividad", cod_actividad);
                cmd.Parameters.AddWithValue("@PK_PreTransaccion", PK_PreTransaccion);
                con.Open();

                cmd.ExecuteNonQuery();
            }
        }

    }



    public bool Create_Transaccion(int PK_PreTransaccion, string usuario) {

        bool result = false;
        url_webserviceNav = ConfigurationManager.AppSettings["ws_transacciones.Registro_Interfaz"];


        //referencia al ws
        ws_transacciones.Registro_Interfaz2_Service create_trans = new ws_transacciones.Registro_Interfaz2_Service();
        create_trans.Url = url_webserviceNav;//"-http://10.10.21.10:7047/DynamicsNAV90/WS/ARDUINOS/Page/Registro_Interfaz2";
        NetworkCredential nc = new NetworkCredential("NAVadmin", ".4LmaP4c#20$23!", "ALMAPAC");
        create_trans.Credentials = nc;

        //variable que almacena el id de la transaccion que se creara
        int codigo = 0;

        //accedemos creamos instacia para acceder al metodo que nos retorna los datos de la pretransaccion
        PreTransacciones ob_p = new PreTransacciones();
        PreTransacciones preTransaccion = ob_p.GET_Pre_Transaccion(PK_PreTransaccion);

        if (preTransaccion != null)
        {


            //si la actividad es recepcion de cereales o manuales
            if (preTransaccion.cod_actividad == "3" || preTransaccion.manual)
            {
                ws_transacciones.Registro_Interfaz2 new_transaccion_cereales = new ws_transacciones.Registro_Interfaz2();

                //creamos una transaccion vacia
                create_trans.Create(ref new_transaccion_cereales);

                codigo = new_transaccion_cereales.id;

                //objeto para update
                ws_transacciones.Registro_Interfaz2 t = create_trans.Read(codigo);

                if (preTransaccion.cod_actividad == "3")
                {
                    t.tarjetano = Convert.ToInt32(preTransaccion.ntarjeta);
                    t.actividad = preTransaccion.cod_actividad;
                    if (preTransaccion.cod_producto != "0")
                    {
                        t.producto = preTransaccion.cod_producto;
                    }

                    t.vehiculo = preTransaccion.vehiculo;

                    t.viajecepa = preTransaccion.viaje_cepa;
                    t.boletacepa = preTransaccion.boleta_cepa;
                    t.estatus = 1;
                    t.usuario= "ALMAPAC\\" + usuario;

                    //validamos si el OCR detecto pesocepa
                    decimal peso2=0;
                    bool success = Decimal.TryParse(preTransaccion.peso_cepa, out peso2);
                    t.pesocepa = peso2;
                    
                    
                }

                else
                {
                    t.tarjetano = Convert.ToInt32(preTransaccion.ntarjeta);
                    t.actividad = preTransaccion.cod_actividad;
                    t.estatus = 1;
                    t.usuario = "ALMAPAC\\" + usuario;
                }




                t.semaforo2 = 2;
                t.semaforo4 = preTransaccion.PK_PreTransaccion;
                

                //t.estatus = 1;
                //validamos si existe un codigo valido de producto

                
                //t.codbuque = "PCOKE - 001";//preTransaccion.cod_buque;

                //update
                create_trans.Update(ref t);
                result = true;
            }


            //metodo para crear transacciones diferentes a recepcion de cereales
            else
            {
                ws_transacciones.Registro_Interfaz2 t1 = new ws_transacciones.Registro_Interfaz2();

                //creamos una transaccion vacia
                create_trans.Create(ref t1);

                codigo = t1.id;

                //objeto para update
                ws_transacciones.Registro_Interfaz2 t = create_trans.Read(codigo);
                t.tarjetano = Convert.ToInt32(preTransaccion.ntarjeta);
                t.estatus = 1;
                t.semaforo2 = 0;
                t.semaforo4 = preTransaccion.PK_PreTransaccion;
                t.actividad = preTransaccion.cod_actividad;
                t.usuario = "ALMAPAC\\" + usuario;

                // t.usuario = "ALMAPAC\\"+preTransaccion.username;

                //update
                create_trans.Update(ref t);
                result = true;

            }

            //creamos la ruta de la actividad
            AddRutasDetalle(codigo, Convert.ToInt32(preTransaccion.cod_actividad), PK_PreTransaccion);
        }


   

        return result;

    }


}