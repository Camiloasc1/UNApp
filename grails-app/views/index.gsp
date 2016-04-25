<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
</head>

<body>
<div class="index-background">
    <div ng-app="SearchApp" ng-controller="SearchController" class="container">
        <div class="row window_search">
            <div id="custom-search-input" class="col-xs-12 col-sm-8 col-sm-offset-2 col-lg-6 col-lg-offset-3">
                <img class="img-responsive search-logo center-block" src="${assetPath(src: 'search_logo.png')}" alt="">

                <form>
                    <div class="input-group">
                        <input type="text" class="form-control input-lg" placeholder="Buscar un profesor o materia"
                               ng-model="query"/>
                        <span class="input-group-btn">
                            <button type="button" class="btn btn-info btn-lg" ng-click="search()">
                                <i class="glyphicon glyphicon-search"></i>
                            </button>
                        </span>
                    </div>
                </form>
            </div>
        </div>

        <div class="row">
            <div ng-repeat="course in courses" class="col-md-6">
            </div>

            <div ng-repeat="teacher in teachers" class="col-md-6">
            </div>
        </div>
    </div>
</div>
</body>
</html>
