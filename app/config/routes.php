<?php
$router = new \Phalcon\Mvc\Router();

$router->add(
	"/notfound/", [
		"controller" => 'index',
		"action"     => 'notfound'
	]
);
$router->add(
	"/auth/", [
		"controller" => 'auth'
	]
);
$router->add(
	"/arrival/", [
		"controller" => 'index',
		"action"     => 'arrival'
	]
);
$router->add(
	"/delete/", [
		"controller" => 'index',
		"action"     => 'delete'
	]
);
$router->add(
	"/expend/",[
		"controller"=> 'expend'
	]
);
$router->add(
	"/expend/delete/",[
		"controller" => 'expend',
		"action"     => 'delete'
	]
);
$router->add(
	"/sold/",[
		"controller" => 'sold'
	]
);
$router->add(
	"/aprove/",[
		"controller" => 'auth'
	]
);
$router->handle();
return $router;

?>