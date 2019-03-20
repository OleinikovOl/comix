{% extends "/layouts/main.volt" %}
{% block content %}
<script src="/js/expend.js"></script>
<div class="mt-4 row" style="width: 100%">
	<div class="col-3 ml-2">
		<!-- Поиск по базе -->
		<form id="sellForm" onsubmit="return false;">
			<div class="input-group mb-3 col">
				<input type="text" name="name" class="form-control col" placeholder="Наименование" required="true" list="db" autocomplete="off" autocorrect="off">
				<input type="number" min="0" name="col" class="form-control col-3" placeholder="Кол." required="true" autocomplete="off" autocorrect="off">
			</div>
			<div class="input-group mb-3 col">
				<input type="date" name="date" class="form-control col" required="true" value="" autocomplete="off" autocorrect="off">
				<button class="btn btn-outline-secondary" onclick="Sell()">Отправить</button>
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

	<datalist id="db">
		<!-- Элементы для списка -->
	</datalist>
{% endblock %}