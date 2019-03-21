$(document).ready(function()
{
	GetDate();
	GetItems();
});

function GetItems()
{
	$.ajax({
		url: '/sold/getItems/',
		method: 'POST',
		data: $('#dateForm').serializeArray(),
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
				$.each(result.items, function(index, val)
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
					template += '<input type="hidden" id="itemDateId-' + val.stock_id + '" value="' + val.date + '">';
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

				$('#bodyOther').html('');
				$.each(result.other, function(index, val)
				{
					template = '<tr>';
					template += '<th scope="row">' + val.name + '</th>';
					template += '<td align="center">' + val.expend + '₽</td>';
					template += '<td align="center">' + val.income + '₽</td>';
					template += '</tr>';
					$('#bodyOther').append(template);
				});

				const monthRus = [
					'Январь',
					'Февраль',
					'Март',
					'Апрель',
					'Май',
					'Июнь',
					'Июль',
					'Август',
					'Сентябрь',
					'Октябрь',
					'Ноябрь',
					'Декабрь'
				];
				$('#bodyYear').html('');
				for (var i = 0; i <= 11; i++) {
					template = '<tr>';
					template += '<td scope="row">' + monthRus[i] + '</th>';
					template += '<td align="center">' + result['monthSold']['opt'][i + 1] + '₽</td>';
					template += '<td align="center">' + result['monthSold']['rozn'][i + 1] + '₽</td>';
					template += '<td align="center">' + (result['monthSold']['rozn'][i + 1] - result['monthSold']['opt'][i + 1]) + '₽</td>';
					template += '</tr>';
					$('#bodyYear').append(template);
				}
			}
		}
	});

}
function DeleteItem(id)
{
	$.ajax({
		url: '/sold/deleteItem/',
		method: 'POST',
		data: {id: id, date: $('#itemDateId-' + id).val()},
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