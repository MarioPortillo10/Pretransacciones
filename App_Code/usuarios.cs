using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace disa_ws_01.App_Code
{
    public class usuarios
    {
        string _codigo;
        string _value;

        public string value
        {
            get { return _value; }
            set { _value = value; }
        }

        public string codigo
        {
            get { return _codigo; }
            set { _codigo = value; }
        }
    }
}