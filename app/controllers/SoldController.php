<?php

class SoldController extends ControllerBase
{

	public function indexAction()
	{
		// Получаем данные
		$date = $this->request->get('date');
		if(empty($date))
			$date = date('Y-m-d');
		$this->view->setVar('date', $date);

		// Вытащить из базы все проданное в этот день
		$daySold = Sold::findByDate($date);
		$this->view->setVar('daySold', $daySold);

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
		$monthRus = [
			'1'  => 'Январь',
			'2'  => 'Февраль',
			'3'  => 'Март',
			'4'  => 'Апрель',
			'5'  => 'Май',
			'6'  => 'Июнь',
			'7'  => 'Июль',
			'8'  => 'Август',
			'9'  => 'Сентябрь',
			'10' => 'Октябрь',
			'11' => 'Ноябрь',
			'12' => 'Декабрь'
		];
		$this->view->setVar('month', $monthRus);
		$this->view->setVar('monthSold', $monthSold);

		// Вытаскиваем прочие расходы на выбранную дату
		$other = Other::findByDate(date('Y-m-d'));
		$this->view->setVar('other', $other);
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
		$this->response->redirect('/sold/');
	}

}

