$(document).ready(function()
{
	GetDate();
	GetItems();
});

function GetItems()
{
	$.ajax({
		url: '/expend/getItems/',
		method: 'POST',
		success: function(json)
		{
			var result = $.parseJSON(json),
				template = '';
			$('#body').html('');
			if (result.success == true)
			{
				var sumOpt = 0,
					sumRozn = 0,
					sumCol = 0,
					date = 0;
				$.each(result.itemsSold, function(index, val)
				{
					sumOpt   += val.opt * val.col;
					sumRozn  += val.rozn * val.col;
					sumCol   += +val.col;
					template = '<tr>';
					template += '<th scope="row" align="center">' + val.stock_id + '</th>';
					template += '<td align="left">' + val.name + '</td>';
					template += '<td align="center">' + val.opt + '₽×' + val.col + '=' + (val.opt * val.col) + '₽</td>';
					template += '<td align="center">' + val.rozn + '₽×' + val.col + '=' + (val.rozn * val.col) + '₽</td>';
					template += '<td align="center">' + val.col + '</td>';
					template += '<td style="padding: 8px;">';
					template += '<button class="btn btn-light btn-sm" onclick="DeleteItem(' + val.stock_id + ')">';
					template += '<i class="fas fa-trash-alt"></i>';
					template += '</button>';
					template += '</td>';
					template += '</tr>';
					$('#body').append(template);
				});
				$('#sumOpt').html(sumOpt + '₽');
				$('#sumRozn').html(sumRozn + '₽');
				$('#sumCol').html(sumCol);
				$('#clearIncome').html((sumRozn - sumOpt) + '₽');

				$('#db').html('');
				$.each(result.itemsStock, function(index, val)
				{
					if (val.col > 0)
					{
						template = '<option value="' + val.name + '"></option>';
						$('#db').append(template);
					}
				});
				$('form input[name="name"], form input[name="col"]').val('');
			}
		}
	});
}

function DeleteItem(id)
{
	$.ajax({
		url: '/expend/deleteItem/',
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

function Sell()
{
	$.ajax({
		url: '/expend/sell/',
		method: 'POST',
		data: $('#sellForm').serializeArray(),
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