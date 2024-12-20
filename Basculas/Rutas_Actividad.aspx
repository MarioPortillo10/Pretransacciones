<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Rutas_Actividad.aspx.cs" Inherits="Basculas_Rutas_Actividad" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.2/css/all.css" integrity="sha384-/rXc/GQVaYpyDdyxK+ecHPVYJSN9bmVFBvjA/9eOB+pb3F2w2N6fc5qB9Ew5yIns" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/fancyapps/fancybox@3.5.6/dist/jquery.fancybox.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" />

    <script src="../src/js/jquery-3.4.1.js"></script>
    <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

    <script>
        //Confirma si el cliente quiere eliminar el item.
        function getConfirmation() 
        {
            var retVal = confirm("¿Desea eliminar esta fila?");
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
</head>
<body>
    <form id="form1" runat="server">
        <asp:SqlDataSource ID="sql_rutas_actividades" runat="server" ConnectionString="<%$ ConnectionStrings:ConnProduccion %>"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sql_rutas_actividadesDetalles" runat="server" ConnectionString="<%$ ConnectionStrings:ConnStr_LEVERANS_prod %>"
            InsertCommand="INSERT INTO [dbo].[LEVERANS_Plantilla_Rutas]([FK_Acceso],[Fk_Actividad],[Estado],[Correlativo])VALUES(@FK_Acceso,@FK_Actividad,1,@Correlativo)"
            DeleteCommand="DELETE FROM [dbo].[LEVERANS_Plantilla_Rutas] WHERE [PK_Ruta]=@PK_Rutas"
            UpdateCommand="UPDATE [dbo].[LEVERANS_Plantilla_Rutas] SET [Correlativo] = @Correlativo,[FK_Acceso]=@FK_Acceso,[Estado] = @Estado  WHERE [PK_Ruta]=@PK_Rutas">

            <InsertParameters>
                <asp:Parameter Name="FK_Acceso" Type="Int32" />
                <asp:Parameter Name="FK_Actividad" Type="Int32" />
                <asp:Parameter Name="Correlativo" Type="Int32" />
            </InsertParameters>

            <DeleteParameters>
                <asp:Parameter Name="PK_Rutas" Type="Int32" />
            </DeleteParameters>

            <UpdateParameters>
                <asp:Parameter Name="PK_Rutas" Type="Int32" />
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
                    <li class="nav-item active">
                        <a class="nav-link" href="Default.aspx"><i class="far fa-file-alt"></i>&nbsp;Pre-Transacciones</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="Rutas_Transacciones.aspx">Rutas Transacciones</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="Rutas_Actividad.aspx">Rutas Actividades</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="Lista_Negra.aspx"><i class="fas fa-list-alt"></i>&nbsp;Lista Negra Motorista</a>
                    </li>

                    <li class="nav-item active">
                        <a class="nav-link" href="Prechequeo.aspx"><i class="fas fa-qrcode"></i>&nbsp;Prechequeo</a>
                    </li>
                </ul>

                <div class="my-2 my-lg-0">
                    <asp:LinkButton ID="lnk_salir" CssClass="btn btn-outline-info my-2 my-sm-0" runat="server"><i class="fas fa-power-off">&nbsp Salir </i>&nbsp<i class="far fa-user"></i></asp:LinkButton>
                </div>
            </div>
        </nav>

        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="container">
                        <h2>Plantilla de Rutas</h2>

                        <asp:GridView ID="gvw_rutas_plantillas" CssClass="table table-hover table-striped" GridLines="None" runat="server" AutoGenerateColumns="false" DataKeyNames="Code">
                            <Columns>
                                <asp:TemplateField HeaderText="Codigo">
                                    <ItemTemplate>
                                        <div>
                                            <asp:Label ID="lblCode" runat="server" Text='<%# Eval("Code") %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Descripción">
                                    <ItemTemplate>
                                        <div>
                                            <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description") %>'></asp:Label>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle />
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <div>
                                            <asp:LinkButton CssClass="btn btn-primary" ID="lnk_VerRuta" runat="server" OnClick="lnk_VerRuta_Click">Ver Ruta</asp:LinkButton>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" />
                                    <HeaderStyle />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>

            <!-- Modal -->
            <div class="modal fade bd-example-modal-lg" id="modal-detalle" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Detalle de Ruta</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                        <div class="modal-body">
                            <asp:GridView ID="gvw_rutasDetalles" runat="server" DataSourceID="sql_rutas_actividadesDetalles" AutoGenerateColumns="false" CssClass="table table-hover" BorderColor="White" ShowFooter="true" OnRowDeleting="gvw_rutasDetalles_RowDeleting" DataKeyNames="PK_Ruta" OnRowUpdating="gvw_rutasDetalles_RowUpdating">
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
                                                <asp:TextBox ID="txt_PK_Rutas" Visible="false" runat="server"></asp:TextBox>
                                                    <asp:DropDownList runat="server" ID="ddlAccesos" type="text" CssClass="form-control" SelectedValue='<%# Bind("FK_Acceso") %>' DataSourceID="sql_accesos" DataValueField="Pk_Acceso" DataTextField="Descripcion" AppendDataBoundItems="true">
                                                        <asp:ListItem Value="0">Todos...</asp:ListItem>
                                                    </asp:DropDownList>
                                            </div>
                                        </ItemTemplate>
  
                                        <FooterTemplate>
                                            <asp:DropDownList runat="server" ID="ddlAccesos" type="text" CssClass="form-control" DataSourceID="sql_accesos" DataValueField="Pk_Acceso" DataTextField="Descripcion" AppendDataBoundItems="true">
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
                    </div>
                    <asp:HiddenField ID="hfCodigo" runat="server" />
                </div>
            </form>
</body>
</html>
