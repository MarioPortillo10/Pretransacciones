using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for arduino
/// </summary>
public class arduino
{
    public arduino()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    int _acceso;
    public int acceso
    {
        get { return _acceso; }
        set { _acceso = value; }
    }
    public string ip { get; set; }
    public bool obstaculo { get; set; }
    public string tarjeta { get; set; }
}