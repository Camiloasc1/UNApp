<div ng-controller="CommentsController">
    <div class="jumbotron">
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
                            <strong class="username-comment" style="float: left"><a href="${request.contextPath}/user/show?id={{comment.author.id}}">{{comment.author.name}}</a></strong>
                            <span class="text-muted date-comment">{{comment.date}}</span>
                            <div ng-if="context=='Course' && comment.teacher.id"
                                 class="link-profesor" >
                                en: <a href="${request.contextPath}/teacher/show?id={{comment.teacher.id}}">{{comment.teacher.name}}</a>
                            </div>

                            <div ng-if="context=='Teacher' && comment.course.id"
                                 class="link-profesor" >
                                en: <a href="${request.contextPath}/course/show?id={{comment.course.id}}">{{comment.course.name}}</a>
                            </div>
                            <div class="voting-container">
                                <oauth:connected provider="google">
                                    <div ng-switch on="comment.voted" class="ng-switch-container">
                                        <div ng-switch-when="1">
                                            <i class="material-icons positive-vote clickable-element select-upvote"
                                               ng-click="voteUp(comment.id, $index)">thumb_up</i>
                                        </div>

                                        <div ng-switch-default>
                                            <i class="material-icons positive-vote clickable-element"
                                               ng-click="voteUp(comment.id, $index)">thumb_up</i>
                                        </div>
                                    </div>
                                </oauth:connected>
                                <oauth:disconnected provider="google">
                                    <i class="material-icons positive-vote non-clickable-element">thumb_up</i>
                                </oauth:disconnected>
                                <div class="content-positive-vote">
                                    {{comment.positiveVotes}}
                                </div>
                                <oauth:connected provider="google">
                                    <div ng-switch on="comment.voted" class="ng-switch-container">
                                        <div ng-switch-when="-1">
                                            <i class="material-icons negative-vote clickable-element select-dwnvote"
                                               ng-click="voteDown(comment.id, $index)">thumb_down</i>
                                        </div>

                                        <div ng-switch-default>
                                            <i class="material-icons negative-vote clickable-element"
                                               ng-click="voteDown(comment.id, $index)">thumb_down</i>
                                        </div>
                                    </div>
                                </oauth:connected>
                                <oauth:disconnected provider="google">
                                    <i class="material-icons negative-vote non-clickable-element">thumb_down</i>
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