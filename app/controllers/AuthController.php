<?php

class AuthController extends ControllerBase
{
	public function indexAction()
	{

	}
	/**
	 * Регистрация
	 */
	public function registerAction()
	{
		// Получаем данные
		$login     = $this->request->getPost('login');
		$email     = $this->request->getPost('email');
		$pass      = $this->request->getPost('password');
		$secretKey = $this->request->getPost('secretKey');

		// Проверяем данные на занятость
		$userLogin = Users::findFirstByLogin($login);
		if (!empty($userLogin))
			return $this->jsonResult(['success' => false, 'message' => 'login is exists']);
		$userEmail = Users::findFirstByEmail($email);
		if (!empty($userEmail))
			return $this->jsonResult(['success' => false, 'message' => 'email is exists']);
		$isAdmin = 0;
		// Если есть SecretKey то даем админку
		if (!empty($secretKey))
		{
			$secret = Secret::findFirstByCode($secretKey);
			if (!empty($secret))
			{
				$isAdmin = 1;
				$secret->delete();
			}
		}
		// Создаем ключ и пользователя
		$user = new Users();
		$user->create([
			'email'    => $email,
			'login'    => $login,
			'password' => md5($pass),
			'admin'    => $isAdmin,
			'aprove'   => 0
		]);
		$hash = md5($email . date('D, d M Y H:i:s') . 'ComixShop');
		$aprove = new Aprove();
		$aprove->create([
			'hash' => $hash,
			'email' => $email
		]);
		mail($email, 'Подтверждение почты', 'Перейдите по ссылке: ' . $this->config->application->domain . '/auth/aprove?hash=' . $hash, 'From: ComixShop <ComixShop@olegdev.tk>');
		$this->jsonResult(['success' => true]);
	}

	public function aproveAction()
	{
		// Получаем хеш
		$hash = $this->request->get('hash');

		// Проверяем наличия хеша в базе
		$aprove = Aprove::findFirstByHash($hash);
		if (empty($aprove))
			return $this->response->redirect('/notfound/');

		// Если есть, то подтверждаем пользователя
		$user = Users::findFirstByEmail($aprove->email);
		$user->update([
			'aprove' => 1
		]);
		$aprove->delete();
		// Автоматическая авторизация при подтверждении
		$this->session->set('auth', $user->id);
		$this->view->setVar('user', $user);
	}
	/**
	 * Авторизация пользователя
	 */
	public function signInAction()
	{
		// Получаем данные
		$login    = $this->request->getPost('login');
		$password = $this->request->getPost('password');

		$userLogin = Users::findFirst([
			'conditions' => "login = :login: AND password = :pass:",
			'bind'       =>
			[
				'login'  => $login,
				'pass'   => md5($password)
			]
		]);

		if(!empty($userLogin) && $userLogin->aprove == 1)
		{
			$this->session->set('auth', $userLogin->id);
			return $this->jsonResult(['success' => true]);
		}
		else
		{
			$userEmail = Users::findFirst([
				'conditions' => "email = :email: AND password = :pass:",
				'bind'       =>
				[
					'email' => $login,
					'pass'  => md5($password)
				]
			]);
		}

		if(!empty($userEmail) && $userEmail->aprove == 1)
		{
			$this->session->set('auth', $userEmail->id);
			return $this->jsonResult(['success' => true]);
		}
		else
		{
			return $this->jsonResult(['success' => false, 'message' => 'no user']);
		}
	}

	/**
	 * Выход
	 */
	public function logOutAction()
	{
		$this->session->remove('auth');
		return $this->jsonResult(['success' => true]);
	}
}