$(document).ready(function()
{
	GetDate();
	GetItems();
	GetDate();
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
					template += '<form id="formDelete" onsubmit="return false;">';
					template += '<input type="text" name="itemId" value="' + val.id + '" style="display: none;">';
					template += '<button class="btn btn-light btn-sm" onclick="DeleteItem()">';
					template += '<i class="fas fa-trash-alt"></i>';
					template += '</button>';
					template += '</form>';
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

function GetDate()
{
	$.ajax({
		url: '/other/getDate/',
		type: 'POST',
		success: function(json)
		{
			var result = $.parseJSON(json);
			if (result.success == true)
			{
				$('input[name="date"]').val(result.date);
			}
		}
	});
}

function DeleteItem()
{
	$.ajax({
		url: '/other/deleteItem/',
		method: 'POST',
		data: $('#formDelete').serializeArray(),
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