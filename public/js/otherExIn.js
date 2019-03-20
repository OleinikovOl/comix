$(document).ready(function()
{
	GetItems();
});

function GetItems()
{
	$.ajax({
		url: '/other/getItems/',
		method: 'POST',
		success: function(json)
		{
			var result = $.parseJSON(json);
			if (result.success == true)
			{
				$('#table').html('')
				$.each(result.items, function(index, val) {
					var template = '<tr>';
					template += '<td align="left">'+ val.name + '</td>';
					template += '<td align="center">' + val.expend + '₽</td>';
					template += '<td align="center">' + val.income + '₽</td>';
					template += '<td style="padding: 8px;">';
					template += '<button class="btn btn-light btn-sm" onclick="DeleteItem('+ val.id + ')">';
					template += '<i class="fas fa-trash-alt"></i>';
					template += '</button>';
					template += '</td>';
					template += '</tr>';
					$('#table').append(template);
				});
				$('input[name="name"]').val('');
				$('input[name="col"]').val('');
			}

		}
	});
}

function DeleteItem(id)
{
	$.ajax({
		url: '/other/deleteItem/',
		method: 'POST',
		data: { id: id },
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

function OtherEx()
{
	$.ajax({
		url: '/other/expend/',
		method: 'POST',
		data: $('#formEx').serializeArray(),
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

function OtherIn()
{
	$.ajax({
		url: '/other/income/',
		method: 'POST',
		data: $('#formIn').serializeArray(),
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