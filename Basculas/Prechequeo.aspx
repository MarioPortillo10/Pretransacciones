<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Prechequeo.aspx.cs" Inherits="Basculas_Prechequeo" %>

    <!DOCTYPE html>

    <html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Prechequeo</title>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
            integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.2/css/all.css"
            integrity="sha384-/rXc/GQVaYpyDdyxK+ecHPVYJSN9bmVFBvjA/9eOB+pb3F2w2N6fc5qB9Ew5yIns"
            crossorigin="anonymous" />

        <script src="../src/js/jquery-3.4.1.min.js"> </script>
        <%-- <script src="../src/js/spotlight.min.js"></script>--%>
            <script src="../src/js/spotlight.bundle.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
                integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
                crossorigin="anonymous"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
                integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
                crossorigin="anonymous"></script>

            <style>
                /* Estilos para centrar el contenedor */
                .full-height {
                    height: 75vh;
                    /* Altura completa de la ventana */
                }

                .centered-container {
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: 100%;
                    /* Asegura que el contenedor ocupe toda la altura */
                }

                .code-box {
                    max-width: 600px;
                    /* Se ha aumentado el ancho */
                    width: 100%;
                    /* Ancho completo */
                    padding: 40px;
                    /* Un poco más de padding */
                    background-color: white;
                    border-radius: 10px;
                    box-shadow: 6px 6px 6px 6px rgba(0.1, 0.1, 0.1, 0.1);
                    display: flex;
                    /* Flexbox para centrar contenido interno */
                    flex-direction: column;
                    /* Coloca los elementos en columna */
                    justify-content: center;
                    /* Centra verticalmente */
                    align-items: center;
                    /* Centra horizontalmente */
                    margin-top: -50px;
                    /* Ajusta este valor para subir la tarjeta */
                }

                .submit-btn {
                    width: 100%;
                }
            </style>
    </head>

    <body>
        <form id="form1" runat="server">
            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                <a class="navbar-brand" href="#">ALMAPAC</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse"
                    data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false"
                    aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="Default.aspx">
                                <i class="far fa-file-alt"></i>&nbsp;Pre-Transacciones
                            </a>
                        </li>

                        <li class="nav-item">
                            <%--<a class="nav-link disabled" href="Rutas_Transacciones.aspx">Rutas Transacciones</a>--%>
                                <a class="nav-link" href="Rutas_Transacciones.aspx">
                                    <i class="fas fa-road"></i>&nbsp;Rutas Transacciones
                                </a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="Rutas_Actividades.aspx">
                                <i class="fas fa-road"></i>&nbsp;Rutas Actividades
                            </a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="Lista_Negra.aspx">
                                <i class="fas fa-list-alt"></i>&nbsp;Lista Negra Motorista
                            </a>
                        </li>

                        <li class="nav-item active" style="position: relative">
                            <span id="nft_1" class="badge badge-danger"
                                style="position: absolute; top: -5px; left: 12px;"></span>
                            <a class="nav-link bg-primary text-white" href="Prechequeo.aspx">
                                <i class="fas fa-qrcode"></i>&nbsp;Prechequeo
                            </a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="Autorizacion_Camiones.aspx">
                                <i class="fa fa-truck" aria-hidden="true"></i>&nbsp;Autorizacion de Camiones
                            </a>
                        </li>

                        <li class="nav-item" style="position: relative">
                            <a class="nav-link" href="Autorizacion_ingreso.aspx">
                                <i class="fas fa-unlock"></i>&nbsp;Autorizacion Ingreso
                            </a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="Tiempos_Azucar.aspx">
                                <i class="fas fa-clock"></i>&nbsp;Recepcion Azucar
                            </a>
                        </li>
                    </ul>

                    <div class="my-2 my-lg-0">
                        <asp:LinkButton ID="lnk_perfil" OnClick="lnk_perfil_Click"
                            CssClass="btn btn-outline-success my-2 my-sm-0" runat="server"> Perfil</asp:LinkButton>
                        <asp:LinkButton ID="lnk_salir" OnClick="LinkSalir1_Click"
                            CssClass="btn btn-outline-info my-2 my-sm-0" runat="server"><i
                                class="fas fa-power-off">&nbsp Salir </i>&nbsp<i class="far fa-user"></i>
                        </asp:LinkButton>
                    </div>
                </div>
            </nav>

            <div class="container-fluid" id="conten">
                <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                    ConnectionString="<%$ ConnectionStrings:ConnStr_LEVERANS_prod %>"></asp:SqlDataSource>
                <asp:SqlDataSource ID="sql_usuarios"
                    SelectCommand="SELECT [dbo].[LEVERANS_Documentos].Documento,[dbo].[Leverans_PreTransacciones].desc_actividad, [dbo].[Leverans_PreTransacciones].FechaHora FROM [dbo].[Leverans_PreTransacciones] INNER JOIN [dbo].[LEVERANS_Documentos] ON [dbo].[LEVERANS_Documentos].FK_PreTransaccion = [dbo].[Leverans_PreTransacciones].PK_PreTransaccion;"
                    runat="server" ConnectionString="<%$ ConnectionStrings:ConnStr_LEVERANS_prod %>">
                </asp:SqlDataSource>
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <br>

                        <div class="container full-height">
                            <div class="centered-container">
                                <div class="code-box">
                                    <div class="text-center mb-4">
                                        <h3 style="margin-top: 0; font-weight: 600; color: #333;">Prechequeo</h3>
                                    </div>

                                    <div class="mb-4">
                                        <div class="input-group justify-content-center">
                                            <span class="input-group-prepend">
                                                <span class="input-group-text"
                                                    style="background-color: #154360; color: white; border: none; border-radius: 8px 0 0 8px;">
                                                    <i class="fas fa-qrcode"></i>
                                                </span>
                                            </span>
                                            <asp:TextBox ID="txtTransaccion" CssClass="form-control"
                                                Style="width: 400px; border-radius: 0 8px 8px 0; text-align: center;"
                                                runat="server" required="required" />
                                        </div>
                                    </div>

                                    <input type="hidden" id="hfTransaccion" runat="server" />

                                    <div class="text-center">
                                        <asp:UpdatePanel ID="UpdatePanelBuscar" runat="server">
                                            <ContentTemplate>
                                                <asp:LinkButton ID="lnkBuscar" CssClass="btn btn-primary submit-btn"
                                                    OnClick="lnkBuscar_Click" runat="server" Text="Verificar"
                                                    OnClientClick="checkInput(); return true;" />
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                    </div>
                                </div>
                            </div>
                        </div>










                        <div class="row" style="border: solid 0px">
                            <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource1"
                                OnPagePropertiesChanging="lvwPrincipal_PagePropertiesChanging"
                                OnItemDataBound="ListView1_ItemDataBound">
                                <ItemTemplate>
                                    <div class="col-lg-4 col-md-6 col-sm-12 " style="border: solid 0px">
                                        <div class="mb-4 Content12" style="border: solid 0px">
                                            <asp:Label ID="lblCodT" Visible="false" runat="server"
                                                Text='<%# Eval("PK_PreTransaccion") %>'></asp:Label>
                                            <div class="row">
                                                <div class="col-4">
                                                    <div class="row ml-3 mt-3">
                                                        <asp:Repeater ID="rpt_galeria" runat="server">
                                                            <ItemTemplate>
                                                                <div class="col-6" style="border: solid 0px">
                                                                    <asp:HyperLink ID="HyperLink5" CssClass="spotlight"
                                                                        data-title='<%# "codTransaccion :" +DataBinder.Eval(Container.DataItem,"codTransaccion")%>'
                                                                        NavigateUrl='<%# "http://sv-svr-almapp02:2050/" + DataBinder.Eval(Container.DataItem,"Documento")%>'
                                                                        runat="server">
                                                                        <asp:Image
                                                                            class="img-fluid rounded mt-4 mb-3 mb-md-0"
                                                                            Width="100%" ID="Image1" runat="server"
                                                                            ImageUrl='<%# "http://sv-svr-almapp02:2050/" + DataBinder.Eval(Container.DataItem,"Documento_thumbnail")%>' />
                                                                    </asp:HyperLink>
                                                                </div>
                                                            </ItemTemplate>
                                                        </asp:Repeater>
                                                    </div>
                                                </div>

                                                <div class="col-8">
                                                    <br />
                                                    <h5>
                                                        <asp:Label ID="lbl_cod_estado" Visible="false" runat="server"
                                                            Text='<%# Eval("cod_estado") %>'></asp:Label>
                                                        <asp:Label ID="lblAlerta" runat="server"
                                                            ForeColor='<%# System.Drawing.ColorTranslator.FromHtml(Eval("Color").ToString()) %>'
                                                            CssClass="alerta"><i class="fa fa-circle"></i></asp:Label>
                                                        &nbsp;<asp:Label ID="Label1" ForeColor="Blue" CssClass="h5"
                                                            runat="server" Text='<%# Eval("estado") %>'></asp:Label>
                                                    </h5>
                                                    <h5>Código:
                                                        <asp:Label ID="lblCodigo" runat="server"
                                                            Text='<%# Eval("PK_PreTransaccion") %>'></asp:Label>
                                                    </h5>

                                                    <h5>Transacción:
                                                        <asp:Label ID="lblNombre" CssClass="h5" runat="server"
                                                            Text='<%# Eval("codTransaccion") %>'></asp:Label>
                                                    </h5>

                                                    <h5>Tarjeta:
                                                        <asp:Label ID="lblTarjeta" runat="server"
                                                            Text='<%# Eval("ntarjeta") %>'></asp:Label>
                                                    </h5>

                                                    <h5>Placa:
                                                        <asp:Label ID="lblPlaca" runat="server"
                                                            Text='<%# Eval("placa") %>'></asp:Label>
                                                    </h5>

                                                    <h5>Actividad:
                                                        <asp:Label ID="lblActividad" CssClass="h6" runat="server"
                                                            Text='<%# Eval("desc_actividad") %>'></asp:Label>
                                                    </h5>

                                                    <p class="h5">N° Báscula:
                                                        <asp:Label ID="Label2" runat="server"
                                                            Text='<%# Eval("nbascula") %>'></asp:Label>
                                                    </p>

                                                    <p class="h5">Fecha Creación:
                                                        <asp:Label ID="lblFecha" runat="server"
                                                            Text='<%# Eval("FechaHora") %>'></asp:Label>
                                                    </p>

                                                    <p class="h5">Fecha Autorizado:
                                                        <asp:Label ID="lblFechaAutorizado" runat="server"
                                                            Text='<%# Eval("fechaautorizado") %>'></asp:Label>
                                                    </p>
                                                    <br />

                                                    <button type="button" class="btn btn-primary mb-3" id="btn_edi"
                                                        name="btn_edit" runat="server" visible="false"
                                                        onclick='<%# "openModal(" +Eval("cod_actividad")+","+Eval("ntarjeta")+","+Eval("PK_PreTransaccion") + " );" %>'
                                                        data-toggle="modal" data-target="#modal_editActividad"><i
                                                            class="fas fa-road"></i>Editar2</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:ListView>
                        </div>

                        <div class="row" style="border: solid 0px; position: fixed; bottom: 0; left: 0; right: 0;">
                            <div class="col-lg-12 h3" style="text-align: center">
                                <asp:DataPager runat="server" ID="dtpPrincipal" PagedControlID="ListView1"
                                    PageSize="12">
                                    <Fields>
                                        <asp:NextPreviousPagerField ShowFirstPageButton="True"
                                            ShowNextPageButton="false" ShowPreviousPageButton="true"
                                            NextPageText="&lt;i class='fas fa-angle-right'&gt;&lt;/i&gt;"
                                            PreviousPageText="&lt;i class='fas fa-angle-left'&gt;&lt;/i&gt;"
                                            FirstPageText="&lt;i class='fas fa-angle-double-left'&gt;&lt;/i&gt;"
                                            LastPageText="&lt;i class='fas fa-angle-double-right'&gt;&lt;/i&gt;" />
                                        <asp:NumericPagerField />
                                        <asp:NextPreviousPagerField ShowLastPageButton="True" ShowNextPageButton="true"
                                            ShowPreviousPageButton="false"
                                            FirstPageText="&lt;i class='fas fa-angle-double-left'&gt;&lt;/i&gt;"
                                            LastPageText="&lt;i class='fas fa-angle-double-right'&gt;&lt;/i&gt;"
                                            NextPageText="&lt;i class='fas fa-angle-right'&gt;&lt;/i&gt;"
                                            PreviousPageText="&lt;i class='fas fa-angle-left'&gt;&lt;/i&gt;" />
                                    </Fields>
                                </asp:DataPager>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>

                <!-- Modal de Validación -->
                <div class="modal fade bd-example-modal-lg" id="editModal" tabindex="-1" role="dialog"
                    aria-labelledby="editModalLabel" aria-hidden="true" data-backdrop="static">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">

                            <!-- Carousel for swipe effect -->
                            <div id="carouselForms" class="carousel slide" data-bs-interval="false">
                                <div class="carousel-inner">

                                    <!-- Primer Formulario (Ingenio, Producto, Placas) -->
                                    <div class="carousel-item active">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Validacion de Prechequeo</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                <ContentTemplate>
                                                    <form>
                                                        <div class="form-group">
                                                            <label for="txt_ingenio">Ingenio</label>
                                                            <asp:TextBox ID="txt_ingenio" CssClass="form-control"
                                                                runat="server" Enabled="false"></asp:TextBox>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="txt_producto">Producto</label>
                                                            <asp:TextBox ID="txt_producto" CssClass="form-control"
                                                                runat="server" Enabled="false"></asp:TextBox>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="txt_transporte">Transporte</label>
                                                            <asp:TextBox ID="txt_transporte" CssClass="form-control"
                                                                runat="server" Enabled="false"></asp:TextBox>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="txt_motorista">Motorista</label>
                                                            <asp:TextBox ID="txt_motorista" CssClass="form-control"
                                                                runat="server" Enabled="false"></asp:TextBox>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="txt_licencia">Licencia</label>
                                                            <asp:TextBox ID="txt_licencia" CssClass="form-control"
                                                                runat="server" Enabled="false"></asp:TextBox>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="txt_placaCamion">Placa Camion</label>
                                                            <asp:TextBox ID="txt_placaCamion" CssClass="form-control"
                                                                runat="server" Enabled="false"></asp:TextBox>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="txt_placaRemolque">Placa Remolque</label>
                                                            <asp:TextBox ID="txt_placaRemolque" CssClass="form-control"
                                                                runat="server" Enabled="false"></asp:TextBox>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="txt_tipoUnidad">Tipo Unidad</label>
                                                            <asp:TextBox ID="txt_tipoUnidad" CssClass="form-control"
                                                                runat="server" Enabled="false"></asp:TextBox>
                                                        </div>
                                                    </form>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-primary"
                                                id="nextBtn">Siguiente</button>
                                        </div>
                                    </div>

                                    <!-- Segundo Formulario (Captura de Fotografía) -->
                                    <div class="carousel-item">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Captura de Fotografia</h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <form>
                                                <div class="form-group">
                                                    <label for="exampleFormControlFile1">Fotografia</label>
                                                </div>
                                                <div class="form-group">
                                                    <video id="camera" width="320" height="240"></video>
                                                    <canvas id="canvas" width="320" height="240"></canvas>
                                                </div>
                                                <div class="form-group">
                                                    <button type="button" id="takePhoto" class="btn btn-dark">
                                                        <i class="fa fa-camera" aria-hidden="true"></i> Capturar
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" id="backBtn">Volver</button>
                                            <button type="button" class="btn btn-primary"
                                                id="confirmBtn">Confirmar</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Modal RESTABLECER CONTRASEÑA -->
                <div class="modal fade" id="editPass" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
                    aria-hidden="true">
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
                                    <asp:TextBox ID="txtUsuario" Enabled="false" Text="Usuario1" CssClass="form-control"
                                        runat="server"></asp:TextBox>
                                </div>

                                <div class="form-group col-12">
                                    <asp:TextBox ID="txtPass" TextMode="Password" CssClass="form-control"
                                        placeholder="Contraseña" runat="server"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="ReqtxtPass" runat="server"
                                        ControlToValidate="txtPass" CssClass="reqGeneral" ErrorMessage="*"
                                        Display="Dynamic" ValidationGroup="reset" InitialValue=""><i
                                            class="fa fa-times-circle" aria-hidden="true"></i>
                                    </asp:RequiredFieldValidator>
                                </div>
                            </div>

                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>

        <!-- Carga jQuery completo antes de Bootstrap -->
        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha384-KyZXEAg3QhqLMpG8r+Knujsl5/6bt7F1y6OTC2GTCg4qY7KYGxk8Jp0tljF5ja2B"
            crossorigin="anonymous"></script>

        <!-- Bootstrap -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"></script>

        <!-- Popper.js (for Bootstrap) -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
            integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
            crossorigin="anonymous"></script>

        <!-- SweetAlert2 (latest version) -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.all.min.js"></script>

        <!-- Custom Scripts -->
        <script src="../src/js/spotlight.bundle.js"></script>
        <script type="text/javascript" src="../scripts/jquery.blockUI.js"></script>

        <!-- Picturefill (for responsive images) -->
        <script src="https://cdn.jsdelivr.net/picturefill/2.3.1/picturefill.min.js"></script>

        <!-- LightGallery and Plugins -->
        <script src="https://cdn.rawgit.com/sachinchoolur/lightgallery.js/master/dist/js/lightgallery.js"></script>
        <script src="https://cdn.rawgit.com/sachinchoolur/lg-pager.js/master/dist/lg-pager.js"></script>
        <script src="https://cdn.rawgit.com/sachinchoolur/lg-autoplay.js/master/dist/lg-autoplay.js"></script>
        <script src="https://cdn.rawgit.com/sachinchoolur/lg-fullscreen.js/master/dist/lg-fullscreen.js"></script>
        <script src="https://cdn.rawgit.com/sachinchoolur/lg-zoom.js/master/dist/lg-zoom.js"></script>
        <script src="https://cdn.rawgit.com/sachinchoolur/lg-hash.js/master/dist/lg-hash.js"></script>
        <script src="https://cdn.rawgit.com/sachinchoolur/lg-share.js/master/dist/lg-share.js"></script>


        <!-- Código para mostrar el modal -->

        <script>

            // Inicializar el carrusel
            var carouselElement = document.getElementById('carouselForms');
            var carousel = new bootstrap.Carousel(carouselElement, {
                interval: false // Asegúrate de que el intervalo esté desactiv ado
            });

            // Mover al siguiente formulario
            document.getElementById('nextBtn').addEventListener('click', function () {
                carousel.next(); // Mueve al siguiente formulario (slide)
            });

            // Volver al formulario anterior
            document.getElementById('backBtn').addEventListener('click', function () {
                carousel.prev(); // Mueve al formulario anterior (slide)
            });

            // Cerrar la modal al hacer clic en el botón de cierre
            $('[data-bs-dismiss="modal"]').on('click', function () {
                $('#editModal').modal('hide');
            });

            function checkInput() {
                var txtTransaccion = document.getElementById('txtTransaccion').value.trim();
                if (txtTransaccion === '') {
                    Swal.fire({
                        title: 'Error',
                        text: 'Por favor, Ingrese un Codigo de Generacion',
                        icon: 'error',
                        confirmButtonColor: '#3085d6',
                        confirmButtonText: 'Aceptar'
                    });
                    return false;
                } else {
                    $('#editModal').modal('show');
                }
            }



            lightGallery(document.getElementById('lightgallery'));

            // Get the video and canvas elements
            const video = document.getElementById('camera');
            const canvas = document.getElementById('canvas');
            const takePhotoButton = document.getElementById('takePhoto');

            // Request permission to access the camera
            navigator.mediaDevices.getUserMedia({ video: true, audio: false })
                .then(stream => {
                    // Set the video source to the camera stream
                    video.srcObject = stream;
                    video.play();

                    // Take a photo when the user clicks the button
                    takePhotoButton.addEventListener('click', () => {
                        // Draw the video frame onto the canvas
                        canvas.getContext('2d').drawImage(video, 0, 0, canvas.width, canvas.height);
                        event.preventDefault();
                        // Get the photo as a base64-encoded string
                        const photo = canvas.toDataURL('image/jpeg');
                        var codeGen = document.getElementById('txtTransaccion').value.trim();
                        console.log("este es code gen: ", codeGen);

                        // Enviar la imagen al servidor con AJAX
                        fetch('Prechequeo.aspx/UploadPhoto', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json'
                            },
                            body: JSON.stringify({ imageData: photo, codeGen: codeGen })
                        })
                            .then(response => response.json())
                            .then(result => {
                                // Mostrar SweetAlert basado en la respuesta
                                console.log("este es el result", result);
                                if (result.d === 'success') {
                                    Swal.fire('Éxito', 'Imagen enviada correctamente', 'success');
                                } else {
                                    Swal.fire('Error', 'Hubo un problema al enviar la imagen', 'error');
                                }
                            })
                            .catch(error => {
                                console.error('Error al enviar la imagen:', error);
                                Swal.fire('Error', 'No se pudo conectar con el servidor', 'error');
                            });
                    });
                })
                .catch(error => {
                    console.error('Error accessing camera:', error);
                });



        </script>
    </body>

    </html>