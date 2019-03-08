<?php

class AuthController extends ControllerBase
{
	/**
	 * Регистрация админа
	 */
	public function registerAdminAction()
	{
		$user = Users::findByLogin('admin');
		if (count($user)=0)
		{
			$admin = new Users();
			$admin->save([
				'login' => 'admin',
				'password' => md5('ZzHJft3eUwH')
			]);
		}

	}
	/**
	 * Авторизация пользователя
	 */
	public function indexAction()
	{
		$login    = $this->request->getPost('login');
		$password = $this->request->getPost('password');
		if(empty($login) || empty($password))
		{
			return;
		}

		$user = Users::find([
			'conditions' => "login = :login: AND password = :pass:",
			'bind'       =>
			[
				'login'  => $login,
				'pass'   => md5($password)
			]
		]);

		if(count($user) === 0)
		{
			$this->view->setVar('errors','Пользователь не найден');
			return;
		}
		else
		{
			$user = $user[0];
			$this->session->set('authUser', $user->id);
			$this->response->redirect('/');
		}

	}

	/**
	 * Проверка на авторизованность пользователя
	 */
	public function isLoggedAction()
	{
		$auth = $this->session->get('authUser');
		if(empty($auth))
			return $this->jsonResult(['success' => false, 'message' => 'no auth']);

		return $this->jsonResult(['success' => true, 'userid' => $auth]);
	}

	/**
	 * Выход
	 */
	public function logOutAction()
	{
		$this->session->remove('authUser');
		$this->response->redirect('/');
	}
}