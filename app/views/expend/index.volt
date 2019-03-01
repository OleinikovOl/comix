{% extends "/layouts/main.volt" %}
{% block content %}
<div class="mt-4 row" style="width: 100%">
	<div class="col-3 ml-2">
		<!-- Поиск по базе -->
		<form class="" action="/expend/sell/" method="post">
			<div class="input-group mb-3 col">
				<input type="text" name="name" class="form-control col" placeholder="Наименование" required="true" list="db" autocomplete="off" autocorrect="off">
				<input type="number" min="0" name="col" class="form-control col-3" placeholder="Кол." required="true" autocomplete="off" autocorrect="off">
			</div>
			<div class="input-group mb-3 col">
				<input type="date" name="date" class="form-control col" required="true" value="{{ today }}" autocomplete="off" autocorrect="off">
				<button class="btn btn-outline-secondary" type="submit">Отправить</button>
			</div>
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
				<th></th>
			</tr>
		</thead>
		{% set sumOpt = 0 %}
		{% set sumRozn = 0 %}
		{% set sumCol = 0 %}
		{% if sold is defined %}
			{% for soldElement in sold %}
				{% if today in soldElement.date %}
					<tr>
						<th scope="row" align="center">{{ soldElement.stock_id }}</th>
						<td align="left">{{ soldElement.name }}</td>
						<td align="center">{{ soldElement.opt }}₽×{{ soldElement.col }}={{ soldElement.opt*soldElement.col }}₽</td>
						<td align="center">{{ soldElement.rozn }}₽×{{ soldElement.col }}={{ soldElement.rozn*soldElement.col }}₽</td>
						<td align="center">{{ soldElement.col }}</td>
						<td style="padding: 8px;">
							<form action="/expend/delete/" method="post">
								<input type="text" name="deleteItemId" value="{{ soldElement.stock_id }}" style="display: none;">
								<input type="text" name="deleteItemDate" value="{{ today }}" style="display: none;">
								<button type="submit" class="btn btn-light btn-sm">
									<i class="fas fa-trash-alt"></i>
								</button>
							</form>
						</td>
					</tr>
					{% set sumOpt = sumOpt + (soldElement.opt * soldElement.col) %}
					{% set sumRozn = sumRozn + (soldElement.rozn * soldElement.col) %}
					{% set sumCol = sumCol + soldElement.col %}
				{% endif %}
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

	<!-- Элементы для списка -->
	<datalist id="db">
		{% if stock is defined %}
			{% for stockElement in stock %}
				{% if stockElement.col > 0 %}
					<option value="{{ stockElement.name }}"></option>
				{% endif %}
			{% endfor %}
		{% endif %}
	</datalist>
{% endblock %}