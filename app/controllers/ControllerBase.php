<?php

use Phalcon\Mvc\Controller;

class ControllerBase extends Controller
{
	/**
	 * Инит функция
	 * 	Получение информации об авторизованности пользователя
	 */
	public function initialize()
	{
		$userId = $this->session->get('auth');

		if(!empty($userId))
		{
			$user = Users::findFirstById($userId);

			if (!empty($user))
				$this->view->setVar('user', $user);
		}
	}

	/**
	 * Функция открытия 404 страницы
	 * @return view 404 страница
	 */
	public function pageNotFound()
	{
		/**
		 * если запрос ничего не дал
		 */
		if(!$this->request->isAjax())
		{
			$this->response->redirect('/notfound/');
			$this->view->disable();
		}
		else
		{
			$this->jsonResult(['result'=>'error','msg'=>'not found']);
		}
	}

	/**
	 * Функуция для ответа json
	 * 	Отключение view
	 * @param  array $data Массив данных для отдачи в формате json
	 */
	public function jsonResult($data)
	{
		echo json_encode($data);
		$this->view->disable();
		return;
	}

}

?>