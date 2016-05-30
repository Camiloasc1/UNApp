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

