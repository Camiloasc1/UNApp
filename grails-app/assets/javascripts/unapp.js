$(function () {
    $("#navbar").load("_navbar.html");
    $("#footer").load("_footer.html");
});

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
    $('.display-rating').text("Tu voto fue de: " + this.id + " estrellas.").css("display","inline");

});

function fill_stars(num, direction){

    if(direction === "in"){
        for(i=0; i <= parseInt(num); i++){
            $("#" + i).html('★');
        }
    } else {
        for(i=0; i <= parseInt(num); i++){
            $("#" + i).html('☆');
        }
    }

}

//onmouseover="document.getElementById('star-1').className = 'glyphicon glyphicon-star'"