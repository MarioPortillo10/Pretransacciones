<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Basculas_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Lista Negra</title>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.2/css/all.css" integrity="sha384-/rXc/GQVaYpyDdyxK+ecHPVYJSN9bmVFBvjA/9eOB+pb3F2w2N6fc5qB9Ew5yIns" crossorigin="anonymous" />

    <script src="../src/js/jquery-3.4.1.min.js"> </script>
    <%--    <script src="../src/js/spotlight.min.js"></script>--%>
    <script src="../src/js/spotlight.bundle.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

    <script>
        var rotation = 0;

        jQuery.fn.rotate = function (degrees) 
        {
            $(this).css({
                '-webkit-transform': 'rotate(' + degrees + 'deg)',
                '-moz-transform': 'rotate(' + degrees + 'deg)',
                '-ms-transform': 'rotate(' + degrees + 'deg)',
                'transform': 'rotate(' + degrees + 'deg)'
            });
        };

        $('#spotlight').click(function () 
        {
            alert("Demo Rotation");
            //rotation += 45;
            //$('.rotate').rotate(rotation);
        });

        function openModal(cod_actividad, ntarjeta, cod_preTrans) 
        {
            //alert(codigo);
            // jQuery.noConflict();
            //$('#actividadModal').modal('show');
            //var slt = document.getElementById('ddlActividadEdt'); txt_codigoPreTransaccion
            document.getElementById("ddlActividadEdt").selectedIndex = cod_actividad;
            document.getElementById("txt_tarjetaEdit").value = ntarjeta;
            document.getElementById("txt_codigoPreTransaccion").value = cod_preTrans;
        }

        //Confirma si el cliente quiere eliminar el item.  getConfirmationDetele
        function getConfirmation() 
        {
            var retVal = confirm("¿Desea autorizar este ingreso?");
            if (retVal == true) 
            {
                //alert("User wants to continue!");
                return true;
            } 
            else 
            {
                //alert("User does not want to continue!");
                return false;
            }
        }

        function getConfirmationDetele() 
        {
            //Swal.fire({
            //    title: '¿Estás seguro?',
            //    text: "¡Este cambio no podrá ser revertido!",
            //    icon: 'warning',
            //    showCancelButton: true,
            //    confirmButtonColor: '#3085d6',
            //    cancelButtonColor: '#d33',
            //    confirmButtonText: 'Sí, bórralo!'
            //}).then((result) => {
            //    if (result.value) {
            //        Swal.fire(
            //            'Eliminado!',
            //            'El registro ha sido eliminado.',
            //            'success'
            //        )
            //    }
            //})

            var retVal = confirm("¿Desea Actualizar este registro?\n Este cambio no podra ser revertido");
            if (retVal == true) 
            {
                //alert("User wants to continue!");
                return true;
            } 
            else 
            {
                //alert("User does not want to continue!");
                return false;
            }
        }

        //Confirma si el cliente quiere eliminar el item.  getConfirmationDetele
        function getConfirmation_update() 
        {
            var retVal = confirm("¿Desea actualizar este registro?");
            if (retVal == true) 
            {
                //alert("User wants to continue!");
                return true;
            } 
            else 
            {
                //alert("User does not want to continue!");
                return false;
            }
        }
    </script>


    <style>
        .Content12 
        {
            -webkit-border-radius: 10px 10px 10px 10px;
            border-radius: 10px 10px 10px 10px;
            background: #fff;
            /*padding: 30px;*/
            width: 100%;
            /*max-width: 450px;*/
            position: relative;
            /*padding: 0px;*/
            -webkit-box-shadow: 0 30px 60px 0 rgba(0,0,0,0.3);
            box-shadow: 0 30px 60px 0 rgba(0,0,0,0.3);
            /*text-align: center;*/
        }
    </style>
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
                    <li class="nav-item">
                        <a class="nav-link bg-primary text-white" href="Default.aspx"><span id="nft_1" class="badge badge-danger" style="position: absolute; top: -5px; left: 12px;"></span><i class="far fa-file-alt"></i>&nbsp;Pre-Transacciones</a>
                    </li>

                    <li class="nav-item">
                        <%--<a class="nav-link disabled" href="Rutas_Transacciones.aspx">Rutas Transacciones</a>--%>
                        <a class="nav-link" href="Rutas_Transacciones.aspx"><i class="fas fa-road"></i>&nbsp;Rutas Transacciones</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="Rutas_Actividades.aspx"><i class="fas fa-road"></i>&nbsp;Rutas Actividades</a>
                    </li>

                    <li class="nav-item active" style="position: relative">
                        <a class="nav-link" href="Lista_Negra.aspx"><i class="fas fa-list-alt"></i>&nbsp;Lista Negra Motorista</a>
                    </li>

                <li class="nav-item">
                        <a class="nav-link" href="Prechequeo.aspx"><i class="fas fa-qrcode"></i>&nbsp;Prechequeo</a>
                    </li>
                </ul>

                <div class="my-2 my-lg-0">
                    <asp:LinkButton ID="lnk_perfil" OnClick="lnk_perfil_Click" CssClass="btn btn-outline-success my-2 my-sm-0" runat="server"> Perfil</asp:LinkButton>
                    <asp:LinkButton ID="lnk_salir"  OnClick="LinkSalir1_Click" CssClass="btn btn-outline-info my-2 my-sm-0" runat="server"><i class="fas fa-power-off">&nbsp Salir </i>&nbsp<i class="far fa-user"></i></asp:LinkButton>
                </div>
            </div>
        </nav>

        <div class="container-fluid" id="conten">
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnStr_LEVERANS_prod %>"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sql_estados" ConnectionString="<%$ ConnectionStrings:ConnStr_LEVERANS_prod %>" runat="server" SelectCommand="SELECT * FROM [LEVERANS_PreTransaccionesEstados] ORDER BY Pk_PreTransEstados ASC"></asp:SqlDataSource>
            <asp:SqlDataSource ID="Sql_basculas" ConnectionString="<%$ ConnectionStrings:ConnStr_LEVERANS_prod %>" runat="server" SelectCommand="SELECT * FROM [LEVERANS_Basculas] where N_Bascula <= 6 ORDER BY [N_Bascula] ASC"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sql_actividades" ConnectionString="<%$ ConnectionStrings:ConnStr_LEVERANS_prod %>" runat="server" SelectCommand="SELECT PkActividad,Descripcion  FROM [dbo].[LEVERANS_Actividades] ORDER BY PkActividad"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sql_documetos" runat="server" ConnectionString="<%$ ConnectionStrings:ConnStr_LEVERANS_prod %>"></asp:SqlDataSource>
            <asp:SqlDataSource ID="sql_usuarios" SelectCommand="SELECT PK_Usuario,Usuario FROM [dbo].[LEVERANS_UsuariosBascula]" runat="server" ConnectionString="<%$ ConnectionStrings:ConnStr_LEVERANS_prod %>"></asp:SqlDataSource>

            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="row ml-4">
                        <h3>Prechequeo  </h3>
                        <p class="h3 ml-3" id="demo"></p>
                       <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal"> Crear</button>

                        <!-- Modal -->
                        <div class="modal fade" id="myModal" role="dialog">
                            <div class="modal-dialog">
                                <!-- Modal content-->
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                        <h4 class="modal-title">Modal Header</h4>
                                    </div>

                                    <div class="modal-body">
                                        <p>Some text in the modal.</p>
                                    </div>
                                    
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row ml-3 sticky-top" style="border: solid 0px;">
                        <div class="col-9 mt-2 mb-2">
                            <div class="input-group mb-3" style="border: solid 0px;">
                                <div class="input-group-prepend">
                                    <span class="input-group-text secondary"># de Licencia</span>
                                </div>

                                <asp:TextBox ID="txtTransaccion" autocomplete="off" CssClass="form-control" runat="server"></asp:TextBox>
                                <asp:DropDownList ID="ddl_Estado" CssClass="form-control" runat="server" DataSourceID="sql_estados" DataValueField="Pk_PreTransEstados" DataTextField="Descripcion" AppendDataBoundItems="true" Visible="false">
                                    <asp:ListItem Value="0">Todos</asp:ListItem>
                                </asp:DropDownList>

                                <asp:DropDownList ID="ddl_Actividades2" CssClass="form-control" DataSourceID="sql_actividades" DataTextField="Descripcion" DataValueField="PkActividad" runat="server" AppendDataBoundItems="true" Visible="false">
                                    <asp:ListItem Value="0">Seleccione una Actividad</asp:ListItem>
                                </asp:DropDownList>

                                <asp:DropDownList ID="ddl_basculas" CssClass="form-control" runat="server" DataSourceID="Sql_basculas" DataValueField="N_Bascula" DataTextField="Descripcion" AppendDataBoundItems="true" Visible="false">
                                    <asp:ListItem Value="0">Selecciones Báscula</asp:ListItem>
                                </asp:DropDownList>

                                <div class="input-group-append">
                                    <asp:LinkButton ID="lnkBuscar" CssClass="btn btn-primary" OnClick="lnkBuscar_Click" OnClientClick="return ShowCurrentTime()" runat="server">
                                        <i class="fas fa-search"></i> Buscar
                                    </asp:LinkButton>
                                    
                                    <asp:LinkButton ID="LnkRefresh" Visible="false" CssClass="btn btn-secondary" runat="server">
                                        <i class="fas fa-sync"></i>
                                    </asp:LinkButton>
                                    
                                    <asp:LinkButton ID="Lnk_newTransaccon" Visible="false" CssClass="btn btn-success" runat="server" data-toggle="modal" data-target="#nuevaPretransaccionModal">
                                        <i class="fas fa-file-alt"> Nueva</i>
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>

                    <script type="text/javascript">
                        $(document).on("click", '.ocultar', function () 
                        {
                            console.log("world");
                            $(this).hide();
                        });
                    </script>

                    <div class="row" style="border: solid 0px">
                        <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource1" OnPagePropertiesChanging="lvwPrincipal_PagePropertiesChanging" OnItemDataBound="ListView1_ItemDataBound">
                            <ItemTemplate>
                                <div class="col-lg-4 col-md-6 col-sm-12 " style="border: solid 0px">
                                    <div class="mb-4 Content12" style="border: solid 0px">
                                        <asp:Label ID="lblCodT" Visible="false" runat="server" Text='<%# Eval("PK_PreTransaccion") %>'></asp:Label>
                                        <div class="row">
                                            <div class="col-4">
                                                <div class="row ml-3 mt-3">
                                                    <asp:Repeater ID="rpt_galeria" runat="server">
                                                        <ItemTemplate>
                                                            <div class="col-6" style="border: solid 0px">
                                                                <asp:HyperLink ID="HyperLink5" CssClass="spotlight" data-title='<%# "codTransaccion :" +DataBinder.Eval(Container.DataItem,"codTransaccion")%>' NavigateUrl='<%# "http://sv-svr-almapp02:2050/" + DataBinder.Eval(Container.DataItem,"Documento")%>' runat="server">
                                                                    <asp:Image class="img-fluid rounded mt-4 mb-3 mb-md-0" Width="100%" ID="Image1" runat="server" ImageUrl='<%# "http://sv-svr-almapp02:2050/" + DataBinder.Eval(Container.DataItem,"Documento_thumbnail")%>' />
                                                                </asp:HyperLink>
                                                                <asp:LinkButton ID="lnk_rotar" OnClick="lnk_rotar_Click" CommandArgument='<%# Eval("Documento")+ ";" + Eval("Documento_thumbnail")%>' runat="server"><i class="fas fa-sync-alt"></i></asp:LinkButton>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:Repeater>
                                                </div>
                                            </div>

                                            <div class="col-8">
                                                <br/>
                                                <h5>
                                                    <asp:Label ID="lbl_cod_estado" Visible="false" runat="server" Text='<%# Eval("cod_estado") %>'></asp:Label>
                                                    <asp:Label ID="lblAlerta" runat="server" ForeColor='<%# System.Drawing.ColorTranslator.FromHtml(Eval("Color").ToString()) %>' CssClass="alerta"><i class="fa fa-circle"></i></asp:Label>&nbsp;<asp:Label ID="Label1" ForeColor="Blue" CssClass="h5" runat="server" Text='<%# Eval("estado") %>'></asp:Label></h5>
                                                <h5>Código:
                                                    <asp:Label ID="lblCodigo" runat="server" Text='<%# Eval("PK_PreTransaccion") %>'></asp:Label>
                                                </h5>

                                                <h5>Transacción:                                                
                                                    <asp:Label ID="lblNombre" CssClass="h5" runat="server" Text='<%# Eval("codTransaccion") %>'></asp:Label>
                                                </h5>
    
                                                <h5>Tarjeta:
                                                    <asp:Label ID="lblTarjeta" runat="server" Text='<%# Eval("ntarjeta") %>'></asp:Label>
                                                </h5>
    
                                                <h5>Placa:
                                                    <asp:Label ID="lblPlaca" runat="server" Text='<%# Eval("placa") %>'></asp:Label>
                                                </h5>
    
                                                <h5>Actividad:
                                                    <asp:Label ID="lblActividad" CssClass="h6" runat="server" Text='<%# Eval("desc_actividad") %>'></asp:Label>
                                                </h5>
    
                                                <p class="h5">N° Báscula:
                                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("nbascula") %>'></asp:Label>
                                                </p>
    
                                                <p class="h5">Fecha Creación:
                                                    <asp:Label ID="lblFecha" runat="server" Text='<%# Eval("FechaHora") %>'></asp:Label>
                                                </p>
    
                                                <p class="h5">Fecha Autorizado:
                                                    <asp:Label ID="lblFechaAutorizado" runat="server" Text='<%# Eval("fechaautorizado") %>' ></asp:Label>
                                                </p>
                                                <br />

                                                <asp:LinkButton ID="lnk_autorizar" CssClass="btn btn-danger mb-3" OnClientClick="return getConfirmation();" OnClick="lnk_autorizar_Click" CommandArgument='<%# Eval("PK_PreTransaccion")+ ";" + Eval("codTransaccion")%>' runat="server"> <i class="fas fa-clipboard-check"></i>&nbsp;Autorizar</asp:LinkButton>
                                                <asp:LinkButton ID="lnk_autorizar2" CssClass="btn btn-warning mb-3" OnClientClick="return getConfirmation();" OnClick="lnk_autorizar2_Click" CommandArgument='<%# Eval("PK_PreTransaccion")+ ";" + Eval("codTransaccion")%>' runat="server"> <i class="fas fa-clipboard-check"></i>&nbsp;Autorizar 2</asp:LinkButton>
                                                <asp:LinkButton ID="lnk_crearTransaccion" Visible="false" OnClick="lnk_crearTransaccion_Click" CommandArgument='<%# Eval("PK_PreTransaccion")%>' runat="server" CssClass="btn ocultar btn-primary mb-3">Crear</asp:LinkButton>
                                                <asp:LinkButton ID="lnk_delete" Visible="false" runat="server" CssClass="btn btn-danger mb-3" OnClientClick="return getConfirmationDetele();" OnClick="lnk_delete_Click" CommandArgument='<%# Eval("PK_PreTransaccion")%>'><i class="fas fa-trash-alt"></i>&nbsp;Finalizar</asp:LinkButton>
                                                <asp:LinkButton ID="lnk_update_pret" Visible="false" runat="server" CssClass="btn btn-info mb-3" OnClientClick="return getConfirmation_update();" OnClick="lnk_update_pret_Click" CommandArgument='<%# Eval("PK_PreTransaccion")%>' ><i class="fas fa-angle-double-right"></i>&nbsp;Omitir</asp:LinkButton>
       
                                                <button type="button" class="btn btn-primary mb-3" id="btn_edi" name="btn_edit" runat="server" visible="false" onclick='<%# "openModal(" +Eval("cod_actividad")+","+Eval("ntarjeta")+","+Eval("PK_PreTransaccion") + " );" %>' data-toggle="modal" data-target="#modal_editActividad"><i class="fas fa-road"></i>Editar2</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:ListView>
                    </div>

                    <div class="row" style="border: solid 0px; position: fixed; bottom: 0; left: 0; right: 0;">
                        <div class="col-lg-12 h3" style="text-align: center">
                            <asp:DataPager runat="server" ID="dtpPrincipal" PagedControlID="ListView1" PageSize="12">
                                <Fields>
                                    <asp:NextPreviousPagerField ShowFirstPageButton="True" ShowNextPageButton="false" ShowPreviousPageButton="true" NextPageText="&lt;i class='fas fa-angle-right'&gt;&lt;/i&gt;" PreviousPageText="&lt;i class='fas fa-angle-left'&gt;&lt;/i&gt;" FirstPageText="&lt;i class='fas fa-angle-double-left'&gt;&lt;/i&gt;" LastPageText="&lt;i class='fas fa-angle-double-right'&gt;&lt;/i&gt;" />
                                    <asp:NumericPagerField />
                                    <asp:NextPreviousPagerField ShowLastPageButton="True" ShowNextPageButton="true" ShowPreviousPageButton="false" FirstPageText="&lt;i class='fas fa-angle-double-left'&gt;&lt;/i&gt;" LastPageText="&lt;i class='fas fa-angle-double-right'&gt;&lt;/i&gt;" NextPageText="&lt;i class='fas fa-angle-right'&gt;&lt;/i&gt;" PreviousPageText="&lt;i class='fas fa-angle-left'&gt;&lt;/i&gt;" />
                                </Fields>
                            </asp:DataPager>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>

            <!-- Modal para crear una nueva Pretransaccion -->
            <div class="modal fade" id="nuevaPretransaccionModal" tabindex="-1" role="dialog" aria-labelledby="nuevaPretransaccionTitle" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="nuevaPretransaccionLongTitle">Create</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group col-12">
                                <asp:TextBox ID="txtTarjeta" CssClass="form-control" TextMode="Number" placeholder="N° Tarjeta" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="req_txtTarjeta" runat="server" ControlToValidate="txtTarjeta" CssClass="reqGeneral" ErrorMessage="*" Display="Dynamic" ValidationGroup="save" InitialValue=""><i class="fa fa-times-circle" aria-hidden="true"></i></asp:RequiredFieldValidator>
                            </div>

                            <div class="form-group col-12">
                                <asp:DropDownList ID="ddl_actividades" CssClass="form-control" DataSourceID="sql_actividades" DataTextField="Descripcion" DataValueField="PkActividad" runat="server" AppendDataBoundItems="true">
                                    <asp:ListItem Value="0"> seleccione una actividad</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="reqddl_actividades" runat="server" ControlToValidate="ddl_actividades" CssClass="reqGeneral" ErrorMessage="*" Display="Dynamic" ValidationGroup="save" InitialValue="0"><i class="fa fa-times-circle" aria-hidden="true"></i></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <asp:LinkButton ID="btn_save" runat="server" OnClick="btn_save_Click" CausesValidation="True" CssClass="btn btn-primary" ValidationGroup="save"><i class="fa fa-floppy-o"></i> Crear </asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal -->
            <div class="modal fade" id="modal_editActividad" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Modal Edit</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div class="form-group col-12">

                                <input type="text" id="txt_codigoPreTransaccion" style="display: none" runat="server" />
                                <label for="exampleInputEmail1">N° Tarjeta</label>
                                <asp:TextBox ID="txt_tarjetaEdit" CssClass="form-control" TextMode="Number" placeholder="N° Tarjeta" runat="server" autocomplete="off"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txt_tarjetaEdit" CssClass="reqGeneral" ErrorMessage="*" Display="Dynamic" ValidationGroup="edit2" InitialValue=""><i class="fa fa-times-circle" aria-hidden="true"></i></asp:RequiredFieldValidator>
                            </div>


                            <div class="form-group col-12">
                                <label for="exampleInputEmail1">Actividad</label>
                                <asp:DropDownList ID="ddlActividadEdt" CssClass="form-control" DataSourceID="sql_actividades" DataTextField="Descripcion" DataValueField="PkActividad" runat="server" AppendDataBoundItems="true">
                                    <asp:ListItem Value="0"> seleccione una actividad</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddlActividadEdt" CssClass="reqGeneral" ErrorMessage="*" Display="Dynamic" ValidationGroup="edit2" InitialValue="0"><i class="fa fa-times-circle" aria-hidden="true"></i></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                            <asp:LinkButton ID="lnk_editPreTransaccion" OnClick="lnk_editPreTransaccion_Click" runat="server" CausesValidation="True" CssClass="btn btn-primary" ValidationGroup="edit2"><i class="fa fa-floppy-o"></i> Guardar </asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>


            <!-- Modal RESTABLECER CONTRASEÑA -->
            <div class="modal fade" id="editPass" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editPass2">Cambiar contraseña</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group col-12">
                                <asp:TextBox ID="txtUsuario" Enabled="false" Text="Usuario1" CssClass="form-control" runat="server"></asp:TextBox>
                            </div>

                            <div class="form-group col-12">
                                <asp:TextBox ID="txtPass" TextMode="Password" CssClass="form-control" placeholder="Contraseña" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="ReqtxtPass" runat="server" ControlToValidate="txtPass" CssClass="reqGeneral" ErrorMessage="*" Display="Dynamic" ValidationGroup="reset" InitialValue=""><i class="fa fa-times-circle" aria-hidden="true"></i></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                            <asp:LinkButton ID="lnk_restablecer" runat="server" OnClick="lnk_restablecer_Click" CausesValidation="True" CssClass="btn btn-primary" ValidationGroup="reset"><i class="fa fa-floppy-o"></i> Guardar </asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>





        </div>
    </form>


    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
        <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">New message</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <div class="modal-body">
            <form>
            <div class="form-group">
                <label for="recipient-name" class="col-form-label">Recipient:</label>
                <input type="text" class="form-control" id="recipient-name">
            </div>
            <div class="form-group">
                <label for="message-text" class="col-form-label">Message:</label>
                <textarea class="form-control" id="message-text"></textarea>
            </div>
            </form>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            <button type="button" class="btn btn-primary">Send message</button>
        </div>
        </div>
    </div>
    </div>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript" src="../scripts/jquery.blockUI.js"></script>
    <script type="text/javascript">
        $('#exampleModal').on('show.bs.modal', function (event) 
        {
            var button = $(event.relatedTarget) // Button that triggered the modal
            var recipient = button.data('whatever') // Extract info from data-* attributes
            // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
            // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
            var modal = $(this)
            modal.find('.modal-title').text('New message to ' + recipient)
            modal.find('.modal-body input').val(recipient)
        })
       
        $(function () 
        {
            BlockUI("conten");
            $.blockUI.defaults.css = {};
        });
        
        function BlockUI(elementID) 
        {
            var prm = Sys.WebForms.PageRequestManager.getInstance();
            prm.add_beginRequest(function () 
            {
                $("#" + elementID).block({
                    message: '<div align = "center">' + '<img src="../images/009.gif"/></div>',
                    css: {},
                    overlayCSS: { backgroundColor: '#F8F9F9', opacity: 0.8, border: '0px solid #63B2EB' }
                });
            });
            prm.add_endRequest(function () 
            {
                $("#" + elementID).unblock();
            });
        };
    </script>
    <script src="https://cdn.jsdelivr.net/picturefill/2.3.1/picturefill.min.js"></script>
    <script src="https://cdn.rawgit.com/sachinchoolur/lightgallery.js/master/dist/js/lightgallery.js"></script>
    <script src="https://cdn.rawgit.com/sachinchoolur/lg-pager.js/master/dist/lg-pager.js"></script>
    <script src="https://cdn.rawgit.com/sachinchoolur/lg-autoplay.js/master/dist/lg-autoplay.js"></script>
    <script src="https://cdn.rawgit.com/sachinchoolur/lg-fullscreen.js/master/dist/lg-fullscreen.js"></script>
    <script src="https://cdn.rawgit.com/sachinchoolur/lg-zoom.js/master/dist/lg-zoom.js"></script>
    <script src="https://cdn.rawgit.com/sachinchoolur/lg-hash.js/master/dist/lg-hash.js"></script>
    <script src="https://cdn.rawgit.com/sachinchoolur/lg-share.js/master/dist/lg-share.js"></script>
    <script>
        lightGallery(document.getElementById('lightgallery'));
    </script>
</body>
</html>
