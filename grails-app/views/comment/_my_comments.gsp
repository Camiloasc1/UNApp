<div ng-controller="MyCommentsController">
    <div class="jumbotron">
        <h2 style="text-align: center"> Mis comentarios </h2>
        <div ng-repeat="comment in comments">
            <div class="row">
                <div class="col-xs-1">
                    <div class="thumbnail">
                        <img class="img-responsive user-photo" ng-src="{{comment.picture}}">
                    </div>
                </div>

                <div class="col-xs-11">
                    <div class="panel panel-default">
                        <div class="panel-heading info-comment">
                            <strong class="username-comment" style="float: left">{{comment.author.name}}</strong>
                            <span class="text-muted date-comment">{{comment.date}}</span>
                            <div class="voting-container">
                                <div class="content-positive-vote">
                                    <i class="material-icons positive-vote non-clickable-element">thumb_up</i>
                                    {{comment.positiveVotes}}
                                </div>
                                <div class="content-negative-vote">
                                    <i class="material-icons negative-vote non-clickable-element">thumb_down</i>
                                    {{comment.negativeVotes}}
                                </div>
                            </div>
                        </div>

                        <div class="panel-body">
                            {{comment.body}}
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12">
                <div class="text-center">
                    <div ng-show="loading">
                        <i class="fa fa-spinner fa-pulse fa-5x"></i>
                        <span class="sr-only">Cargando...</span>
                    </div>
                    <button class="btn btn-deafult btn-raised" type="button" ng-click="loadMore()">Ver Mas</button>
                </div>
            </div>
        </div>
    </div>
</div>