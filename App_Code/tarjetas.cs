using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de tarjetas
/// </summary>
public class tarjetas
{
    public int PK_TarjetaBascula { get; set; }
    public string N_tarjeta { get; set; }
    public int FK_Bascula { get; set; }
    public int N_Lectora { get; set; }
    public DateTime Fecha { get; set; }
    public int Estado { get; set; }
}