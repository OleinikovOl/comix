function Register() {
	var	passwordRegister   = $('#passwordRegister'),
		rePasswordRegister = $('#rePasswordRegister'),
		loginRegister      = $('#loginRegister'),
		emailRegister      = $('#emailRegister'),
		secretKey = $('#secretKey');

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
				var result = $.parseJSON(json);
				if (result.success === true)
				{
					loginRegister.popover('hide');
					emailRegister.popover('hide');
					rePasswordRegister.popover('hide');
					alert('Перейдите по ссылке, которую мы прислали вам на электронную почту!');
				}
				else if (result.success === false && result.message == 'login is exists')
				{
					loginRegister.popover('show');
				}
				else if (result.success === false && result.message == 'email is exists')
				{
					emailRegister.popover('show');
				}
			}
		});
	};
};

function SignIn()
{
	var password = $('#passwordAuth'),
		login    = $('#loginAuth');

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
					$('#authForm').popover('show');
			}
			else
			{
				document.location.href = '/';
			}
		}
	});
};

function LogOut()
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