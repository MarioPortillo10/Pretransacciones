<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Rutas_Transacciones.aspx.cs" Inherits="Basculas_Rutas_Transacciones" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.2/css/all.css" integrity="sha384-/rXc/GQVaYpyDdyxK+ecHPVYJSN9bmVFBvjA/9eOB+pb3F2w2N6fc5qB9Ew5yIns" crossorigin="anonymous" />
    <script src="../src/js/jquery-3.4.1.min.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>


    <script type="text/javascript">
        $(document).ready(function () {
            $('body').on('click', '[src*=plus1]', function () {
                $(this).closest("tr").after("<tr><td></td><td colspan = '999'>" + $(this).next().html() + "</td></tr>")
                $(this).attr("src", "../images/minus2.png");;
            });

            $('body').on('click', '[src*=minus2]', function () {
                $(this).attr("src", "../images/plus1.png");
                $(this).closest("tr").next().remove();
            });

        });


        //Confirma si el cliente quiere eliminar el item.
        function getConfirmation() {
            var retVal = confirm("¿Desea eliminar esta fila?");
            if (retVal == true) {
                //alert("User wants to continue!");
                return true;
            } else {
                //alert("User does not want to continue!");
                return false;
            }
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">

        <asp:SqlDataSource ID="sql_transaciones_rutas" runat="server" ConnectionString="<%$ ConnectionStrings:ConnStr_LEVERANS_prod %>"></asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlPrincipal" runat="server" ConnectionString="<%$ ConnectionStrings:ConnStr_LEVERANS_prod %>"></asp:SqlDataSource>

        <asp:SqlDataSource ID="SqlSubPrincipal" runat="server" ConnectionString="<%$ ConnectionStrings:ConnStr_LEVERANS_prod %>"
            InsertCommand="INSERT INTO [LEVERANS_RutasDetalles] ([FK_Transaccion],[FK_Acceso],[FK_Actividad],[Estado],[Correlativo])VALUES(@FK_Transaccion,@FK_Acceso,@FK_Actividad,1,@Correlativo)"
            DeleteCommand="DELETE FROM [LEVERANS].[dbo].[LEVERANS_RutasDetalles] WHERE PK_RutaDetalle = @PK_RutaDetalle"
            UpdateCommand="UPDATE [LEVERANS].[dbo].[LEVERANS_RutasDetalles] SET [Correlativo] = @Correlativo,[FK_Acceso]=@FK_Acceso,[Estado] = @Estado  WHERE PK_RutaDetalle = @PK_RutaDetalle">
            <InsertParameters>
                <asp:Parameter Name="FK_Transaccion" Type="Int32" />
                <asp:Parameter Name="FK_Acceso" Type="Int32" />
                <asp:Parameter Name="FK_Actividad" Type="Int32" />
                <asp:Parameter Name="Correlativo" Type="Int32" />
            </InsertParameters>

            <DeleteParameters>
                <asp:Parameter Name="PK_RutaDetalle" Type="Int32" />
            </DeleteParameters>

            <UpdateParameters>
                <asp:Parameter Name="PK_RutaDetalle" Type="Int32" />
                <asp:Parameter Name="FK_Acceso" Type="Int32" />
                <asp:Parameter Name="Correlativo" Type="Int32" />
                <asp:Parameter Name="Estado" Type="Boolean" />
            </UpdateParameters>

        </asp:SqlDataSource>



        <asp:SqlDataSource ID="sql_accesos" SelectCommand="SELECT * FROM [dbo].[LEVERANS_Accesos]" runat="server" ConnectionString="<%$ ConnectionStrings:ConnStr_LEVERANS_prod %>"></asp:SqlDataSource>

        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">ALMAPAC</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">

                    <li class="nav-item">
                        <a class="nav-link" href="Default.aspx">Pre-Transacciones</a>
                    </li>

                    <li class="nav-item active">
                        <a class="nav-link bg-primary text-white" href="Rutas_Transacciones.aspx"><i class="fas fa-road"></i>&nbsp;Rutas Transacciones</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="Rutas_Actividades.aspx">Rutas Actividades</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="Lista_Negra.aspx"><i class="fas fa-list-alt"></i>&nbsp;Lista Negra Motorista</a>
                    </li>

                    <li class="nav-item active">
                        <a class="nav-link" href="Prechequeo.aspx"><i class="fas fa-qrcode"></i>&nbsp;Prechequeo</a>
                    </li>
                </ul>

                <div class="my-2 my-lg-0">
                    <asp:LinkButton ID="lnk_salir" CssClass="btn btn-outline-info my-2 my-sm-0" OnClick="lnk_salir_Click" runat="server"><i class="fas fa-power-off">&nbsp Salir </i>&nbsp<i class="far fa-user"></i></asp:LinkButton>

                </div>
            </div>
        </nav>

        <div class="container">
            <h3 style="text-align: center">Rutas de Transacciones</h3>
            <div class="row ml-3 sticky-top">
                <div class="col-12">
                    <div class="input-group mb-3" style="border: solid 0px;">
                        <div class="input-group-prepend">
                            <span class="input-group-text"># de Transacción</span>
                        </div>
                        <asp:TextBox ID="txtTransaccion" CssClass="form-control col-2" runat="server"></asp:TextBox>
                        <div class="input-group-append">
                            <asp:DropDownList ID="ddl_Estado" CssClass="form-control" runat="server" AppendDataBoundItems="true">
                                <asp:ListItem Value="0">--Todos Actividades--</asp:ListItem>
                            </asp:DropDownList>
                            <asp:LinkButton ID="lnkBuscar" CssClass="btn btn-outline-secondary" runat="server"><i class="fas fa-search">Buscar</i></asp:LinkButton>
                            <asp:LinkButton ID="LnkRefresh" CssClass="btn btn-outline-secondary" runat="server"><i class="fas fa-sync"></i></asp:LinkButton>
                            <asp:LinkButton ID="LinkButton2" CssClass="btn btn-outline-secondary" runat="server">Salir</asp:LinkButton>

                        </div>
                    </div>
                </div>
            </div>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

            <asp:GridView ID="gvw_principal" CssClass="table table-hover table-striped" GridLines="None" runat="server" AllowPaging="True" AllowSorting="True" PageSize="10" OnPageIndexChanging="gvw_principal_PageIndexChanging" AutoGenerateColumns="false" DataKeyNames="codTransaccion">
                <PagerSettings Mode="NextPreviousFirstLast" PageButtonCount="4" FirstPageText="<i class='fas fa-angle-double-left'></i>" LastPageText="<i class='fas fa-angle-double-right'></i>" NextPageText="<i class='fas fa-angle-right'></i>" PreviousPageText="<i class='fas fa-angle-left'></i>" />
                <Columns>
                    <asp:TemplateField HeaderText="Codigo">
                        <ItemTemplate>
                            <div>
                                <asp:Label ID="lblCode" runat="server" Text='<%# Eval("PK_PreTransaccion") %>'></asp:Label>

                            </div>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                        <HeaderStyle />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="CodTransacción">
                        <ItemTemplate>
                            <div>
                                <asp:Label ID="lblCode" runat="server" Text='<%# Eval("codTransaccion") %>'></asp:Label>

                            </div>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                        <HeaderStyle />
                    </asp:TemplateField>



                    <asp:TemplateField HeaderText="Descripción">
                        <ItemTemplate>
                            <div>
                                <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("desc_actividad") %>'></asp:Label>
                            </div>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                        <HeaderStyle />
                    </asp:TemplateField>

                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="lnk_verRuta" OnClick="lnk_verRuta_Click" CommandArgument='<%# Eval("cod_actividad")%>' runat="server" CssClass="btn btn-primary">Ver Ruta</asp:LinkButton>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                        <HeaderStyle />
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>



            <!-- Modal -->
            <div class="modal fade bd-example-modal-lg" id="modal-detalle" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Detalle ruta de Transacción</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                              
                                    <asp:GridView ID="gvw_subprincipal" runat="server" DataSourceID="SqlSubPrincipal" AutoGenerateColumns="false" CssClass="table table-hover" BorderColor="White" ShowFooter="true" DataKeyNames="PK_RutaDetalle" OnRowDeleting="gvw_subprincipal_RowDeleting" OnRowUpdating="gvw_subprincipal_RowUpdating">
                                        <EmptyDataTemplate>
                                            <tr>
                                                <th>Correlativo</th>
                                                <th>Aceeso</th>
                                                <th>Estado</th>

                                                <th></th>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:TextBox ID="txt_correlativo" CssClass="form-control" TextMode="Number" runat="server"></asp:TextBox>

                                                </td>
                                                <td>
                                                    <asp:DropDownList runat="server" ID="ddlAccesos" type="text" CssClass="form-control" DataSourceID="sql_accesos" DataValueField="Pk_Acceso" DataTextField="Descripcion" AppendDataBoundItems="true">
                                                        <asp:ListItem Value="0">Todos...</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td></td>

                                                <td>
                                                    <div style="text-align: center">
                                                        <asp:LinkButton ID="btn_agregar" OnClick="btn_agregar_Click" runat="server" CssClass="btn btn btn-info"><i class="fa fa-plus-circle"></i></asp:LinkButton>
                                                    </div>
                                                </td>
                                            </tr>
                                        </EmptyDataTemplate>

                                        <Columns>
                                            <asp:TemplateField HeaderText="Correlativo" ItemStyle-Width="20px">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txt_correlativo" CssClass="form-control" Text='<%# Eval("Correlativo") %>' TextMode="Number" runat="server"></asp:TextBox></td>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txt_correlativo" CssClass="form-control" TextMode="Number" runat="server"></asp:TextBox></td>   
                                                </FooterTemplate>
                                                <ItemStyle HorizontalAlign="Left" />
                                                <HeaderStyle />
                                            </asp:TemplateField>


                                            <asp:TemplateField HeaderText="Acceso">
                                                <ItemTemplate>
                                                    <div>
                                                        <asp:TextBox ID="txt_PK_Rutas" Text='<%# Eval("PK_RutaDetalle") %>' Visible="false" runat="server"></asp:TextBox>
                                                        <asp:DropDownList runat="server" ID="ddlAccesos" type="text" CssClass="form-control" SelectedValue='<%# Bind("FK_Acceso") %>' DataSourceID="sql_accesos" DataValueField="codigo" DataTextField="nombre" AppendDataBoundItems="true">
                                                            <asp:ListItem Value="0">Todos...</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </div>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:DropDownList runat="server" ID="ddlAccesos" type="text" CssClass="form-control" DataSourceID="sql_accesos" DataValueField="codigo" DataTextField="nombre" AppendDataBoundItems="true">
                                                        <asp:ListItem Value="0">Todos...</asp:ListItem>
                                                    </asp:DropDownList>
                                                </FooterTemplate>
                                                <ItemStyle HorizontalAlign="Left" />
                                                <HeaderStyle />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Estado">

                                                <ItemTemplate>
                                                    <asp:CheckBox ID="CheckBox1" Checked='<%# Bind("Estado") %>' CssClass="form-check" runat="server" />
                                                </ItemTemplate>

                                            </asp:TemplateField>



                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="btnEliminar" runat="server" OnClientClick="return getConfirmation();" CommandName="Delete" CssClass="btn btn-info btn-sm"><i class="fa fa-trash"></i></asp:LinkButton>
                                                    <asp:LinkButton ID="btnEditar" runat="server" CssClass="btn btn-primary btn-sm" CommandName="Update"><i class="fas fa-pencil-alt"></i></asp:LinkButton>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:LinkButton ID="btn_agregar" OnClick="btn_agregar_Click" runat="server" CssClass="btn btn btn-info"><i class="fa fa-plus-circle"></i></asp:LinkButton>
                                                </FooterTemplate>
                                                <ItemStyle HorizontalAlign="Center" Width="100px" CssClass="actioncolumn" />
                                                <FooterStyle HorizontalAlign="Center" />
                                                <HeaderStyle />
                                            </asp:TemplateField>




                                        </Columns>
                                    </asp:GridView>
                            
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-primary">Save changes</button>
                        </div>
                    </div>
                </div>
            </div>


            <asp:HiddenField ID="hfcod_transaccion" runat="server" />
            <asp:HiddenField ID="hfcod_Actividad" runat="server" />




        </div>


    </form>
</body>
</html>
