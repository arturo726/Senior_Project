<?php


session_start();
$userCheck = $_SESSION['userLogin'];

if(!isset($userCheck)) {

		      mysql_close();

}

?>