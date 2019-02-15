<?php
$router = new \Phalcon\Mvc\Router();

$router->add(
	"/notfound/", [
		"controller" => 'index',
		"action"     => 'notfound'
	]
);
$router->add(
	"/expend/",[
		"controller"=>'expend'
	]
);
$router->add(
	"/sold/",[
		"controller"=>'sold'
	]
);
$router->handle();
return $router;

?>