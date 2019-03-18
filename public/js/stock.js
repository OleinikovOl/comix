$(document).ready(function()
{
	GetItems();
});

function GetItems()
{
	$.ajax({
		url: '/index/getItems/',
		method: 'GET',
		success: function(json)
		{
			var result = $.parseJSON(json),
				template = '';
			if (result.success == true)
			{
				$('tbody').html('');
				$.each(result.items, function(index, val)
				{
					template = '<tr>';
					template += '<th scope="row" align="center">' + val.id + '</th>'
					template += '<td align="left">' + val.name + '</td>'
					template += '<td align="center">' + val.opt + '₽</td>'
					template += '<td align="center">' + val.rozn + '₽</td>'
					template += '<td align="center">' + val.col + '</td>'
					template += '<td align="center">' + val.date + '</td>'
					template += '<td style="padding: 8px;">'
					template += '<button class="btn btn-light btn-sm" onclick="DeleteItem(' + val.id + ')">'
					template += '<i class="fas fa-trash-alt"></i>'
					template += '</button>'
					template += '</td>'
					template += '</tr>'
					$('tbody').append(template);
				});
			}
		}
	});
}

function DeleteItem(id)
{
	$.ajax({
		url: '/index/deleteItem/',
		method: 'POST',
		data: {id: id},
		success: function(json)
		{
			var result = $.parseJSON(json);
			if (result.success == true)
			{
				GetItems();
			}
		}
	});
}

function Search() {
	$.ajax({
		url: '/index/search/',
		method: 'POST',
		data: $('#searchForm').serializeArray(),
		success: function(json)
		{
			var result = $.parseJSON(json),
				template = '';
			if (result.success == true)
			{
				$('tbody').html('');
				$.each(result.items, function(index, val)
				{
					template = '<tr>';
					template += '<th scope="row" align="center">' + val.id + '</th>'
					template += '<td align="left">' + val.name + '</td>'
					template += '<td align="center">' + val.opt + '₽</td>'
					template += '<td align="center">' + val.rozn + '₽</td>'
					template += '<td align="center">' + val.col + '</td>'
					template += '<td align="center">' + val.date + '</td>'
					template += '<td style="padding: 8px;">'
					template += '<button class="btn btn-light btn-sm" onclick="DeleteItem(' + val.id + ')">'
					template += '<i class="fas fa-trash-alt"></i>'
					template += '</button>'
					template += '</td>'
					template += '</tr>'
					$('tbody').append(template);
				});
			}
		}
	});
}