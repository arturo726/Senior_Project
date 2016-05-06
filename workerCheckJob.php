<?php


// Name: Artruo Martinez
// Due: May 4, 2016
// Senior Project
// Purpose: The file will check to see if the user that los has a job.  If they do or don't, it will return 
// 	    that to the iOS app where it will either display the job the logged in user has been assigned
//	    or say that there are no current jobs assigned. 

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
