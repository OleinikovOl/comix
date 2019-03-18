{% extends "/layouts/main.volt" %}
{% block content %}
<script src="/js/auth.js"></script>

<div class="container">
	<div class="row justify-content-sm-center mt-5">
		<form class="col-3" id="authForm" onsubmit="return false;">
			<div class="form-group">
				<label for="inputLoginAuth">Логин или email</label>
				<input type="login" class="form-control" name="login" id="inputLoginAuth" placeholder="example@example.ru" required="" autocomplete="off" autocorrect="off">
			</div>
			<div class="form-group">
				<label for="passwordAuth">Пароль</label>
				<input type="password" class="form-control" name="password" id="passwordAuth" placeholder="Пароль" required="" autocomplete="off" autocorrect="off">
			</div>
			<button class="btn btn-primary" id="authButton" onclick="SignIn()" data-toggle="popover" data-placement="left" data-content="Введены недействительные логин или пароль, либо вы не подтвердили email">Войти</button>
		</form>
		<span class="border-left"></span>
		<form class="col-3" id="registerForm" onsubmit="return false;">
			<div class="form-group">
				<label for="loginRegister">Логин</label>
				<input type="login" class="form-control" id="loginRegister" name="login" placeholder="Логин" data-toggle="popover" data-placement="right" data-content="Этот логин занят" required="" autocomplete="off" autocorrect="off">
			</div>
			<div class="form-group">
				<label for="emailRegister">Email</label>
				<input type="email" class="form-control" id="emailRegister" name="email" aria-describedby="emailHelp" placeholder="examle@example.ru" autocomplete="off" autocorrect="off" data-toggle="popover" data-placement="right" data-content="Этот email уже зарегестрирован" required="">
			</div>
			<div class="form-group">
				<label for="passwordRegister">Пароль</label>
				<input type="password" class="form-control" id="passwordRegister" name="password" placeholder="Пароль" required="" autocomplete="off" autocorrect="off">
			</div>
			<div class="form-group">
				<label for="rePasswordRegister">Повторите пароль</label>
				<input type="password" class="form-control" id="rePasswordRegister" name="rePassword" placeholder="Повторите пароль" data-toggle="popover" data-placement="right" data-content="Пароли не равны" required="" autocomplete="off" autocorrect="off">
			</div>
			<div class="form-group">
				<label for="secretKey">Секретный ключ (если есть)</label>
				<input type="text" class="form-control" id="secretKey" name="secretKey" placeholder="Повторите пароль" autocomplete="off" autocorrect="off">
			</div>
			<button class="btn btn-primary" onclick="Register()">Зарегестрироваться</button>
		</form>
	</div>
</div>
{% endblock %}