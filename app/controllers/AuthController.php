<?php

class AuthController extends ControllerBase
{
	/**
	 * Регистрация админа
	 */
	public function registerAction()
	{

	}
	/**
	 * Авторизация пользователя
	 */
	public function indexAction()
	{
		// $login    = $this->request->getPost('login');
		// $password = $this->request->getPost('password');
		// if(empty($login) || empty($password))
		// {
		// 	return;
		// }

		// $user = Users::find([
		// 	'conditions' => "login = :login: AND password = :pass:",
		// 	'bind'       =>
		// 	[
		// 		'login'  => $login,
		// 		'pass'   => md5($password)
		// 	]
		// ]);

		// if(count($user) === 0)
		// {
		// 	$this->view->setVar('errors','Пользователь не найден');
		// 	return;
		// }
		// else
		// {
		// 	$user = $user[0];
		// 	$this->session->set('auth', $user->id);
		// 	$this->response->redirect('/');
		// }

	}

	/**
	 * Выход
	 */
	public function logOutAction()
	{
		$this->session->remove('auth');
		$this->response->redirect('/');
	}
}