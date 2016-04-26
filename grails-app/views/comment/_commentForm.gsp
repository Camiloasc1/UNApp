<div ng-controller="CommentFormController">
    <div class="row">
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
    </div>
</div>