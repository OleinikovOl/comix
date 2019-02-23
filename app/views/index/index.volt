{% extends "/layouts/main.volt" %}
{% block content %}

<div class="mt-4 row" style="width: 100%">
	<div class="col-3 ml-2">
		<!-- Поиск по базе -->
		<form class="input-group mb-3 col" action="/" method="get">
			<input type="text" name="search" class="form-control" aria-describedby="button-addon2" list="db" autocomplete="off" autocorrect="off">
			<div class="input-group-prepend">
				<button class="btn btn-outline-secondary" type="submit" id="button-addon2">Поиск</button>
			</div>
		</form>

		<!-- Форма поступления -->
		<label for="arrival" class="col">Поступление</label>
		<form class="input-group mb-3 col" action="/arrival/" method="post">
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
	<table class="table table-hover table-bordered col">
		<thead class="thead-light">
			<tr>
				<th scope="col" align="center">Артикл</th>
				<th scope="col" align="center">Наименование</th>
				<th scope="col" align="center">Цена опт.</th>
				<th scope="col" align="center">Цена розн.</th>
				<th scope="col" align="center">Количество</th>
			</tr>
		</thead>
		{% if stock is defined %}
			{% if stockSearch is defined %}
				{% for stockElement in stock %}
					{% if stockSearch == stockElement.name %}
						<tr>
							<th scope="row" align="center">{{ stockElement.id }}</th>
							<td align="left">{{ stockElement.name }}</td>
							<td align="center">{{ stockElement.opt }}₽</td>
							<td align="center">{{ stockElement.rozn }}₽</td>
							<td align="center">{{ stockElement.col }}</td>
						</tr>
					{% endif %}
				{% endfor %}
			{% else %}
				{% for stockElement in stock %}
					<tr>
						<th scope="row" align="center">{{ stockElement.id }}</th>
						<td align="left">{{ stockElement.name }}</td>
						<td align="center">{{ stockElement.opt }}₽</td>
						<td align="center">{{ stockElement.rozn }}₽</td>
						<td align="center">{{ stockElement.col }}</td>
					</tr>
				{% endfor %}
			{% endif %}
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