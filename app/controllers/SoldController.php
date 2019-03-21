<?php

class SoldController extends ControllerBase
{
	public function indexAction()
	{

	}

	public function getItemsAction()
	{
		// Получаем данные
		$date = $this->request->getPost('date');
		if (empty($date))
			$date = date('Y-m-d');
		// Вытащить из базы все проданное в этот день
		$daySold = Sold::findByDate($date);

		// Проданное в этот год на каждый месяц
		$date = explode('-', $date);
		$yearSold = Sold::find([
			'conditions' => 'date LIKE :date:',
			'bind'       =>
			[
				'date' => $date[0] . '%'
			]
		]);

		for ($i=1; $i <= 12 ; $i++)
		{
			$monthsOpt[$i]  = 0;
			$monthsRozn[$i] = 0;
		}
		for ($i=1; $i <= 12 ; $i++)
		{
			foreach ($yearSold as $sold)
			{
				$itemDate = explode('-', $sold->date);
				if ($itemDate[1] == $i)
				{
					$monthsOpt[$i]  = $monthsOpt[$i] + ($sold->opt * $sold->col);
					$monthsRozn[$i] = $monthsRozn[$i] + ($sold->rozn * $sold->col);
				}
			}
		}
		$monthSold['opt'] = $monthsOpt;
		$monthSold['rozn'] = $monthsRozn;

		// Вытаскиваем прочие расходы на выбранную дату
		$other = Other::findByDate(date('Y-m-d'));

		return $this->jsonResult(['success' => true, 'items' => $daySold, 'other' => $other, 'monthSold' => $monthSold]);
	}

	/**
	 * Удаляет из базы
	 */
	public function deleteItemAction()
	{
		$date   = $this->request->getPost('date');
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

