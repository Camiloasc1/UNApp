<html>
<head>
	<meta name="layout" content="main"/>
</head>

<body>
<div ng-app="SearchApp" class="container ">
	<div class="row">
		<div class="col-lg-5">
			<div class="jumbotron">
				<div class="row">
					<img src="${result.picture}" class=" circular center-block photo-size" height="250" width="250">
					<h2 class="text-center">${result.name}</h2>
					<h4 class="text-center">${result.email}</h4>
					<div class="col-xs-6">
						<h2 style="text-align: right"><i class="fa fa-thumbs-up"></i>${result.positiveVotes} </h2>
					</div>
					<div class="col-xs-6">
						<h2 style="text-align: left"><i class="fa fa-thumbs-down"></i>${result.negativeVotes}</h2>
					</div>
				</div>
			</div>
			<div class="jumbotron">
				<h4>Buscar usuarios:</h4>
				<g:render template="userSearch"/>
			</div>
		</div>


		<div class="col-lg-7">
			<g:render template="/comment/my_comments"/>
		</div>
	</div>
</div>
</body>
</html>