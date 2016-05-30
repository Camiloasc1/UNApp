var star = { "selected" : false };

$('.star').mouseenter(function(){

    if(star.selected === false){
        fill_stars(this.id, "in");
    }

});

$('.star').mouseleave(function(){

    if(star.selected === false){
        fill_stars(this.id, "out");
    }

});

$('.star').click(function(){

    fill_stars(5, "out");
    fill_stars(this.id, "in");
    star.selected = true;
    star.id = this.id;

});


function fill_stars(num, direction){
    if(direction === "in"){
        for(i=0; i <= parseInt(num); i++){
            $("#" + i).html('&#9733;');
        }
    } else {
        for(i=0; i <= parseInt(num); i++){
            $("#" + i).html('&#9734;');;
        }
    }
}

function fill_stars_voted( num ){
    for(i=0; i <= parseInt(num); i++){
        $("#" + i).html('&#9733;');
    }
    star.selected = true;
    star.id = num;
}

function fill_stars_median( num ){
    $(".star-prom").html('&#9734;');
    for(i=0; i <= parseInt(num); i++){
        $("#p" + i).html('&#9733;');
    }
}
/*

function onAdvanceSearch(){
    if( $( "#advanceSearch" ).hasClass( "onAdvanceSearch" ) ) {
        $("#advanceSearch").removeClass("onAdvanceSearch");
    }else{
        $("#advanceSearch").addClass("onAdvanceSearch");
    }
}
*/
function selectVote(el){
    if($(el).hasClass("positive-vote")){
        document.getElementById("t_up").click();
        if($(el).next().hasClass("select-negative-vote")){
            $(el).next().removeClass("select-negative-vote");
        }
        if($(el).hasClass("select-positive-vote")){
            $(el).removeClass("select-positive-vote");
        }else{
            $(el).addClass("select-positive-vote");
        }

    }else if($(el).hasClass("negative-vote")){
        document.getElementById("t_dwn").click();
        if($(el).prev().hasClass("select-positive-vote")){
            $(el).prev().removeClass("select-positive-vote");
        }
        if($(el).hasClass("select-negative-vote")){
            $(el).removeClass("select-negative-vote");
        }else{
            $(el).addClass("select-negative-vote");
        }
    }
}

function AdvanceSearch(el){
    if($(el).hasClass("advanceSearchClicked")) {
        $(el).removeClass("advanceSearchClicked");
        $(el).children(".glyphicon").removeClass("glyphicon-menu-up");
        $(el).children(".glyphicon").addClass("glyphicon-menu-down");
        $("#advanceOption").hide();
    }else{
        $(el).addClass("advanceSearchClicked");
        $(el).children(".glyphicon").removeClass("glyphicon-menu-down");
        $(el).children(".glyphicon").addClass("glyphicon-menu-up");
        $("#advanceOption").show();
        $('#select-date').focus();
    }
}

$(document).ready(function() {
    $('#sel-materias').multiselect();
    $('#select-date').multiselect();
});

function createDate(){

    if(document.getElementById('select-date').value == 6){
        document.getElementById('fecha-desde').innerHTML = '<p> Desde: &nbsp <input type="text" id="datepicker-desde"></p>';
        document.getElementById('fecha-hasta').innerHTML = '<p> Hasta: &nbsp <input type="text" id="datepicker-hasta"></p>';
        setCalendar();
        $(document).scrollTop($("#fecha-desde").offset().top);
        $(document).scrollTop($("#fecha-hasta").offset().top);
    }else{
        document.getElementById("fecha-desde").innerHTML = "";
        document.getElementById("fecha-hasta").innerHTML = "";
    }

}

$(function() {
    $("#calendario").datepicker();
});
function setCalendar(){
    $.datepicker.regional['es'] = {
        closeText: 'Cerrar',
        prevText: '<Ant',
        nextText: 'Sig>',
        currentText: 'Hoy',
        monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
        monthNamesShort: ['Ene','Feb','Mar','Abr', 'May','Jun','Jul','Ago','Sep', 'Oct','Nov','Dic'],
        dayNames: ['Domingo', 'Lunes', 'Martes', 'Miercoles', 'Jueves', 'Viernes', 'Sabado'],
        dayNamesShort: ['Dom','Lun','Mar','Mie','Juv','Vie','Sab'],
        dayNamesMin: ['Do','Lu','Ma','Mi','Ju','Vi','Sa'],
        weekHeader: 'Sm',
        dateFormat: 'dd/mm/yy',
        firstDay: 1,
        isRTL: false,
        showMonthAfterYear: false,
        yearSuffix: ''
    };
    $.datepicker.setDefaults($.datepicker.regional['es']);
    $(function () {
        $("#datepicker-desde").datepicker();
        $("#datepicker-hasta").datepicker();
    });
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth()+1; //January is 0!

    var yyyy = today.getFullYear();
    if(dd<10){
        dd='0'+dd
    }
    if(mm<10){
        mm='0'+mm
    }
    var today = dd+'/'+mm+'/'+yyyy;
    document.getElementById("datepicker-desde").value = today;
    document.getElementById("datepicker-hasta").value = today;

}