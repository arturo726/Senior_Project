<?php

// Name: Artruo Martinez
// Due: May 4, 2016
// Senior Project
// Purpose: This file will select all inofrmation from the JobsAssigned table, execpt for the ID. This information 
//	    to the iOS app so that the foreman can whart jobs are assgined. 

	include("connect.php");

        mysql_select_db("beachelectric");


	$sql = "select * from JobsAssigned";

	$query = mysql_query($sql);
	
	$array = array();

	if(mysql_num_rows($query) == 0)
	{	
		array_push($array,"no job");
		echo json_encode($array);
		exit;
	}


	else
	{

		while($values = mysql_fetch_assoc($query))
		{
			if(!empty($values['JobType']))	
			{
				array_push($array, $values['JobType'] . ", " . $values['WorkerAssigned'] . ", " . $values['Location']); 
			}
		}
		echo json_encode($array);


	}	





?>
