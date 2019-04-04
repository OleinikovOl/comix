function Register()
{
	var	passwordRegister   = $('#passwordRegister'),
		rePasswordRegister = $('#rePasswordRegister'),
		loginRegister      = $('#loginRegister'),
		emailRegister      = $('#emailRegister'),
		secretKey          = $('#secretKey');

	if(rePasswordRegister.val() !== passwordRegister.val())
	{
		rePasswordRegister.popover('show');
	}
	else
	{
		$.ajax({
			url: '/auth/register/',
			method: 'POST',
			data: $('#registerForm').serializeArray(),
			success: function(json)
			{
				loginRegister.popover('hide');
				emailRegister.popover('hide');
				rePasswordRegister.popover('hide');
				var result = $.parseJSON(json);
				if (result.success === true)
				{
					alert('Перейдите по ссылке, которую мы прислали вам на электронную почту!');
				}
				if (result.message === 'login is exists')
				{
					loginRegister.popover('show');
				}
				if (result.message === 'email is exists')
				{
					emailRegister.popover('show');
				}
			}
		});
	};
};

function SignIn()
{
	$.ajax({
		url: '/auth/signIn/',
		method: 'POST',
		data: $('#authForm').serializeArray(),
		success: function(json)
		{
			var result = $.parseJSON(json);
			if (result.success === false)
			{
				if (result.message == 'no user')
					$('#authButton').popover('show');
			}
			else if (result.success === true)
			{
				document.location.href = '/';
			}
		}
	});
};