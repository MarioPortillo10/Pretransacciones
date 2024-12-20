using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Tarjetas_arduino
/// </summary>
public class Tarjetas_arduino
{
    public Tarjetas_arduino()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }


    public int codigo { get; set; }
    public DateTime fecha { get; set; }
    public string tarjeta { get; set; }
    public int acceso { get; set; }
    public int estado { get; set; }
	public int transaccion { get; set; }
}