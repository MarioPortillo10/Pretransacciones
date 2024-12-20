<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Autorizacion_Camiones.aspx.cs" Inherits="Basculas_Autorizacion_Camiones" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Autorizacion de Camiones</title>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.2/css/all.css" integrity="sha384-/rXc/GQVaYpyDdyxK+ecHPVYJSN9bmVFBvjA/9eOB+pb3F2w2N6fc5qB9Ew5yIns" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/fancyapps/fancybox@3.5.6/dist/jquery.fancybox.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" />

    <style>
        .carnet-card {
            height: 350px;
            width: 100%;
            max-width: 350px; /* Ajuste de ancho */
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            text-align: center;
            background-color: #f8f9fa;
            transition: transform 0.3s ease-in-out;
        }

        .carnet-card:hover {
            transform: scale(1.05);
        }

        .carnet-card:hover {
            transform: scale(1.05);
        }

        .card-image {
            background:linear-gradient(to bottom right, #1E90FF, #32CD32); /* Degradado de azul a verde */
            padding: 10px;
        }

        .profile-img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            margin: 0 auto;
            display: block;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .card-title {
            color: #154360;
            font-weight: bold;
            font-size: 1.1em;
        }

        .card-text {
            font-size: 1.0rem;
            color: #333;
            margin: 4px 0;
        }

        .card-container {
            display: flex;
            justify-content: center;
        }

    </style>

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

        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">ALMAPAC</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="Default.aspx"><i class="far fa-file-alt"></i>&nbsp;Pre-Transacciones</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="Rutas_Transacciones.aspx">Rutas Transacciones</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="Rutas_Actividad.aspx">Rutas Actividades</a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="Prechequeo.aspx"><i class="fas fa-qrcode"></i>&nbsp;Prechequeo</a>
                    </li>

                    <li class="nav-item active" style="position: relative">
                        <span id="nft_1" class="badge badge-danger" style="position: absolute; top: -5px; left: 12px;"></span>
                        <a class="nav-link bg-primary text-white" href="Autorizacion_Camiones.aspx">
                            <i class="fas fa-truck"></i>&nbsp;Autorizacion de Camiones
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link" href="Autorizacion_ingreso.aspx"><i class="fas fa-unlock"></i>&nbsp;Autorizacion Ingreso</a>
                    </li>

                     <li class="nav-item">
                        <a class="nav-link" href="Tiempos_Azucar.aspx">
                            <i class="fas fa-clock"></i>&nbsp;Recepcion Azucar
                        </a>
                    </li>
                </ul>

               <div class="my-2 my-lg-0">
                    <asp:LinkButton ID="lnk_perfil" OnClick="lnk_perfil_Click" CssClass="btn btn-outline-success my-2 my-sm-0" runat="server"> Perfil</asp:LinkButton>
                    <asp:LinkButton ID="lnk_salir"  OnClick="LinkSalir1_Click" CssClass="btn btn-outline-info my-2 my-sm-0" runat="server"><i class="fas fa-power-off">&nbsp Salir </i>&nbsp<i class="far fa-user"></i></asp:LinkButton>
                </div>
            </div>
        </nav>

        <div class="row ml-4">
            <h2>Autorizacion de Camiones</h2>
        </div>
       <br>

        <div class="row justify-content-center" style="margin: 20px;">
            <div class="col-lg-6 mb-4">
                <input type="text" id="searchInput" class="form-control" style="height: 45px; width: 800px; border-radius: 8px 8px 8px 8px;" placeholder="Buscar..." onkeyup="filterCards()">
            </div>
        </div>

        <div class="row justify-content-center" style="margin: 20px;">
            <asp:Repeater ID="rptRutas" runat="server">
                <ItemTemplate>
                    <div class="col-lg-3 col-md-8 col-sm-8 mb-3 card-container">
                        <div class="card carnet-card">
                            <!-- Imagen de perfil (por ejemplo, para un conductor) -->
                            <div class="card-image">
                                <img src="path_to_image.jpg" alt="Imagen de Perfil" class="profile-img" />
                            </div>
                            <div class="card-body d-flex flex-column">
                                <!-- Información del carnet -->
                                <asp:LinkButton CssClass="btn" ID="lnk_VerRuta" runat="server" data-toggle="modal" data-target="#rutaModal">
                                    <asp:Label ID="lblCodT" Visible="false" runat="server" Text='<%# Eval("id") %>'></asp:Label>
                                    <h5 class="card-title">Codigo: <asp:Label ID="lblcodgen" runat="server" Text='<%# Eval("codeGen") %>'></asp:Label></h5>
                                    <p class="card-text text-left">Fecha: <asp:Label ID="lblFecha" runat="server" Text='<%# Convert.ToDateTime(Eval("createdAt")).ToString("dd/MM/yyyy") %>'></asp:Label></p>
                                    <p class="card-text text-left">Ingenio: <asp:Label ID="lblIngenio" runat="server" Text='<%# HttpUtility.HtmlEncode(Eval("ingenio.user.username").ToString()) %>'></asp:Label></p>
                                    <p class="card-text text-left">Placa Remolque: <asp:Label ID="lblPlacaRemolque" runat="server" Text='<%# Eval("vehicle.trailerPlate") %>'></asp:Label></p>
                                    <p class="card-text text-left">Placa Camion: <asp:Label ID="lblPlacaCamion" runat="server" Text='<%# Eval("vehicle.plate") %>'></asp:Label></p>
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
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
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal -->
<div class="modal fade" id="rutaModal" tabindex="-1" role="dialog" aria-labelledby="rutaModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="rutaModalLabel">Asignacion de tarjeta</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form id="asignacionForm">
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">Licencia:</label>
            <input type="text" class="form-control" id="txt_licencia">
          </div>

          <div class="form-group">
            <label for="message-text" class="col-form-label">Placa Remolque:</label>
            <input type="text" class="form-control" id="txt_placaremolque">
          </div>

          <div class="form-group">
            <label for="message-text" class="col-form-label">Placa Camion:</label>
            <input type="text" class="form-control" id="txt_placamion">
          </div>

          <div class="form-group">
            <label for="message-text" class="col-form-label">No. Tarjeta:</label>
            <input type="text" class="form-control" id="txt_tarjeta">
          </div>
        </form>
        <asp:Label ID="lblRuta" runat="server" Text=""></asp:Label>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
        <button type="button" class="btn btn-primary" id="confirmarBtn">Confirmar</button>
      </div>
    </div>
  </div>
</div>
        </form>
    </asp:SqlDataSource>

    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.all.min.js"></script>
    <script type="text/javascript" src="../scripts/jquery.blockUI.js"></script>
    <script src="https://cdn.jsdelivr.net/picturefill/2.3.1/picturefill.min.js"></script>
    <script src="https://cdn.rawgit.com/sachinchoolur/lightgallery.js/master/dist/js/lightgallery.js"></script>
    <script src="https://cdn.rawgit.com/sachinchoolur/lg-pager.js/master/dist/lg-pager.js"></script>
    <script src="https://cdn.rawgit.com/sachinchoolur/lg-autoplay.js/master/dist/lg-autoplay.js"></script>
    <script src="https://cdn.rawgit.com/sachinchoolur/lg-fullscreen.js/master/dist/lg-fullscreen.js"></script>
    <script src="https://cdn.rawgit.com/sachinchoolur/lg-zoom.js/master/dist/lg-zoom.js"></script>
    <script src="https://cdn.rawgit.com/sachinchoolur/lg-hash.js/master/dist/lg-hash.js"></script>
    <script src="https://cdn.rawgit.com/sachinchoolur/lg-share.js/master/dist/lg-share.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script>
    
    <script>
        function filterCards() 
        {
            // Obtener el valor del input de búsqueda
            const input = document.getElementById('searchInput');
            const filter = input.value.toLowerCase(); // Convertir a minúsculas para una búsqueda insensible a mayúsculas
            const cardContainers = document.querySelectorAll('.card-container'); // Seleccionar todas las tarjetas

            // Iterar sobre cada tarjeta y mostrar/ocultar según el filtro
            cardContainers.forEach(card => {
                const cardText = card.innerText.toLowerCase(); // Obtener el texto de la tarjeta
                if (cardText.includes(filter)) {
                    card.style.display = ''; // Mostrar la tarjeta si coincide
                } else {
                    card.style.display = 'none'; // Ocultar la tarjeta si no coincide
                }
            });
        }

        document.getElementById('confirmarBtn').addEventListener('click', function() 
        {
            
        });
  </script>
</body>
</html>
