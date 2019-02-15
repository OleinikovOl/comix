{% extends "/layouts/main.volt" %}
{% block content %}
<div class="mt-4 row">
	<div class="col-3 ml-2">
		<!-- Поиск по базе -->	
		<form class="input-group mb-3 col" action="/" method="get">
			<input type="text" name="search" class="form-control" aria-describedby="button-addon2" list="db" autocomplete="off" autocorrect="off">
			<div class="input-group-prepend">
				<button class="btn btn-outline-secondary" type="submit" id="button-addon2">Поиск</button>
			</div>		
		</form>

		<!-- Форма поступления -->
		<label for="arrival" class="col" >Поступление</label>
		<form class="input-group mb-3 col" action="/index/arrival/" method="post">		
			<div class="input-group mb-3">
				<input class="form-control" placeholder="Наименование" name="name" type="text" maxlength="200" required list="db" autocomplete="off" autocorrect="off">
			</div>
			<div class="row">
				<div class="input-group mb-3 col">
					<input class="form-control" placeholder="Опт." name="opt" type="number" min="0" autocomplete="off" autocorrect="off">
				</div>
				<div class="input-group mb-3 col">
					<input class="form-control" placeholder="Розн." name="rozn" type="number" min="0" autocomplete="off" autocorrect="off">
				</div>
				<div class="input-group mb-3 col">
					<input class="form-control" placeholder="Кол." name="col" type="number" min="0" required autocomplete="off" autocorrect="off">
				</div>
			</div>
			<button class="btn btn-outline-secondary" type="submit">Сохранить</button>
		</form>
	</div>

	<!-- Таблица с товарами -->
	<table class="table mr-4  table-hover table-bordered col">
		<thead class="thead-light">
			<tr>
				<th scope="col">Наименование</th>
				<th scope="col">Цена опт.</th>
				<th scope="col">Цена розн.</th>
				<th scope="col">Количество</th>
			</tr>
		</thead>
		{% if stock is defined %}
			{% for stockElement in stock %}
				<tr>
					<td>{{ stockElement.name }}</td>
					<td>{{ stockElement.opt }}₽</td>
					<td>{{ stockElement.rozn }}₽</td>
					<td>{{ stockElement.col }}</td>	
				</tr>
			{% endfor %}
		{% endif %}
	</table>
</div>

	<!-- Элементы для списка -->
	<datalist id="db">
		{% for stockElement in stock %}
			<option value="{{ stockElement.name }}"></option>
		{% endfor %}
	</datalist>
{% endblock %}