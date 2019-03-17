{% extends "/layouts/main.volt" %}
{% block content %}
<script src="/js/otherExIn.js"></script>
<div class="mt-4 row" style="width: 100%">
	<div class="col-3 ml-2">
		<!-- Форма Расходов -->
		<label for="arrival" class="col">Прочие расходы</label>
		<form id="formEx" onsubmit="return false;">
			<div class="input-group mb-3 col">
				<input type="text" name="name" class="form-control col" placeholder="Наименование" required="true" autocomplete="off" autocorrect="off">
				<input type="number" min="0" name="col" class="form-control col-3" placeholder="Кол." required="true" autocomplete="off" autocorrect="off">
			</div>
			<div class="input-group mb-3 col">
				<input type="date" name="date" class="form-control col" required="true" value="" autocomplete="off" autocorrect="off">
				<button class="btn btn-outline-secondary"  onclick="OtherEx()">Сохранить</button>
			</div>
		</form>
		<!-- Форма доходов -->
		<label for="arrival" class="col">Прочие доходы</label>
		<form id="formIn" onsubmit="return false;">
			<div class="input-group mb-3 col">
				<input type="text" name="name" class="form-control col" placeholder="Наименование" required="true" autocomplete="off" autocorrect="off">
				<input type="number" min="0" name="col" class="form-control col-3" placeholder="Кол." required="true" autocomplete="off" autocorrect="off">
			</div>
			<div class="input-group mb-3 col">
				<input type="date" name="date" class="form-control col" required="true" value="" autocomplete="off" autocorrect="off">
				<button class="btn btn-outline-secondary"  onclick="OtherIn()">Сохранить</button>
			</div>
		</form>
	</div>

	<!-- Таблица-->
	<table class="table table-hover table-bordered col">
		<thead class="thead-light">
			<tr>
				<th scope="col" align="center">Наименование</th>
				<th scope="col" align="center">Расход</th>
				<th scope="col" align="center">Доход</th>
				<th></th>
			</tr>
		</thead>
		<tbody id="table">
			<!-- <tr>
				<td align="left"></td>
				<td align="center">₽</td>
				<td align="center">₽</td>
				<td style="padding: 8px;">
					<form id="formDelete">
						<input type="text" name="itemId" value="" style="display: none;">
						<button class="btn btn-light btn-sm" onclick="Delete()">
							<i class="fas fa-trash-alt"></i>
						</button>
					</form>
				</td>
			</tr> -->
		</tbody>
	</table>
</div>

{% endblock %}