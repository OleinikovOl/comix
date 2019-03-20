<?php

class ExpendController extends ControllerBase
{

	public function indexAction()
	{
		$today = date('Y-m-d');
		$this->view->setVar('today', $today);

		$soldToday = Sold::find([
			'conditions' => 'date like :todayDate:',
			'bind'       =>
			[
				'todayDate' => $today
			]
		]);
		if(!empty($soldToday))
			$this->view->setVar('sold', $soldToday);
		$stock = Stock::find();
		if(!empty($stock))
			$this->view->setVar('stock', $stock);
	}

	public function sellAction()
	{
		$today = date('Y-m-d');
		// Получаем данные
		$name = $this->request->getPost('name');
		$col  = $this->request->getPost('col');
		$date = $this->request->getPost('date');

		// Проверяем на заполненность полей
		if(empty($name) || empty($col) || empty($date))
			return $this->response->redirect('/expend/');

		// Проверяем на наличии такой записи в stock
		$stockItem = Stock::find([
			'conditions' => 'name = :name:',
			'bind'       =>
			[
				'name' => $name
			]
		]);
		if(!count($stockItem))
			return $this->response->redirect('/expend/');
		$stockItem = $stockItem[0];
		if($stockItem->col < $col)
			return $this->response->redirect('/expend/');

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
				'date'     => $today
			]);
			if($error)
				return $this->response->redirect('/expend/');

			$error = !$stockItem->save();
			if($error)
				return $this->response->redirect('/expend/');
		}// Если нашли, то обновляем
		else
		{
			$soldItem = $soldItem[0];
			$stockItem->col = $stockItem->col - $col;
			$soldItem->col = $soldItem->col + $col;
			$error = !$soldItem->save();
			if($error)
				return $this->response->redirect('/expend/');

			$error = !$stockItem->save();
			if($error)
				return $this->response->redirect('/expend/');
		}
		return $this->response->redirect('/expend/');
	}

	/**
	 * Удаляет из базы
	 */
	public function deleteAction()
	{
		$date   = $this->request->getPost('deleteItemDate');
		$itemId = $this->request->getPost('deleteItemId');
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
		$this->response->redirect('/expend/');
	}
}

