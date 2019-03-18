{% extends "/layouts/main.volt" %}
{% block content %}

<div class="mt-4 row" style="width: 100%">
	<div class="col-3 ml-2">
		<!-- Поиск по базе -->
		<form class="input-group mb-3 col" action="/sold/" method="get">
			<input type="date" name="date" class="form-control" value="{{ date }}" aria-describedby="button-addon2" autocomplete="off" autocorrect="off">
			<div class="input-group-prepend">
				<button class="btn btn-outline-secondary" type="submit" id="button-addon2">Поиск</button>
			</div>
		</form>
		<!-- Прибыль в течении года -->
		<div class="table-responsive">
			<table class="table table-sm table-hover table-bordered">
				<thead class="thead-light">
					<tr>
						<th scope="col" align="center">Наименование</th>
						<th scope="col" align="center">Расход</th>
						<th scope="col" align="center">Прибыль</th>
					</tr>
				</thead>
				{% for otherItem in other %}
					<tr>
						<th scope="row">{{ otherItem.name }}</th>
						<td align="center">{{ otherItem.expend }}₽</td>
						<td align="center">{{ otherItem.income }}₽</td>
					</tr>
				{% endfor %}
			</table>
		</div>
		<div class="table-responsive">
			<table class="table table-sm table-hover table-bordered">
				<thead class="thead-light">
					<tr>
						<th scope="col" align="center">Месяц</th>
						<th scope="col" align="center">Опт.</th>
						<th scope="col" align="center">Розн.</th>
						<th scope="col" align="center">Итого</th>
					</tr>
				</thead>
				{% for name, value in month %}
					<tr>
						<th scope="row">{{ value }}</th>
						<td align="center">{{ monthSold['opt'][name] }}₽</td>
						<td align="center">{{ monthSold['rozn'][name] }}₽</td>
						<td align="center">{{ monthSold['rozn'][name] - monthSold['opt'][name] }}₽</td>
					</tr>
				{% endfor %}
			</table>
		</div>
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
				<th></th>
			</tr>
		</thead>
		{% set sumOpt = 0 %}
		{% set sumRozn = 0 %}
		{% set sumCol = 0 %}
		{% if daySold is defined %}
			{% for soldElement in daySold %}
					<tr>
						<th scope="row" align="center">{{ soldElement.stock_id }}</th>
						<td align="left">{{ soldElement.name }}</td>
						<td align="center">{{ soldElement.opt }}₽×{{ soldElement.col }}={{ soldElement.opt*soldElement.col }}₽</td>
						<td align="center">{{ soldElement.rozn }}₽×{{ soldElement.col }}={{ soldElement.rozn*soldElement.col }}₽</td>
						<td align="center">{{ soldElement.col }}</td>
						<td style="padding: 8px;">
							<form action="/sold/delete/" method="post">
								<input type="text" name="deleteItemId" value="{{ soldElement.stock_id }}" style="display: none;">
								<input type="text" name="deleteItemDate" value="{{ soldElement.date }}" style="display: none;">
								<button type="submit" class="btn btn-light btn-sm">
									<i class="fas fa-trash-alt"></i>
								</button>
							</form>
						</td>
					</tr>
					{% set sumOpt = sumOpt + (soldElement.opt * soldElement.col) %}
					{% set sumRozn = sumRozn + (soldElement.rozn * soldElement.col) %}
					{% set sumCol = sumCol + soldElement.col %}
			{% endfor %}
		{% endif %}
		<tr>
			<th scope="row" colspan="2">Всего:</th>
			<td align="center">{{ sumOpt }}₽</td>
			<td align="center">{{ sumRozn }}₽</td>
			<td align="center">{{ sumCol }}</td>
		</tr>
		<tr>
			<th scope="row" colspan="2" align="right">Чистая прибыль (розница - опт):</th>
			<td colspan="2" align="center">{{ sumRozn - sumOpt }}₽</td>
		</tr>
	</table>
</div>
{% endblock %}