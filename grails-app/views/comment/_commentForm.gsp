<div ng-controller="CommentFormController">
    <div class="row">
        <form id="comment-form">
            <div class="col-lg-9 col-md-8">
                <div class="form-group">
                    <textarea name="body" id="commentBody" rows="5" class="form-control"
                              ng-model="commentBody" placeholder="Aquí puedes hacer tu comentario... "></textarea>
                </div>
            </div>

            <div class="col-lg-3 col-md-4">
                <div class="form-group">
                    <g:if test="${request.forwardURI.toLowerCase().find("course")}">
                        <label for="sel1"> Asociar un profesor al comentario:</label>
                        <select class="form-control select-teacher" ng-model="item" ng-change="showSelect(item)" id="sel1" ng-init="item=NINGUNO">
                            <option value="" selected>NINGUNO</option>
                            <g:each in="${result.teachers}" status="i" var="teacher">
                                <option value="${teacher.id}">${teacher.name}</option>
                            </g:each>
                        </select>
                    </g:if>
                    <g:if test="${request.forwardURI.toLowerCase().find("teacher")}">
                        <label for="sel1"> Asociar una materia al comentario:</label>
                        <select class="form-control select-teacher" ng-model="item" ng-change="showSelect(item)" id="sel1" ng-init="item=NINGUNO">
                            <option value="" selected>NINGUNO</option>
                            <g:each in="${result.courses}" status="i" var="course">
                                <option value="${course.id}">${course.name}</option>
                            </g:each>
                        </select>
                    </g:if>
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
    </div>
</div>