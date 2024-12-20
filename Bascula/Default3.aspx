<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default3.aspx.cs" Inherits="Basculas_Default3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Imágenes escaneadas</title>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.2/css/all.css" integrity="sha384-/rXc/GQVaYpyDdyxK+ecHPVYJSN9bmVFBvjA/9eOB+pb3F2w2N6fc5qB9Ew5yIns" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/fancyapps/fancybox@3.5.6/dist/jquery.fancybox.min.css" />

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/gh/fancyapps/fancybox@3.5.6/dist/jquery.fancybox.min.js"></script>
    <script type="text/javascript">
        $('[data-fancybox="gallery"]').fancybox({
            // Options will go here
        });
    </script>

    <script>
        $(document).ready(function () {
        //                $.ajax({
        //        type: "POST",                                            // tipo de request que estamos generando
        //        url: 'default.aspx/ddl_get_actividades',                              // URL al que vamos a hacer el pedido
        //        data: null,                                                // data es un arreglo JSON que contiene los parámetros que 
        //        // van a ser recibidos por la función del servidor
        //        contentType: "application/json; charset=utf-8",            // tipo de contenido
        //        dataType: "json",
        //        success: function (data) {
        //            var result = data.d;

        //            //console.log(result);
        //            //$.each(data, function (index, item) {
        //            //    console.log(item.codigo);
        //            //});

        //            // console.log(data);

        //            //alert("ok");
        //            var s = '<option value="-1">Please Select a Department</option>';
        //            //for (var i = 0; i < data.length; i++) {
        //            //    //consolo.log(data.length);
        //            //    //s += '<option value="' + data[i].codigo + '">' + data[i].descripcion + '</option>';
        //            //    console.log("codigo:" + data[i].codigo);
        //            //    console.log("descripcion:" + data[i].descripcion);
        //            //}
        //            $("#ddlActividades").html(s);
        //        },

        //        failure: function (data) {
        //            alert(data.d);
        //        },
        //        error: function (data) {
        //            alert(data.d);
        //        }
        //    });
        //});



        });
    </script>

    <script type="text/javascript">

        function asignaUser(codigo) {

            debugger;
            var codigo = codigo;
            var username = getCookie("username");
            $('#inputUsername').val(username);
        }

        function getCookie(cname) {
            var name = cname + "=";
            var ca = document.cookie.split(';');
            for (var i = 0; i < ca.length; i++) {
                var c = ca[i];
                while (c.charAt(0) == ' ') {
                    c = c.substring(1);
                }
                if (c.indexOf(name) == 0) {
                    return c.substring(name.length, c.length);
                }
            }
            return "";
        }


        function valida(f) {



            var campo = $('#inputUsername').val();
            var campo2 = $('#select_bascula').val();


            var ok = true;
            if (campo == "") {
                ok = false;
            }

            if (campo2 == "") {
                ok = false;

            }

            if (ok) {
                GetData();
                //$('#exampleModal').modal('hide');
                //document.location.reload();
            }

        }



    </script>

    <style>
        .Content12 {
            -webkit-border-radius: 10px 10px 10px 10px;
            border-radius: 10px 10px 10px 10px;
            background: #fff;
            padding: 30px;
            width: 100%;
            max-width: 450px;
            position: relative;
            padding: 0px;
            -webkit-box-shadow: 0 30px 60px 0 rgba(0,0,0,0.3);
            box-shadow: 0 30px 60px 0 rgba(0,0,0,0.3);
            /*text-align: center;*/
        }
    </style>

    <script type="text/javascript">  
        function GetData() {
            var obj = {};

            obj.username = $('#inputUsername').val();
            obj.bascula = $('#select_bascula').val();
            $.ajax({
                type: "POST",
                url: "Default3.aspx/GetData",
                data: JSON.stringify(obj),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $('#btn_close').trigger("click");
                    $('.modal-backdrop').remove();
                    $('#inputUsername').val('franklin');
                    __doPostBack('<%=UpdatePanel1.ClientID%>', '');
                    //alert(response.d);
                    //var username = getCookie("username");

                },
            });
        }

    </script>


</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">ALMAPAC</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">

                    <li class="nav-item active">
                        <a class="nav-link" href="Default.aspx">Pre-Transacciones</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="Rutas_Transacciones.aspx">Rutas Transacciones</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="Rutas_Actividad.aspx">Rutas Actividades</a>
                    </li>
                </ul>
            </div>
        </nav>

        <div class="container" id="conten">

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnProduccion %>"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sql_estados" ConnectionString="<%$ ConnectionStrings:ConnProduccion %>" runat="server" SelectCommand="SELECT * FROM LEVERANS_PreTransaccion_Estados ORDER BY codigo ASC"></asp:SqlDataSource>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>

                    <div class="row ml-4">
                        <h3>Documentos escaneados</h3>
                    </div>

                    <div class="row ml-3">
                        <div class="col-12">
                            <div class="input-group mb-3" style="border: solid 0px;">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"># de Transacción</span>
                                </div>
                                <asp:TextBox ID="txtTransaccion" CssClass="form-control col-2" runat="server"></asp:TextBox>
                                <div class="input-group-append">
                                    <asp:DropDownList ID="ddl_Estado" CssClass="form-control" runat="server" DataSourceID="sql_estados" DataValueField="codigo" DataTextField="descripcion" AppendDataBoundItems="true">
                                        <asp:ListItem Value="0">Todos</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:LinkButton ID="lnkBuscar" CssClass="btn btn-outline-secondary" OnClick="lnkBuscar_Click" runat="server">Buscar</asp:LinkButton>
                                    <asp:LinkButton ID="LinkButton2" CssClass="btn btn-outline-secondary" OnClick="LinkButton1_Click" runat="server">Salir</asp:LinkButton>

                                </div>

                            </div>

                        </div>
                    </div>

                    <div class="row" style="border: solid 0px">
                        <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource1" OnPagePropertiesChanging="lvwPrincipal_PagePropertiesChanging" OnItemDataBound="ListView1_ItemDataBound">
                            <ItemTemplate>
                                <%--                            <div class="row" style="border:solid 2px">
                                <div class="col-12">
                                    <asp:Label ID="lblNombre" CssClass="h2" runat="server" Text='<%# Eval("cod_transaccion") %>'></asp:Label>
                                    <br />
                                    <asp:Label ID="lblFecha" CssClass="h2" runat="server" Text='<%# Eval("Date") %>'></asp:Label>--%>
                                <%--<asp:Image CssClass="img-fluid" ImageUrl='<%# "http://192.168.200.223/basculas/upload/" + DataBinder.Eval(Container.DataItem,"nombre")%>' runat="server" ID="image1" />--%>
                                <%--                                    <asp:Image CssClass="img-fluid" ImageUrl='<%# "~/upload/" + DataBinder.Eval(Container.DataItem,"nombre")%>' runat="server" ID="imagen" />
                                </div>
                            </div>--%>
                                <div class="col-lg-6 col-md-6 col-sm-12 ml-5 mb-4  Content12" style="border: solid 0px">

                                    <div class="row">
                                        <div class="col-4">
                                            <asp:HyperLink data-fancybox="gallery" ID="HyperLink5" data-caption='<%# Eval("cod_transaccion") %>' NavigateUrl='<%# "~/upload/" + DataBinder.Eval(Container.DataItem,"imagen")%>' runat="server">
                                                <asp:Image class="img-fluid rounded mt-4 mb-3 mb-md-0" Width="100%" ID="Image5" runat="server" ImageUrl='<%# "~/upload/" + DataBinder.Eval(Container.DataItem,"imagen")%>' />
                                            </asp:HyperLink>
                                        </div>
                                        <div class="col-8">

                                            <%--<asp:Label ID="lblEstado" runat="server" Text='' />--%>
                                            <br />
                                            <h5>

                                                <asp:Label ID="lbl_cod_estado" Visible="false" runat="server" Text='<%# Eval("cod_estado") %>'></asp:Label>
                                                <asp:Label ID="lblAlerta" runat="server" ForeColor='<%# System.Drawing.ColorTranslator.FromHtml(Eval("color").ToString()) %>' CssClass="alerta"><i class="fa fa-circle"></i></asp:Label>&nbsp;<asp:Label ID="Label1" CssClass="h5" runat="server" Text='<%# Eval("estado") %>'></asp:Label></h5>

                                            <h5>Código:
                                                <asp:Label ID="lblCodigo" runat="server" Text='<%# Eval("PK_PreTransaccion") %>'></asp:Label>

                                            </h5>

                                            <h5>Transacción:
                                                <asp:Label ID="lblNombre" CssClass="h5" runat="server" Text='<%# Eval("cod_transaccion") %>'></asp:Label></h5>

                                            <h5>Tarjeta
                                                <asp:Label ID="lblTarjeta" runat="server" Text='<%# Eval("tarjetano") %>'></asp:Label>
                                            </h5>
                                            <p class="h5">
                                                Fecha:
                                                <asp:Label ID="lblFecha" runat="server" Text='<%# Eval("fecha_creacion") %>'></asp:Label>
                                            </p>
                                            <br />

                                            <%--<div class="col-12" style="border: solid 0px">
                                                <i class="fas fa-arrow-alt-circle-right fa-2x"></i><i class="fas fa-arrow-alt-circle-right fa-2x"></i><i class="fas fa-arrow-alt-circle-right fa-2x"></i><i class="fas fa-arrow-alt-circle-right fa-2x"></i><i class="fas fa-arrow-alt-circle-right fa-2x"></i>
                                            </div>--%>
                                            <asp:LinkButton ID="lnk_autorizar" CssClass="btn btn-danger mb-3" OnClick="lnk_autorizar_Click" CommandArgument='<%# Eval("PK_PreTransaccion")%>' runat="server"> <i class="fas fa-clipboard-check"></i>&nbsp;Autorizar</asp:LinkButton>
                                            <asp:LinkButton ID="lnk_autorizar2" CssClass="btn btn-warning mb-3" OnClick="lnk_autorizar2_Click" CommandArgument='<%# Eval("PK_PreTransaccion")+ ";" + Eval("cod_transaccion")%>' runat="server"> <i class="fas fa-clipboard-check"></i>&nbsp;Autorizar 2</asp:LinkButton>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-primary mb-3"><i class="fas fa-road"></i>Ruta</asp:LinkButton>



                                            <%--<asp:LinkButton ID="LinkButton2" CssClass="btn btn-secondary" runat="server" OnClick="LinkButton2_Click" CommandArgument='<%# Eval("codigo")%>'>LinkButton</asp:LinkButton>--%>
                                            <%--                                            <button type="button" class="btn btn-primary" style="border-radius: 10px" data-toggle="modal" data-target="#exampleModal" onclick="asignaUser(document.getElementById('ListView1_cod_transaccion_1').value)">
                                                <i class="fas fa-clipboard-check"></i>&nbsp;Autorizar
                                            </button>--%>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:ListView>
                    </div>

                    <div class="row" style="border: solid 0px; position: fixed; bottom: 0; left: 0; right: 0;">
                        <div class="col-lg-12 h3" style="text-align: center">
                            <asp:DataPager runat="server" ID="dtpPrincipal" PagedControlID="ListView1" PageSize="6">
                                <Fields>

                                    <asp:NextPreviousPagerField ShowFirstPageButton="True" ShowNextPageButton="false" ShowPreviousPageButton="true" NextPageText="&lt;i class='fas fa-angle-right'&gt;&lt;/i&gt;" PreviousPageText="&lt;i class='fas fa-angle-left'&gt;&lt;/i&gt;" FirstPageText="&lt;i class='fas fa-angle-double-left'&gt;&lt;/i&gt;" LastPageText="&lt;i class='fas fa-angle-double-right'&gt;&lt;/i&gt;" />
                                    <asp:NumericPagerField />
                                    <asp:NextPreviousPagerField ShowLastPageButton="True" ShowNextPageButton="true" ShowPreviousPageButton="false" FirstPageText="&lt;i class='fas fa-angle-double-left'&gt;&lt;/i&gt;" LastPageText="&lt;i class='fas fa-angle-double-right'&gt;&lt;/i&gt;" NextPageText="&lt;i class='fas fa-angle-right'&gt;&lt;/i&gt;" PreviousPageText="&lt;i class='fas fa-angle-left'&gt;&lt;/i&gt;" />
                                    <%--                            <asp:NextPreviousPagerField ShowNextPageButton="False" ButtonCssClass="previousNextLink" PreviousPageText="&amp;nbsp;&lt;span class=&quot;icon icon-keyboard_arrow_left&quot;&gt;&lt;/span&gt;" />
                            <asp:NumericPagerField ButtonCount="10" ButtonType="Link" NumericButtonCssClass="numericLink" CurrentPageLabelCssClass="active-pager" />
                            <asp:NextPreviousPagerField ShowPreviousPageButton="False" ButtonCssClass="previousNextLink" NextPageText="&amp;nbsp;&lt;span class=&quot;icon icon-keyboard_arrow_right&quot;&gt;&lt;/span&gt;" />--%>
                                </Fields>
                            </asp:DataPager>
                        </div>
                    </div>

                    <!-- Modal -->
                    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">Autorización de Pre-Transacción</h5>
                                    <button type="button" id="btn_close" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form id="miForm">

                                        <div class="form-group row">
                                            <label for="inputUsername" class="col-sm-2 col-form-label">Username</label>
                                            <div class="col-sm-10">
                                                <input type="text" disabled="disabled" class="form-control" id="inputUsername" placeholder="Username" required="" oninvalid="this.setCustomValidity('Ingrese su usuario')" oninput="setCustomValidity('')">
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label for="inputBascula" class="col-sm-2 col-form-label">Báscula</label>
                                            <div class="col-sm-10">
                                                <select class="form-control" id="select_bascula" required="" oninvalid="this.setCustomValidity('Seleccione el número de báscula')" oninput="setCustomValidity('')">
                                                    <option value="">--Seleccione--</option>
                                                    <option value="1">1</option>
                                                    <option value="2">2</option>
                                                    <option value="3">3</option>
                                                    <option value="4">4</option>
                                                </select>
                                            </div>
                                        </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" style="border-radius: 10px" data-dismiss="modal">Cancelar</button>
                                    <%--                                    <button>Enviar</button>--%>
                                    <%--<button type="submit" id="autoriza" runat="server" class="btn btn-primary" style="border-radius: 10px" onclick="return valida()">Autorizar</button>--%>
                                    <%--                                    <asp:LinkButton ID="LinkButton2" CssClass="btn btn-secondary" runat="server" OnClick="LinkButton2_Click" CommandArgument='<%# Eval("codigo")%>'>LinkButton</asp:LinkButton>--%>
                                </div>
                                </form>
                            </div>
                        </div>
                    </div>

                </ContentTemplate>
            </asp:UpdatePanel>

        </div>
    </form>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript" src="../scripts/jquery.blockUI.js"></script>
    <script type="text/javascript">
        $(function () {
            BlockUI("conten");
            $.blockUI.defaults.css = {};
        });
        function BlockUI(elementID) {
            var prm = Sys.WebForms.PageRequestManager.getInstance();
            prm.add_beginRequest(function () {
                $("#" + elementID).block({
                    message: '<div align = "center">' + '<img src="../images/009.gif"/></div>',
                    css: {},
                    overlayCSS: { backgroundColor: '#F8F9F9', opacity: 0.8, border: '0px solid #63B2EB' }
                });
            });
            prm.add_endRequest(function () {
                $("#" + elementID).unblock();
            });
        };
    </script>

);
    </script>


</body>
</html>
