<g:each in = "${comments}" var = "c">
<div class = "comentario">
    <div class="col-sm-1">
        <div class="thumbnail">
            <img class="img-responsive user-photo" src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png">
        </div><!-- /thumbnail -->
    </div><!-- /col-sm-1 -->

    <div class="col-sm-11">
        <div class="panel panel-default">
            <div class="panel-heading">
                <strong>${c.author.name}</strong> <span class="text-muted">${c.date}</span>
            </div>
            <div class="panel-body">
                ${c.body}
            </div><!-- /panel-body -->
        </div><!-- /panel panel-default -->
    </div><!-- /sm-11 -->
</div>
</g:each>