$(document).ready(function()
{
	GetItems();
});

function GetItems()
{
	$.ajax({
		url: '/index/getItems/',
		method: 'POST',
		success: function(json)
		{
			var result = $.parseJSON(json),
				template = '';
			if (result.success == true)
			{
				$('tbody').html('');
				$('#db').html('');
				if (result.admin == 1)
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
						template = '<option value="' + val.name + '"></option>'
						$('#db').append(template);
					});
				else
					$.each(result.items, function(index, val)
					{
						template = '<tr>';
						template += '<th scope="row" align="center">' + val.id + '</th>'
						template += '<td align="left">' + val.name + '</td>'
						template += '<td align="center">' + val.rozn + '₽</td>'
						template += '<td align="center">' + val.col + '</td>'
						template += '<td align="center">' + val.date + '</td>'
						template += '</tr>'
						$('tbody').append(template);
						template = '<option value="' + val.name + '"></option>'
						$('#db').append(template);
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

function Search()
{
	$.ajax({
		url: '/index/search/',
		method: 'GET',
		data: $('#searchForm').serializeArray(),
		success: function(json)
		{
			var result = $.parseJSON(json),
				template = '';
			if (result.success == true)
			{
				$('tbody').html('');
				if (result.admin == 1)
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
				else
					$.each(result.items, function(index, val)
					{
						template = '<tr>';
						template += '<th scope="row" align="center">' + val.id + '</th>'
						template += '<td align="left">' + val.name + '</td>'
						template += '<td align="center">' + val.rozn + '₽</td>'
						template += '<td align="center">' + val.col + '</td>'
						template += '<td align="center">' + val.date + '</td>'
						template += '</tr>'
						$('tbody').append(template);
					});
			}
		}
	});
}

function Arrival()
{
	$.ajax({
		url: '/index/arrival/',
		method: 'POST',
		data: $('#arrivalForm').serializeArray(),
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