$(document).ready(function() {
	GetDate();
});
/**
 * Заполнение инпутов сегодняшней датой
 */
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