<?php

class IndexController extends ControllerBase
{
	public function indexAction()
	{
		$search = $this->request->get('search');
		if (!empty($search))
		{
			$this->view->setVar('stockSearch', $search);
		}
		$stock = Stock::find();

		if (!empty($stock))
		{
			$this->view->setVar('stock',$stock);
		}
	}

	/**
	 * Action для отображения Not Found страницы
	 * @return view
	 */
	public function notfoundAction()
	{
		$this->response->setStatusCode(404, 'Not Found');
	}



	public function arrivalAction()
	{
		$name = $this->request->getPost('name');
		$opt = $this->request->getPost('opt');
		$rozn = $this->request->getPost('rozn');
		$col = $this->request->getPost('col');

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
				$arrival->col = $arrival->col + $col;
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
					$stock->name = $name;
					$stock->opt = $opt;
					$stock->rozn = $rozn;
					$stock->col = $col;
					$stock->save();
					$this->response->redirect('/');
				}
			}
		}
	}


}
