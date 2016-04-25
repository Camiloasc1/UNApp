<div ng-controller="CommentFormController">
    <div class="jumbotron">
        <div class="row">
            <oauth:disconnected provider="google">
                <oauth:connect provider="google"
                               redirectUrl="${request.forwardURI.replace("/UNApp", "") + ((request.queryString) ? "?" + request.queryString : "")}">
                    <div class="col-xs-12">
                        <div class="text-center">
                            <button class="btn btn-raised btn-primary login-comment">
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
                                      ng-model="commentBody" placeholder="Aquí puedes hacer tu comentario... "></textarea>
                        </div>
                    </div>

                    <div class="col-lg-3 col-md-4">
                        <div class="form-group">
                            <label for="sel1">Asociar un profesor al comentario:</label>
                            <select class="form-control select-teacher" ng-model="teacher" ng-change="showSelect(teacher)" id="sel1" ng-init="teacher=NINGUNO">
                                <option value="" selected>NINGUNO</option>
                                <g:each in="${result.teachers}" status="i" var="teacher">
                                    <option value="${teacher.id}">${teacher.name}</option>
                                </g:each>
                            </select>
                        </div>
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