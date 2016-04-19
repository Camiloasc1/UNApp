<div ng-controller="CommentFormController">
    <div class="jumbotron">
        <div class="row">
            <oauth:disconnected provider="google">
                <oauth:connect provider="google"
                               redirectUrl="${request.forwardURI.replace("/UNApp", "") + ((request.queryString) ? "?" + request.queryString : "")}">
                    <div class="col-xs-12">
                        <div class="text-center">
                            <button class="btn btn-raised btn-primary">
                                <i class="fa fa-google"></i> Ingresar con Google Para Comentar
                            </button>
                        </div>
                    </div>
                </oauth:connect>
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
                    </div>
                </form>
            </oauth:connected>
        </div>
    </div>
</div>