<div ng-controller="CommentsController">
    <div class="jumbotron">
        <div ng-repeat="comment in comments">
            <div class="row">
                <div class="col-xs-1">
                    <div class="thumbnail">
                        <img class="img-responsive user-photo" src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png">
                    </div>
                </div>

                <div class="col-xs-11">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <strong>{{comment.author}}</strong>
                            <span class="text-muted">{{comment.date}}</span>

                            <div class="voting-container">
                                <oauth:connected provider="google">
                                    <i class="material-icons positive-vote"
                                       onclick="upVotes(event)">thumb_up</i>
                                </oauth:connected>
                                <oauth:disconnected provider="google">
                                    <i class="material-icons positive-vote">thumb_up</i>
                                </oauth:disconnected>
                                <div class="content-positive-vote">
                                    {{comment.positiveVotes}}
                                </div>
                                <oauth:connected provider="google">
                                    <i class="material-icons negative-vote"
                                       onclick="downVotes(event)">thumb_down</i>
                                </oauth:connected>
                                <oauth:disconnected provider="google">
                                    <i class="material-icons negative-vote">thumb_down</i>
                                </oauth:disconnected>
                                <div class="content-negative-vote">
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

        <div class="text-center" ng-show="loading">
            <i class="fa fa-spinner fa-pulse fa-5x"></i>
            <span class="sr-only">Cargando...</span>
        </div>

        <div class="row">
            <div class="col-xs-12">
                <div class="text-center">
                    <button class="btn btn-deafult btn-raised" type="button" ng-click="loadMore()">Ver Mas</button>
                </div>
            </div>
        </div>
    </div>
</div>