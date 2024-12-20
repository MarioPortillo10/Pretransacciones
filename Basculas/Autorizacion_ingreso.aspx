<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Autorizacion_ingreso.aspx.cs" Inherits="Basculas_Autorizacion_ingreso" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Autorizacion de Ingreso</title>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.2/css/all.css" integrity="sha384-/rXc/GQVaYpyDdyxK+ecHPVYJSN9bmVFBvjA/9eOB+pb3F2w2N6fc5qB9Ew5yIns" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/fancyapps/fancybox@3.5.6/dist/jquery.fancybox.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" />

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
    .custom-bullet 
    {
        display: inline-block;
        width: 15px;
        height: 10px;
        background-color: #007bff; /* Color de la viñeta */
        border-radius: 50%; /* Hacerlo circular */
        margin-right: 5px; /* Espacio entre la viñeta y el texto */
    }
    
    .icon-container 
    {
        width: 75px; /* Ajusta el tamaño del contenedor */
        height: 75px; /* Ajusta el tamaño del contenedor */
        border-radius: 50%; /* Hace que el contenedor sea redondo */
        background-color: #f0f0f0; /* Color de fondo del contenedor */
        display: flex; /* Usar flexbox para centrar el ícono */
        align-items: center; /* Centra verticalmente */
        justify-content: center; /* Centra horizontalmente */
        margin-top: -40px; /* Ajusta este valor para mover el contenedor hacia arriba */
        margin-left: 375px; /* Ajusta este valor para mover el contenedor a la derecha */

    }

    .icon-container i 
    {
        font-size: 36px; /* Tamaño del ícono */
        color: #333; /* Color del ícono */
        transition: transform 0.3s ease; /* Transición suave para el ícono */
    }

    .icon-container:hover i 
    {
        transform: rotate(10deg); /* Rota el ícono al hacer hover */
    }

   .icon-container1 
    {
        display: flex;
        justify-content: center; /* Centra el contenido horizontalmente */
        align-items: center; /* Centra el contenido verticalmente */
        margin-top: -100px; /* Espacio superior para separar del contenido anterior */
        margin-left: 410px; /* Espacio izquierdo para separar del contenido anterior  */

    }

    .circle-number 
    {
        width: 40px; /* Ancho del círculo */
        height: 40px; /* Alto del círculo */
        border-radius: 50%; /* Hace que el contenedor sea redondo */
        display: flex; /* Usar flexbox para centrar el número */
        justify-content: center; /* Centra horizontalmente */
        align-items: center; /* Centra verticalmente */
        font-size: 20px; /* Tamaño del texto */
        font-weight: bold; /* Peso del texto */
        color: white; /* Color del texto */
    }

    .gold 
    {
        background-color: #0050a0; /* Color dorado */
    }

    .silver 
    {
        background-color: #27a000; /* Color plata */
    }

    .bronze 
    {
        background-color: #d66b00; /* Color bronce */
    }

    .yellow 
    {
        background-color: #154360; /* Color amarillo */
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
                //alert("User  wants to continue!");
                return true;
            } 
            else 
            {
                //alert("User  does not want to continue!");
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

                    <li class="nav-item active">
                        <a class="nav-link" href="Prechequeo.aspx"><i class="fas fa-qrcode"></i>&nbsp;Prechequeo</a>
                    </li>

                    <li class="nav-item active">
                        <a class="nav-link" href="Autorizacion_Camiones.aspx">
                            <i class="fas fa-truck"></i>&nbsp;Autorizacion de Camiones
                        </a>
                    </li>

                    <li class="nav-item active" style="position: relative">
                        <span id="nft_1" class="badge badge-danger" style="position: absolute; top: -5px; left: 12px;"></span>
                        <a class="nav-link bg-primary text-white" href="Autorizacion_ingreso.aspx">
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
                    <asp:LinkButton ID="lnk_perfil" OnClick="lnk_perfil_Click" CssClass="btn btn-outline-success my-2 my-sm-0" runat="server"> Perfil</asp:LinkButton>
                    <asp:LinkButton ID="lnk_salir"  OnClick="LinkSalir1_Click" CssClass="btn btn-outline-info my-2 my-sm-0" runat="server"><i class="fas fa-power-off">&nbsp Salir </i>&nbsp<i class="far fa-user"></i></asp:LinkButton>
                </div>
            </div>
        </nav>

        <div class="row ml-4">
            <h2>Autorizacion de Ingreso</h2>
        </div>

        <div class="row justify-content-center" style="margin: 20px;">
            <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
                <div class="card" style="height: 150px; width: 350px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);">
                    <span style="position: absolute; left: 0; top: 0; height: 100%; width: 25px; background-color: #C9E9D2; border-radius: 10px;"></span>
                    <div class="card-body d-flex flex-column">                            
                        <h2 class="card-text text-center">Plano</h2>
                        <br>
                        <h2 class="card-text text-center">1</h2>                     
                    </div>
                </div>
            </div>
            
            <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
                <div class="card" style="height: 150px; width: 350px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);">
                      <span style="position: absolute; left: 0; top: 0; height: 100%; width: 25px; background-color: #295F98; border-radius: 10px;"></span>
                    <div class="card-body d-flex flex-column">                            
                        <h2 class="card-text text-center">Volteo</h2>
                        <br>
                        <h2 class="card-text text-center">3</h2>  
                    </div>
                </div>
            </div>
        </div>

        <div class="row ml-3 sticky-top" style="border: solid 0px;">
            <div class="col-9 mt-2 mb-2">
            <!--    <input type="text" id="searchInput" onkeyup="filterCards()" placeholder="Buscar transacciones..." class="form-control mb-3" style="border-radius: 15px;"> -->
            </div>
        </div>

        
        <div class="row justify-content-center" style="margin: 20px;">
        <asp:Repeater ID="rptRutas" runat="server">
            <ItemTemplate>
                <div class="col-lg-4 col-md-6 col-sm-12 mb-4">
                    <div class="card" style="height: 300px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);">
                        <div class="card-body d-flex flex-column">                            
                            <%-- Viñeta Dinámica --%>
                            <span style="padding: 8px 15px; border-radius: 12px; display: inline-block; font-size: 18px;" 
                                    class='<%# Eval("vehicle.truckType").ToString() == "volteo" ? "badge badge-success" : 
                                            Eval("vehicle.truckType").ToString() == "rastra" ? "badge badge-dark" : 
                                            "badge badge-dark" %>'>
                                <%# Eval("vehicle.truckType").ToString() == "volteo" ? "Volteo" : 
                                    Eval("vehicle.truckType").ToString() == "rastra" ? "Rastra" : 
                                    "Plano" %>
                            </span>
                            <asp:LinkButton CssClass="btn" ID="lnk_VerRuta" runat="server" data-toggle="modal" data-target="#rutaModal">
                            <asp:Label ID="lblCodT" Visible="false" runat="server" Text='<%# Eval("id") %>'></asp:Label>
                            <h5></h5>
                            <h5 class="card-text text-left">Transaccion:    <asp:Label ID="lblNombre"        runat="server" Text='<%# Eval("id") %>'></asp:Label></h5>
                            <h5 class="card-text text-left">Fecha:          <asp:Label ID="lblFecha"         runat="server" Text='<%# Convert.ToDateTime(Eval("createdAt")).ToString("dd/MM/yyyy") %>'></asp:Label></h5>
                            <h5 class="card-text text-left">Motorista:      <asp:Label ID="lblMotorista"     runat="server" Text='<%# Eval("transporter") %>'></asp:Label></h5>
                            <h5 class="card-text text-left">Ingenio:        <asp:Label ID="lblIngenio"       runat="server" Text='<%# HttpUtility.HtmlEncode(Eval("ingenio.user.username").ToString()) %>'></asp:Label></h5>
                            <h5 class="card-text text-left">Placa Remolque: <asp:Label ID="lblPlacaRemolque" runat="server" Text='<%# Eval("vehicle.trailerPlate") %>'></asp:Label></h5>
                            <h5 class="card-text text-left">Placa Camion:   <asp:Label ID="lblPlacaCamion"   runat="server" Text='<%# Eval("vehicle.plate") %>'></asp:Label></h5>
     
                            <div class="icon-container">
                                <i class="fa fa-truck" aria-hidden="true"></i>
                            </div>

                            <div class="icon-container1">
                                <span class='<%# Container.ItemIndex == 0 ? "circle-number gold" : 
                                           Container.ItemIndex == 1 ? "circle-number silver" : 
                                           Container.ItemIndex == 2 ? "circle-number bronze" : 
                                           "circle-number yellow" %>'>
                                    <%# Container.ItemIndex + 1 %>
                                </span> <!-- Muestra el número de orden -->
                            </div>
                            
                        </div>
                    </div>
                    </asp:LinkButton>
                </div>
                
            </ItemTemplate>
        </asp:Repeater>
        </div>

        <!-- Modal RESTABLECER CONTRASEÑA -->
        <div class="modal fade" id="editPass" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class=" modal-title" id="editPass2">Cambiar contraseña</h5>
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

        <div class="modal fade" id="rutaModal" tabindex="-1" role="dialog" aria-labelledby="rutaModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="rutaModalLabel">Asignar Tarjeta</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="form-group">
                                <label for="recipient-name" class="col-form-label">Tarjeta:</label>
                                <input type="text" class="form-control" id="txt_tarjeta">
                            </div>
                        </form>
                        <asp:Label ID="lblRuta" runat="server" Text=""></asp:Label>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                        <button type="button" class="btn btn-primary">Confirmar</button>
                    </div>
                </div>
            </div>
    </form>

<script>
    var response = '<%= ViewState["ResponseBody"] %>';
    console.log("HOLA SI ESTOY LLEGANDO ACA: ", response)
    console.log(response); // Muestra la respuesta en la consola
</script>




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
    <script>
        function filterCards() 
        {
            const input = document.getElementById('searchInput').value.toLowerCase();
            const cards = document.querySelectorAll('.card');
            
            cards.forEach(card => {
                const text = card.textContent.toLowerCase();
                card.style.display = text.includes(input) ? '' : 'none';
            });
        }
    </script>
</body>
</html>