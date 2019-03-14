function Register() {
	var	passwordRegister = $('#passwordRegister');
		rePasswordRegister = $('#rePasswordRegister');
		loginRegister = $('#loginRegister');
		emailRegister = $('#emailRegister');
		secretKey = $('#secretKey');
	if(rePasswordRegister.val() !== passwordRegister.val())
	{
		rePasswordRegister.popover('show');
	}
	else
	{
		var $data = $('#registerForm').serializeArray();
		$.ajax({
			url: '/auth/register/',
			method: 'POST',
			data: $data,
			success: function(result){
				if (result['success'] == true)
				{
					alert('Перейдите по ссылке, которую мы прислали вам на электронную почту!');
				}
				else if (result['success'] == false && result['message'] == 'login is exists')
				{
					loginRegister.popover('show');
				}
				else if (result['success'] == false && result['message'] == 'email is exists')
				{
					emailRegister.popover('show');
				}
			}
		});
	}

};