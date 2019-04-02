$(document).ready(function()
{
	GetItems();
});

function GetItems(page)
{
	// if (page = 'undefiend')
		var page = 1;
	$.ajax({
		url: '/index/getItems/',
		method: 'GET',
		data: {page: page},
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
						template += '<th scope="row" align="center">' + val + '</th>';
						template += '<td align="left">' + val.name + '</td>';
						template += '<td align="center">' + val.opt + '₽</td>';
						template += '<td align="center">' + val.rozn + '₽</td>';
						template += '<td align="center">' + val.col + '</td>';
						template += '<td align="center">' + val.date + '</td>';
						template += '<td style="padding: 8px;">';
						template += '<button class="btn btn-light btn-sm" onclick="">';
						template += '<i class="fas fa-edit"></i>';
						template += '</button>';
						template += '<button class="btn btn-light btn-sm" onclick="DeleteItem(' + val.id + ')">';
						template += '<i class="fas fa-trash-alt"></i>';
						template += '</button>';
						template += '</td>';
						template += '</tr>';
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
				// Pagination
				$('.pagination').html('');
				if (result.total != 1)
				{
					template = '';
					if (result.current != 1)
					{
						template += '<li class="page-item"><a href="" class="page-link" onclick="GetItems(' + result.before + ')">Предыдущая</a></li>';
						if (result.current != 2)
		    			{
							template += '<li class="page-item"><a class="page-link" href="" onclick="GetItems(1)">1</a></li>';
							template += '<li class="page-item"><span class="page-link">. . .</span></li>'
						}
						else if (result.current == 1)
						{
							template += '<li class="page-item active"><span class="page-link" href="">1</span></li>';
						}
					}
					else
					{
						template += '';
					}
					$('.pagination').html(template);
				}
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
	$('input').val('');
}