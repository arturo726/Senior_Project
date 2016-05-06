<?php

// Name: Artruo Martinez
// Due: May 4, 2016
// Senior Project
// Purpose: The file check to see what user is logged in.

session_start();
$userCheck = $_SESSION['userLogin'];

if(!isset($userCheck)) 
{

	mysql_close();

}

?>
