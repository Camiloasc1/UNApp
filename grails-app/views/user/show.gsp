<html>
<head>
	<meta name="layout" content="main"/>
</head>

<body>
<div ng-app="SearchApp" ng-controller="SearchController" class="container ">
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
		</div>
		<div class="col-lg-7">
			<div class="jumbotron">
				<div class="row">
					<h2 style="text-align: center"> Mis comentarios </h2>
				</div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-lg-5">
			<div class="jumbotron">
				<h4>Buscar usuarios:</h4>
				<form ng-submit="search()">
					<div class="input-group">
						<input type="text" class="form-control input-lg"
							   placeholder="Ingresa el nombre ..."
							   ng-model="query"/>
						<span class="input-group-btn">
							<button type="button" class="btn btn-info btn-lg" ng-click="search()">
								<i class="glyphicon glyphicon-search"></i>
							</button>
						</span>
					</div>
				</form>
				<table class="table table-striped table-hover">
					<thead>
					<tr>
						<th>Nombre</th>
					</tr>
					</thead>
					<tbody>
					<tr ng-repeat="user in users" class="clickable-element"
						ng-click="showUser(user.id)">
						<td>{{user.name}}</td>
						<td><img src="{{user.picture}}"  height="40" width="40" ></td>
					</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
</body>
</html>