{% extends "/layouts/main.volt" %}
{% block content %}
<script src="/js/stock.js"></script>
<div class="mt-4 row" style="width: 100%">
	<div class="col-3 ml-2">
		<!-- Поиск по базе -->
		<form class="input-group mb-3 col" id="searchForm" onsubmit="return false;">
			<input type="text" name="search" class="form-control" aria-describedby="button-addon" list="db" placeholder="Поиск по имени" autocomplete="off" autocorrect="off">
			<div class="input-group-prepend">
				<button class="btn btn-outline-secondary" onclick="Search()" id="button-addon">Поиск</button>
			</div>
		</form>
		{% if user is defined and user.admin == 1 %}
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
		{% endif %}
	</div>

	<!-- Таблица с товарами -->
	<table class="table table-hover table-bordered col">
		<thead class="thead-light">
			<tr>
				<th scope="col" align="center">Артикл</th>
				<th scope="col" align="center">Наименование</th>
				{% if user is defined and user.admin == 1 %}
					<th scope="col" align="center">Цена опт.</th>
				{% endif %}
				<th scope="col" align="center">Цена{% if user is defined and user.admin == 1 %} розн. {% endif %}</th>
				<th scope="col" align="center">Количество</th>
				<th scope="col" align="center">Дата поступления</th>
				{% if user is defined and user.admin == 1 %}
					<th></th>
				{% endif %}
			</tr>
		</thead>
		<tbody>
			<!-- <tr>
				<th scope="row" align="center">{{ stockElement.id }}</th>
				<td align="left">{{ stockElement.name }}</td>
				<td align="center">{{ stockElement.opt }}₽</td>
				<td align="center">{{ stockElement.rozn }}₽</td>
				<td align="center">{{ stockElement.col }}</td>
				<td align="center">{{ stockElement.date }}</td>
				<td style="padding: 8px;">
					<form action="/delete/" method="post">
						<input type="text" name="deleteItemId" value="{{ stockElement.id }}" style="display: none;">
						<button type="submit" class="btn btn-light btn-sm">
							<i class="fas fa-trash-alt"></i>
						</button>
					</form>
				</td>
			</tr> -->
		</tbody>
	</table>
</div>

	<!-- Элементы для списка -->
	<datalist id="db">
		{% for stockElement in stock %}
			<option value="{{ stockElement.name }}"></option>
		{% endfor %}
	</datalist>
{% endblock %}