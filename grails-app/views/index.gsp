<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
</head>

<body>
<div class="index-background">
    <div class="container">
        <div class="row window_search">
            <div id="custom-search-input"  class="col-xs-12 col-sm-8 col-sm-offset-2 col-lg-6 col-lg-offset-3">
                <img class="img-responsive search-logo center-block" src="${assetPath(src: 'search_logo.png')}" alt="">

                <form method="get" action="course/search">
                    <div class="input-group">
                        <input style="color: #41AF8A" name="query" type="text" class="form-control input-lg"
                               placeholder="Buscar una materia"/>
                        <span class="input-group-btn">
                            <button class="btn btn-info btn-lg" type="submit">
                                <i class="glyphicon glyphicon-search"></i>
                            </button>
                        </span>
                    </div>
                </form>

                <form method="get" action="teacher/search">
                    <div class="input-group">
                        <input style="color: #41AF8A" name="query" type="text" class="form-control input-lg"
                               placeholder="Buscar un profesor"/>
                        <span class="input-group-btn">
                            <button class="btn btn-info btn-lg" type="submit">
                                <i class="glyphicon glyphicon-search"></i>
                            </button>
                        </span>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
