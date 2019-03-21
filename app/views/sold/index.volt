{% extends "/layouts/main.volt" %}
{% block content %}
<script src="/js/sold.js"></script>
<div class="mt-4 row" style="width: 100%">
	<div class="col-3 ml-2">
		<!-- Поиск по базе -->
		<form class="input-group mb-3 col" id="dateForm" onsubmit="return false;">
			<input type="date" name="date" class="form-control" value="" aria-describedby="button-addon2" autocomplete="off" autocorrect="off">
			<div class="input-group-prepend">
				<button class="btn btn-outline-secondary" id="button-addon2" onclick="GetItems()">Поиск</button>
			</div>
		</form>
		<!-- Прочие расходы и прибыль -->
		<div class="table-responsive">
			<table class="table table-sm table-hover table-bordered">
				<thead class="thead-light">
					<tr>
						<th scope="col" align="center">Наименование</th>
						<th scope="col" align="center">Расход</th>
						<th scope="col" align="center">Прибыль</th>
					</tr>
				</thead>
				<tbody id="bodyOther">
					<!-- Место для прочич расходов и прибыли -->
				</tbody>
			</table>
		</div>

		<!-- Прибыль за год -->
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
				<tbody id="bodyYear">
					<!-- Элементы прибыли за год -->
				</tbody>
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
		<tbody id="body">
			<!-- Место для элементов -->
		</tbody>
		<tbody id="total">
			<tr>
				<th scope="row" colspan="2">Всего:</th>
				<td id="sumOpt" align="center"></td>
				<td id="sumRozn" align="center"></td>
				<td id="sumCol" align="center"></td>
			</tr>
			<tr>
				<th scope="row" colspan="2" align="right">Чистая прибыль (розница - опт):</th>
				<td id="clearIncome" colspan="2" align="center"></td>
			</tr>
		</tbody>
	</table>
</div>
{% endblock %}