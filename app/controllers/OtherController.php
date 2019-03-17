<?php

class OtherController extends ControllerBase
{
	public function indexAction()
	{

	}

	public function getItemsAction()
	{
		$otherItems = Other::findByDate(date('Y-m-d'));
		return $this->jsonResult(['success' => true, 'items' => $otherItems->toArray()]);
	}

	public function getDateAction()
	{
		$date = date('Y-m-d');
		return $this->jsonResult(['success' => true, 'date' => $date]);
	}

	public function deleteItemAction()
	{
		$id = $this->request->getPost('itemId');
		$item = Other::findFirstById($id);
		$item->delete();
		return $this->jsonResult(['success' => true]);
	}

	public function expendAction()
	{
		$name = $this->request->getPost('name');
		$col  = $this->request->getPost('col');
		$date = $this->request->getPost('date');

		if (empty($date))
		{
			$date = date('Y-m-d');
		}
		$otherEx = new Other();
		$otherEx->create([
			'name'   => $name,
			'income' => 0,
			'expend' => $col,
			'date'   => $date
		]);
		return $this->jsonResult(['success' => true]);
	}

	public function incomeAction()
	{
		$name = $this->request->getPost('name');
		$col  = $this->request->getPost('col');
		$date = $this->request->getPost('date');

		if (empty($date))
		{
			$date = date('Y-m-d');
		}
		$otherEx = new Other();
		$otherEx->create([
			'name'   => $name,
			'income' => $col,
			'expend' => 0,
			'date'   => $date
		]);
		return $this->jsonResult(['success' => true]);
	}
}