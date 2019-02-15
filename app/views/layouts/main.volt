<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>ComixShop</title>
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js" integrity="sha384-xrRywqdh3PHs8keKZN+8zzc5TX0GRTLCcmivcbNJWm2rs5C8PRhcEn3czEjhAO9o" crossorigin="anonymous"></script>
	
</head>
<body>
	<header>
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			<div class="collapse navbar-collapse" id="navbarNav">				
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link" href="/">В наличии и поступление</a></li>
					<li class="nav-item"><a class="nav-link" href="/expend/">Расход</a></li>
					<li class="nav-item"><a class="nav-link" href="/sold/">Проданное</a></li>
				</ul>
			</div>
		</nav>
	</header>
	{% block content %}
	{% endblock %}
</body>
</html>