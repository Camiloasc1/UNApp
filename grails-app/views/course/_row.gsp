<tr onclick="window.location = '${request.contextPath}/subject/index?id=${it.id}' ">
    <td><a href="${request.contextPath}/subject/index?id=${it.id}">${it.code}</a></td>
    <td><a href="${request.contextPath}/subject/index?id=${it.id}">${it.name}</a></td>
    <td>${it.credits}</td>
</tr>