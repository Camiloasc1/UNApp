<div ng-controller="CommentFormController">
    <div class="jumbotron">
        <div class="row">
            <oauth:disconnected provider="google">
                <div class="col-xs-12">
                    <div class="text-center">
                        <oauth:connect provider="google"
                                       redirectUrl="${request.forwardURI.replace("/UNApp", "") + ((request.queryString) ? "?" + request.queryString : "")}">
                            <button class="btn btn-raised btn-primary">
                                <i class="fa fa-google"></i> Ingresar con Google Para Comentar
                            </button>
                        </oauth:connect>
                    </div>
                </div>
            </oauth:disconnected>
            <oauth:connected provider="google">
                <form id="comment-form">
                    <div class="col-lg-9 col-md-8">
                        <div class="form-group">
                            <textarea name="body" id="commentBody" rows="5" class="form-control"
                                      ng-model="commentBody"></textarea>
                        </div>
                    </div>

                    <div class="col-lg-3 col-md-4">
                        <button class="btn btn-default btn-raised btn-block" type="button"
                                ng-click="postComment()">Comentar</button>

                        <div class="text-center" ng-show="loading">
                            <br/>
                            <i class="fa fa-spinner fa-pulse fa-5x"></i>
                            <span class="sr-only">Cargando...</span>
                        </div>
                    </div>
                </form>
            </oauth:connected>
        </div>
    </div>
</div>