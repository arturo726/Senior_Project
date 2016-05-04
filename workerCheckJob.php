<?php


	include("connect.php");
	include("sessionActive.php");

        mysql_select_db("beachelectric");

	$userEmail = $_SESSION['userLogin'];

	$sql = "select JobID from userInfo where userEmail = '$userEmail'";
	
	$query = mysql_query($sql);
	
        $array = array();


	
	if(mysql_num_rows($query) >=1)
	{
		$value = mysql_fetch_assoc($query);

		$jobID = $value['JobID'];
		
	
		$sql_2 = "select * from JobsAssigned where JobID ='$jobID'";
		
		$new_query = mysql_query($sql_2);
		
		if(mysql_num_rows($new_query) == 0)
		{	
			array_push($array,"no job");
			echo json_encode($array);
			exit;
		}

	
		else
		{
			$values = mysql_fetch_assoc($new_query);
			
			array_push($array, $values['JobType'] . ", " . $values['WorkerAssigned'] . ", " . $values['Location']); 
			echo json_encode($array);
		}

			

	
	}
	





?>
