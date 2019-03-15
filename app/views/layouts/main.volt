<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>ComixShop</title>
	<link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script defer src="https://use.fontawesome.com/releases/v5.7.2/js/all.js" integrity="sha384-0pzryjIRos8mFBWMzSSZApWtPl/5++eIfzYmTgBBmXYdhvxPc+XcFEk+zJwDgWbP" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js" integrity="sha384-xrRywqdh3PHs8keKZN+8zzc5TX0GRTLCcmivcbNJWm2rs5C8PRhcEn3czEjhAO9o" crossorigin="anonymous"></script>
	<script src="/js/auth.js"></script>

	<header class="row justify-content-md-center">
		<nav class="navbar navbar-expand-lg navbar-light bg-light row" style="width: 97%;">
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav col">
					<li class="nav-item"><a class="nav-link" href="/">В наличии и поступление</a></li>
					{% if user is defined and user.admin == 1 %}
						<li class="nav-item"><a class="nav-link" href="/expend/">Проданное сегодня</a></li>
						<li class="nav-item"><a class="nav-link" href="/sold/">Продано всего</a></li>
					{% endif %}
				</ul>
				{% if user is defined %}
				<ul class="navbar-nav justify-content-end col">
					<li><a class="nav-link" href="#">{{ user.login }}</a></li>
					<li class="nav-item"><a class="nav-link" href="#" onclick="Logout()">Выйти</a></li>
				</ul>
				{% else %}
				<ul class="navbar-nav justify-content-end col">
					<li class="nav-item"><a class="nav-link" href="/auth/">Авторизация/Регистрация</a></li>
				</ul>
				{% endif %}
			</div>
		</nav>
	</header>
	{% block content %}
	{% endblock %}
</body>
</html>