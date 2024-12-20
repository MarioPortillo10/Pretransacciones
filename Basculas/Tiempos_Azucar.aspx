<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Tiempos_Azucar.aspx.cs" Inherits="Basculas_Tiempos_azucar" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Recepcion Azucar</title>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.2/css/all.css" integrity="sha384-/rXc/GQVaYpyDdyxK+ecHPVYJSN9bmVFBvjA/9eOB+pb3F2w2N6fc5qB9Ew5yIns" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/fancyapps/fancybox@3.5.6/dist/jquery.fancybox.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" />

    <style>
        /* Ajusta el contenedor al 100% de ancho de la pantalla */
        .container {
        width: 100%;
        }

        /* Estilos para la sección de "Unidades En Espera" */
        .espera-section {
        display: flex; /* Habilita el flexbox */
        justify-content: space-between; /* Distribuye los elementos con espacio entre ellos */
        align-items: center; /* Centra los elementos verticalmente */
        }

        /* Estilos para la sección de "Solicitar Unidades" */
        .solicitar-section {
        display: flex; /* Habilita el flexbox */
        justify-content: space-between; /* Distribuye los elementos con espacio entre ellos */
        align-items: center; /* Centra los elementos verticalmente */
        }

        /* Estilos para los grupos de unidades (Plano y Volteo) */
        .unidad-group {
        display: flex; /* Habilita el flexbox */
        flex-direction: column; /* Ordena los elementos verticalmente */
        align-items: center; /* Centra los elementos verticalmente */
        width: 45%; /* Ancho de cada grupo */
        }

        /* Estilos para los labels */
        .unidad-label {
        margin-bottom: 5px; /* Margen inferior para el label */
        }

        /* Estilos para los inputs */
        .unidad-input {
        width: 100px; /* Ancho del input */
        height: 30px; /* Alto del input */
        border: 1px solid #ccc; /* Borde del input */
        border-radius: 5px; /* Bordes redondeados */
        text-align: center; /* Centra el texto dentro del input */
        }

        /* Estilos para los botones de cantidad */
        .unidad-button {
        width: 30px; /* Ancho del botón */
        height: 30px; /* Alto del botón */
        border: 1px solid #ccc; /* Borde del botón */
        border-radius: 5px; /* Bordes redondeados */
        margin: 0 5px; /* Margen horizontal entre botones */
        }

         .progress-circle {
        width: 100px;
        height: 100px;
        background: conic-gradient(#4caf50 0deg, #f0f0f0 0deg);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
    }

    .progress-circle span {
        position: absolute;
        font-size: 16px;
        color: #000;
    }

    .buttons {
        margin-top: 10px;
        display: flex;
        gap: 10px;
    }

    button {
        padding: 6px 12px;
        border: none;
        border-radius: 5px;
        background-color: #4caf50;
        color: white;
        cursor: pointer;
    }

    button:hover {
        background-color: #45a049;
    }
    </style>    

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
                        <a class="nav-link" href="Lista_Negra.aspx"><i class="fas fa-list-alt"></i>&nbsp;Lista Negra Motorista</a>
                    </li>

                    <li class="nav-item active">
                        <a class="nav-link" href="Prechequeo.aspx"><i class="fas fa-qrcode"></i>&nbsp;Prechequeo</a>
                    </li>

                    <li class="nav-item active">
                        <a class="nav-link" href="Autorizacion_Camiones.aspx">
                            <i class="fas fa-truck"></i>&nbsp;Autorizacion de Camiones
                        </a>
                    </li>

                    <li class="nav-item active">
                        <a class="nav-link" href="Autorizacion_ingreso.aspx">
                            <i class="fas fa-unlock"></i>&nbsp;Autorizacion Ingreso
                        </a>
                    </li>

                    <li class="nav-item active" style="position: relative">
                        <span id="nft_1" class="badge badge-danger" style="position: absolute; top: -5px; left: 12px;"></span>
                        <a class="nav-link bg-primary text-white" href="Tiempos_Azucar.aspx">
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
             <h2 class="text-center">Recepcion de Azucar</h2>
        </div>

        <div class="container">
            <div class="row justify-content-center" style="margin: 10px;">
                <div class="col-lg-6">
                    <h3 class="text-center mb-4">Unidades En Espera</h3>
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6 mb-4 d-flex">
    <div class="card flex-fill" style="height: 130px; width: 350px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);">
        <span style="position: absolute; left: 0; top: 0; height: 100%; width: 15px; background-color: #C9E9D2; border-radius: 10px;"></span>
        <h2 class="card-text text-center" style="margin-top: 10px;">Plano</h2>
        <div class="card-body d-flex flex-column align-items-center" style="justify-content: flex-start; padding-top: 10px;">                            
            <div style="display: flex; align-items: center;">
                <input type="number" value="1" data-type="plano" style="width: 60px; text-align: center; margin: 0 5px;" />
            </div>
        </div>
    </div>
</div>

<div class="col-lg-6 col-md-6 col-sm-6 mb-4 d-flex">
    <div class="card flex-fill" style="height: 130px; width: 350px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);">
        <span style="position: absolute; left: 0; top: 0; height: 100%; width: 15px; background-color: #4472C4; border-radius: 10px;"></span>
        <h2 class="card-text text-center" style="margin-top: 10px;">Volteo</h2>
        <div class="card-body d-flex flex-column align-items-center" style="justify-content: flex-start; padding-top: 10px;">                            
            <div style="display: flex; align-items: center;">
                <input type="number" value="3" data-type="volteo" style="width: 60px; text-align: center; margin: 0 5px;" />
            </div>
        </div>
    </div>
</div>
                    </div>
                </div>
            
                <div class="col-lg-6">
                    <h3 class="text-center mb-4">Solicitar Unidades</h3>
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6 mb-4 d-flex">
                            <div class="card flex-fill" style="height: 130px; width: 350px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);">
                                <h2 class="card-text text-center">Plano</h2>
                                <span style="position: absolute; left: 0; top: 0; height: 100%; width: 15px; background-color: #C9E9D2; border-radius: 10px;"></span>

                                <div class="card-body d-flex flex-column align-items-center justify-content-between" style="height: 100%; padding: 10px;">
                                    <div style="display: flex; align-items: center; justify-content: center; margin-top: -10px;">
                                        <button id="decreaseButtonPlano" class="btn btn-sm btn-secondary" type="button" style="margin: 0 5px;">-</button>
                                        <input id="numberInputPlano" type="number" value="0" data-type="plano" style="width: 60px; text-align: center; margin: 0 5px; border: 2px solid #C9E9D2; border-radius: 5px; padding: 5px; font-size: 16px; transition: border-color 0.3s;" 
                                            onfocus="this.style.borderColor='#4472C4';" 
                                            onblur="this.style.borderColor='#C9E9D2';" />
                                        <button id="increaseButtonPlano" class="btn btn-sm btn-secondary" type="button" style="margin: 0 5px;">+</button>
                                    </div>
                                    <button id="solicitarButtonPlano" class="btn btn-primary mt-1" style="width: 85px; margin-top: 5px;">Solicitar</button>
                                </div>
                            </div>
                        </div>
                
                        <div class="col-lg-6 col-md-6 col-sm-6 mb-4 d-flex">
                            <div class="card flex-fill" style="height: 130px; width: 350px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);">
                                <span style="position: absolute; left: 0; top: 0; height: 100%; width: 15px; background-color: #4472C4; border-radius: 10px;"></span>
                                <h2 class="card-text text-center">Volteo</h2>
                                <div class="card-body d-flex flex-column align-items-center justify-content-between" style="height: 100%; padding: 10px;">
                                    <div style="display: flex; align-items: center; justify-content: center; margin-top: -10px;">
                                        <button id="decreaseButtonVolteo" class="btn btn-sm btn-secondary" type="button" style="margin: 0 5px;">-</button>
                                        <input id="numberInputVolteo" type="number" value="0" data-type="volteo" style="width: 60px; text-align: center; margin: 0 5px; border: 2px solid #4472C4; border-radius: 5px; padding: 5px; font-size: 16px; transition: border-color 0.3s;" 
                                            onfocus="this.style.borderColor='#C9E9D2';" 
                                            onblur="this.style.borderColor='#4472C4';" />
                                        <button id="increaseButtonVolteo" class="btn btn-sm btn-secondary" type="button" style="margin: 0 5px;">+</button>
                                    </div>
                                    <button id="solicitarButtonVolteo" class="btn btn-primary mt-1" style="width: 85px; margin-top: 5px;">Solicitar</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row justify-content-center" style="margin: 5px;"> 
            <div class="col-lg-6 col-md-6 col-sm-12 mb-4">
                <div class="card" style="height: 300px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);">
                    <div class="card-header" style="background-color: #4472C4;  height: 50px; border-radius: 15px;">
                        <span style="padding: 8px 10px; border-radius: 12px; display: inline-block; font-size: 18px;"></span>
                    </div>
                    <div class="card-body d-flex flex-column align-items-center justify-content-center">
                        <div id="progressCircle1" style="width: 125px; height: 125px; border-radius: 50%; background: #f0f0f0; position: relative;">
                            <div id="timerText1" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: 22px;">00:00</div>
                        </div>
                        <div class="button-container mt-4">
                            <button id="startButton1" class="btn btn-primary mr-2">Iniciar</button>
                            <button id="stopButton1" class="btn btn-danger">Detener</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-6 col-md-6 col-sm-12 mb-4">
                <div class="card" style="height: 300px; border-radius: 15px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);">
                    <div class="card-header" style="background-color: #4472C4;  height: 50px; border-radius: 15px;">
                        <span style="padding: 8px 10px; border-radius: 12px; display: inline-block; font-size: 18px;"></span>
                    </div>
                    <div class="card-body d-flex flex-column align-items-center justify-content-center">
                        <div id="progressCircle2" style="width: 125px; height: 125px; border-radius: 50%; background: #f0f0f0; position: relative;">
                            <div id="timerText2" style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); font-size: 22px;">00:00</div>
                        </div>
                        <div class="button-container mt-4">
                            <button id="startButton2" class="btn btn-primary mr-2">Iniciar</button>
                            <button id="stopButton2" class="btn btn-danger">Detener</button>
                        </div>
                    </div>
                </div>
            </div>

                        <div class="col-lg-6 col-md-6 col-sm-12 mb-4">
                <div class="card" style="height: 250px;">
                    <div class="card-header" style="background-color: #4472C4;">
                        <span style="padding: 8px 10px; border-radius: 12px; display: inline-block; font-size: 18px;"></span>
                    </div>
                    <div class="card-body d-flex flex-column align-items-left justify-content-left">
                        <h6 class="card-text text-left">Transaccion:   </h6>
                        <h6 class="card-text text-left">Fecha:         </h6>
                        <h6 class="card-text text-left">Motorista:     </h6>
                        <h6 class="card-text text-left">Ingenio:       </h6>
                        <h6 class="card-text text-left">Placa Remolque:</h6>
                        <h6 class="card-text text-left">Placa Camion:  </h6>
                    </div>
                </div>
            </div>  
            
            <div class="col-lg-6 col-md-6 col-sm-12 mb-4">
                <div class="card" style="height: 250px;">
                    <div class="card-header" style="background-color: #4472C4;">
                        <span style="padding: 8px 10px; border-radius: 12px; display: inline-block; font-size: 18px;"></span>
                    </div>
                    <div class="card-body d-flex flex-column align-items-left justify-content-left">
                        <h6 class="card-text text-left">Transaccion:   </h6>
                        <h6 class="card-text text-left">Fecha:         </h6>
                        <h6 class="card-text text-left">Motorista:     </h6>
                        <h6 class="card-text text-left">Ingenio:       </h6>
                        <h6 class="card-text text-left">Placa Remolque:</h6>
                        <h6 class="card-text text-left">Placa Camion:  </h6>
                    </div>
                </div>
            </div> 
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

    <script src="../src/js/jquery-3.4.1.js"></script>
    <script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
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
        var response = '<%= ViewState["ResponseBody"] %>';
        console.log("HOLA SI ESTOY LLEGANDO ACA: ", response)
        console.log(response); // Muestra la respuesta en la consola

        function filterCards() 
        {
            const input = document.getElementById('searchInput').value.toLowerCase();
            const cards = document.querySelectorAll('.card');
            
            cards.forEach(card => {
                const text = card.textContent.toLowerCase();
                card.style.display = text.includes(input) ? '' : 'none';
            });
        }
        
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
    
        const decreaseButtonPlano = document.getElementById('decreaseButtonPlano');
    const increaseButtonPlano = document.getElementById('increaseButtonPlano');
    const numberInputPlano = document.getElementById('numberInputPlano');

    decreaseButtonPlano.addEventListener('click', function() {
        let currentValue = parseInt(numberInputPlano.value);
        if (!isNaN(currentValue) && currentValue > 0) { // Evitar valores negativos
            numberInputPlano.value = currentValue - 1;
        }
    });

    increaseButtonPlano.addEventListener('click', function() {
        let currentValue = parseInt(numberInputPlano.value);
        if (!isNaN(currentValue)) {
            numberInputPlano.value = currentValue + 1;
        }
    });

    // Para el segundo conjunto de botones e input (volteo)
    const decreaseButtonVolteo = document.getElementById('decreaseButtonVolteo');
    const increaseButtonVolteo = document.getElementById('increaseButtonVolteo');
    const numberInputVolteo = document.getElementById('numberInputVolteo');

    decreaseButtonVolteo.addEventListener('click', function() {
        let currentValue = parseInt(numberInputVolteo.value);
        if (!isNaN(currentValue) && currentValue > 0) { // Evitar valores negativos
            numberInputVolteo.value = currentValue - 1;
        }
    });

    increaseButtonVolteo.addEventListener('click', function() {
        let currentValue = parseInt(numberInputVolteo.value);
        if (!isNaN(currentValue)) {
            numberInputVolteo.value = currentValue + 1;
        }
    });
    </script>

<script>
function createTimer(progressCircleId, timerTextId, startButtonId, stopButtonId, duration) {
    let progress = 0;
    let interval;
    let isRunning = false; // Estado para saber si el cronómetro está corriendo

    document.getElementById(startButtonId).addEventListener('click', function(event) {
        event.preventDefault(); // Previene el comportamiento predeterminado del botón
        if (!isRunning) { // Solo inicia si no está corriendo
            isRunning = true;
            interval = setInterval(() => {
                progress++;
                const angle = (progress / duration) * 360;
                document.getElementById(progressCircleId).style.background = `conic-gradient(${getColor(progress)} ${angle}deg, #f0f0f0 ${angle}deg)`;
                
                const minutes = String(Math.floor(progress / 60)).padStart(2, '0');
                const seconds = String(progress % 60).padStart(2, '0');
                document.getElementById(timerTextId).innerText = `${minutes}:${seconds}`;
            }, 1000);
        }
    });

    document.getElementById(stopButtonId).addEventListener('click', function(event) {
        event.preventDefault(); // Previene el comportamiento predeterminado del botón
        clearInterval(interval);
        isRunning = false; // Detiene el cronómetro y permite reiniciarlo
    });
}

function getColor(progress) 
{
    if (progress >= 600) // 10 minutos
    { 
        return '#e74c3c'; // Rojo
    } 
    else if (progress >= 300) // 5 minutos
    { 
        return '#f9e79f'; // Amarillo
    } 
    else 
    {
        return '#85c1e9'; // Celeste
    }
}

// Crear reloj 1
createTimer('progressCircle1', 'timerText1', 'startButton1', 'stopButton1', 600);

// Crear reloj 2
createTimer('progressCircle2', 'timerText2', 'startButton2', 'stopButton2', 600);
</script>


</body>
</html>