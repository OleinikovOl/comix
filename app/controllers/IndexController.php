<?php

class IndexController extends ControllerBase
{
	public function indexAction()
	{

	}

	/**
	 * Достает записи из базы и отдает на фронт
	 */
	public function getItemsAction()
	{
		$stock = Stock::find([
			'order' => 'date DESC'
		]);
		return $this->jsonResult(['success' => true, 'items' => $stock]);
	}

	public function searchAction()
	{
		$search = $this->request->getPost('search');
		$search = '%' + $search + '%';
		$stock = Stock::find([
				'conditions' => 'name LIKE ?1',
				'bind'       =>
				[
					1 => $search
				],
				'order' => 'date DESC'
			]);
		return $this->jsonResult(['success' => true, 'items' => $stock]);
	}

	/**
	 * Action для отображения Not Found страницы
	 * @return view
	 */
	public function notfoundAction()
	{
		$this->response->setStatusCode(404, 'Not Found');
	}


	/**
	 * Принимает данные из формы и записывает в базу
	 */
	public function arrivalAction()
	{
		$name = $this->request->getPost('name');
		$opt  = $this->request->getPost('opt');
		$rozn = $this->request->getPost('rozn');
		$col  = $this->request->getPost('col');
		$date = date('Y-m-d');
		if (empty($opt))
			$opt = 0;

		if (empty($rozn))
			$rozn = 0;

		if (!empty($name))
		{
			$arrival = Stock::findFirstByName($name);
			if (!empty($arrival))
			{
				if ($opt > 0)
				{
					$arrival->opt = $opt;
				}
				if ($rozn > 0)
				{
					$arrival->rozn = $rozn;
				}
				$arrival->col  = $arrival->col + $col;
				$arrival->date = $date;
				$arrival->update();
				$this->response->redirect('/');
			}
			else
			{

				if (empty($opt) || empty($rozn) || empty($col))
				{
					$this->response->redirect('/');
				}
				else
				{
					$stock = new Stock();
					$stock->create([
						'name' => $name,
						'opt'  => $opt,
						'rozn' => $rozn,
						'col'  => $col,
						'date' => $date
					]);
					$this->response->redirect('/');
				}
			}
		}
	}

	/**
	 * Удаляет из базы
	 */
	public function deleteItemAction()
	{
		$item = Stock::findFirstById($this->request->getPost('id'));
		$item->delete();
		return $this->jsonResult(['success' => true]);
	}
}
