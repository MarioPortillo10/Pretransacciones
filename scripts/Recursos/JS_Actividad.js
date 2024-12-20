var data_actividades;
var data_actividades_detalles;
$(document).ready(function () {

    data_actividades = $('#tbl_actividades2').DataTable({

        processing: true,
        responsive: true,


        language: {
            sProcessing: "Procesando...",
            sLengthMenu: "Mostrar _MENU_ registros",
            sZeroRecords: "No se encontraron resultados",
            sEmptyTable: "No se Encontraron resultados ",
            sInfo: "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
            sInfoEmpty: "Mostrando registros del 0 al 0 de un total de 0 registros",
            sInfoFiltered: "(filtrado de un total de _MAX_ registros)",
            sInfoPostFix: "",
            sSearch: "Buscar:",
            sUrl: "",
            sInfoThousands: ",",
            sLoadingRecords: "Cargando...",
            oPaginate: {
                sFirst: "Primero",
                sLast: "Último",
                sNext: "Siguiente",
                sPrevious: "Anterior"
            }
        },

        ajax: {
            type: "POST",
            url: "Rutas_Actividades.aspx/getactividades",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: function (d) {
                d.codigo = "0";
                return JSON.stringify(d);
            },
            dataSrc: "d.data"
        },
        columns: [
            { data: "codigo", name: "codigo", autoWidth: true },
            { data: "descripcion", name: "descripcion", autoWidth: true },
            {
                data: null, render: function (data, type, full) {

                 return '<a  href="#" id="EditModal" onclick="detalle_Actividad(' + full.codigo + ')"><i class="fas fa-pencil-alt"></i></a> ';
                }
            }

        ]

    });

});





function detalle_Actividad(Code) {



    var obj = {};
    obj.codigo = Code;

    $.ajax({
        type: "POST",
        url: "Rutas_Actividades.aspx/getactividades_detalle",
        data: JSON.stringify(obj),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data) {

        },
    });
}


