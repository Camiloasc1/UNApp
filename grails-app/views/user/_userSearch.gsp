<div ng-controller="SearchController">
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