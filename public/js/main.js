/**
 * Заполнение инпутов сегодняшней датой
 */
function GetDate()
{
	$.ajax({
		url: '/index/getDate/',
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

/**
 * Выход из профиля
 */
function Logout()
{
	$.ajax({
		url: '/auth/logOut/',
		method: 'POST',
		data: '',
		success: function()
		{
			document.location.replace('/');
		}
	});
};