<?php

class ExpendController extends ControllerBase
{

	public function indexAction()
	{
	}

	public function getItemsAction()
	{
		$today = date('Y-m-d');

		$soldToday = Sold::find([
			'conditions' => 'date like :todayDate:',
			'bind'       =>
			[
				'todayDate' => $today
			]
		]);
		$stock = Stock::find([
			'columns' => 'name, col'
		]);
		return $this->jsonResult(['success' => true, 'itemsSold' => $soldToday, 'itemsStock' => $stock]);
	}

	public function sellAction()
	{
		// Получаем данные
		$name = $this->request->getPost('name');
		$col  = $this->request->getPost('col');
		$date = $this->request->getPost('date');

		// Проверяем на заполненность полей
		if(empty($name) || empty($col) || empty($date))
			return $this->response->redirect('/expend/');

		// Проверяем на наличии такой записи в stock
		$stockItem = Stock::findFirst([
			'conditions' => 'name = :name:',
			'bind'       =>
			[
				'name' => $name
			]
		]);
		if(!count($stockItem))
			return $this->jsonResult(['success' => false]);
		if($stockItem->col < $col)
			return $this->jsonResult(['success' => false]);

		// Ищем такую запись в Sold
		$soldItem = Sold::find([
			'conditions' => 'name = :name: AND date = :date:',
			'bind'       =>
			[
				'name' => $name,
				'date' => $date
			]
		]);

		// Если не нашли, то создаем
		if(!count($soldItem))
		{
			$stockItem->col = $stockItem->col - $col;
			$sold = new Sold();
			$error = !$sold->save([
				'stock_id' => $stockItem->id,
				'name'     => $stockItem->name,
				'opt'      => $stockItem->opt,
				'rozn'     => $stockItem->rozn,
				'col'      => $col,
				'date'     => $date
			]);
			if($error)
				return $this->jsonResult(['success' => false]);

			$error = !$stockItem->save();
			if($error)
				return $this->jsonResult(['success' => false]);
		}// Если нашли, то обновляем
		else
		{
			$soldItem = $soldItem[0];
			$stockItem->col = $stockItem->col - $col;
			$soldItem->col = $soldItem->col + $col;
			$error = !$soldItem->save();
			if($error)
				return $this->jsonResult(['success' => false]);

			$error = !$stockItem->save();
			if($error)
				return $this->jsonResult(['success' => false]);
		}
		return $this->jsonResult(['success' => true]);
	}

	/**
	 * Удаляет из базы
	 */
	public function deleteItemAction()
	{
		$date   = date('Y-m-d');
		$itemId = $this->request->getPost('id');
		$item = Sold::findFirst([
			'conditions' => 'stock_id = :itemId: AND date = :itemDate:',
			'bind'       =>
			[
				'itemId'   => $itemId,
				'itemDate' => $date
			]
		]);
		$stockItem = Stock::findFirstById($itemId);
		$stockItem->col = $stockItem->col + $item->col;
		$item->delete();
		$stockItem->save();
		return $this->jsonResult(['success' => true]);
	}
}

