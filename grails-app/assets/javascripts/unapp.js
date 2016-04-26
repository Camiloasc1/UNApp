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

//onmouseover="document.getElementById('star-1').className = 'glyphicon glyphicon-star'"