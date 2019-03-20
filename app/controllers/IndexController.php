<?php

class IndexController extends ControllerBase
{
	public function indexAction()
	{

	}

	public function getDateAction()
	{
		$date = date('Y-m-d');
		return $this->jsonResult(['success' => true, 'date' => $date]);
	}

	/**
	 * Достает записи из базы и отдает на фронт
	 */
	public function getItemsAction()
	{
		$admin = $this->session->get('auth');
		if ($admin != null)
		{
			$user = Users::findFirstById($admin);
			$admin = $user->admin;
		}
		else
		{
			$admin = 0;
		}
		if ($admin == 1)
		{
			$stock = Stock::find([
				'order' => 'date DESC'
			]);
		}
		else
		{
			$stock = Stock::find([
				'columns' => 'id, name, rozn, col, date',
				'order' => 'date DESC'
			]);
		}
		return $this->jsonResult(['success' => true, 'items' => $stock, 'admin' => $admin]);
	}

	public function searchAction()
	{
		$search = $this->request->get('search');

		$admin = $this->session->get('auth');
		if ($admin != null)
		{
			$user = Users::findFirstById($admin);
			$admin = $user->admin;
		}
		else
		{
			$admin = 0;
		}

		if ($admin == 1)
		{
			$stock = Stock::find([
				'order' => 'date DESC'
			]);
		}
		else
		{
			$stock = Stock::find([
				'columns' => 'id, name, rozn, col, date',
				'order'   => 'date DESC'
			]);
		}

		if (!empty($search))
		{
			$items = [];
			$stock = $stock->toArray();
			foreach ($stock as $item)
			{
				if (stristr($item['name'], $search))
					$items[] = $item;
			}
			return $this->jsonResult(['success' => true, 'items' => $items, 'admin' => $admin]);
		}
		return $this->jsonResult(['success' => true, 'items' => $stock, 'admin' => $admin]);
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
				return $this->jsonResult(['success' => true]);
			}
			else
			{

				if (empty($opt) || empty($rozn) || empty($col))
				{
					return $this->jsonResult(['success' => false]);
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
					return $this->jsonResult(['success' => true]);
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
