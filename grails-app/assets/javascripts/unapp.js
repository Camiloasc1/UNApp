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

function save_teacher(){
    document.getElementById("message-response").innerHTML = "... ...";
    var form = new FormData();
    var id = document.getElementById("id-course").value;
    var location = document.getElementById("location");
    location = location.options[location.selectedIndex].value;

    var code = document.getElementById("code").value;
    var name = document.getElementById("name").value;
    var typo = document.getElementById("typo").value;
    var descr = document.getElementById("descr").value;

    form.append("id", id );
    form.append("location", location );
    form.append("code", parseInt(code) );
    form.append("name", name );
    form.append("typo", typo );
    form.append("descr", descr );

    var teachers = document.getElementsByClassName("teacher-info");
    var id_teachers  = [];
    if( teachers.length > 0 ) {
        var json = '{"teachers": [';
        for (i = 0; i < teachers.length; i++) {
            json += '{ "value": '+teachers[i].id+'}';
            if( i < teachers.length -1 )
                json += ","
        }
        json += ']}';
        form.append( "teachers", json );
    }
    if (window.XMLHttpRequest) {
        // code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp=new XMLHttpRequest();
    } else {  // code for IE6, IE5
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.onreadystatechange=function() {
        if (xmlhttp.readyState==4 && xmlhttp.status==200) {
            if( xmlhttp.responseText == 1 )
                document.getElementById("message-response").innerHTML = "Se ha guardado correctamente";
            else
                document.getElementById("message-response").innerHTML = "Se ha presentado un error, intentalo de nuevo";
        }
    }
    xmlhttp.open("POST", "course/updateCourse", true);
    xmlhttp.send(form);
}
function erase_teacher( e ){
    var teacher = document.getElementById(e.target.parentNode.parentNode.id);
    document.getElementById("teacher-table").removeChild(teacher);
}
function appendToTable( id, name ){
    var td1 = document.createElement("td");
    var td2 = document.createElement("td");
    td1.innerHTML = name;
    td2.innerHTML = '<button type="button" class="btn btn-default" onclick="erase_teacher(event)">Borrar</button>';
    var tr = document.createElement("tr");
    tr.appendChild(td1);
    tr.appendChild(td2);
    tr.id = id;
    tr.className = "teacher-info";
    document.getElementById("teacher-table").appendChild(tr);
}

function showResult(str) {
    document.getElementById("livesearch").innerHTML="";
    document.getElementById("livesearch").style.border="0px";

    if (window.XMLHttpRequest) {
        // code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp=new XMLHttpRequest();
    } else {  // code for IE6, IE5
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.onreadystatechange=function() {
        if (xmlhttp.readyState==4 && xmlhttp.status==200) {
            var resp = JSON.parse(xmlhttp.responseText);
            for( i = 0; i < resp.length; i++ ){
                var div = document.createElement("div");

                (function(id, name) {
                    div.onclick = function() {
                        appendToTable( id, name );
                    };
                })(resp[i].id, resp[i].name);

                div.innerHTML = resp[i].name;

                document.getElementById("livesearch").appendChild(div);
                document.getElementById("livesearch").style.border="1px solid #A5ACB2";
            }

        }
    }
    if( str.length >= 4 ) {
        xmlhttp.open("GET", "course/teacherSearch?teacher=" + str, true);
        xmlhttp.send();
    }
}

/* SEARCH BUTTON NAVBAR*/

function clickBarSearch(){
    if($('#search_nav').css("cursor") == "pointer"){
        $('#search_nav').css({
            "cursor" : "text",
            "width": "290px",
            "z-index": "1",
            "border-bottom": "1px solid #BBB"
        });
        $('#search_nav').focus();
    }else{
        $('#search_nav').css({
            "cursor" : "pointer",
            "width": "0",
            "z-index": "4",
            "border-bottom": "none"
        });
        if($('#search_nav').val() != "") {
            document.location.href="/UNApp/?search_nav="+$('#search_nav').val();

        }

    }

}

