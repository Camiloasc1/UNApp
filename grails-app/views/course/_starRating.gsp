<ul ng-controller="StarRatingController" class="star-rating">
    <oauth:connected provider="google">
        <li class="star" ng-click="starRating(1)" id="1">&#9734;</li>
        <li class="star" ng-click="starRating(2)" id="2">&#9734;</li>
        <li class="star" ng-click="starRating(3)" id="3">&#9734;</li>
        <li class="star" ng-click="starRating(4)" id="4">&#9734;</li>
        <li class="star" ng-click="starRating(5)" id="5">&#9734;</li>
    </oauth:connected>
</ul>
<div class="col-xs-12 display-rating">
    Promedio de votación:
    <div class="star-prom-rating">
        <li class="star-prom" id="p1">&#9734;</li>
        <li class="star-prom" id="p2">&#9734;</li>
        <li class="star-prom" id="p3">&#9734;</li>
        <li class="star-prom" id="p4">&#9734;</li>
        <li class="star-prom" id="p5">&#9734;</li>
    </div>
</div>