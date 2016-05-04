<?php 

	include("connect.php");

        mysql_select_db("beachelectric");

        $jobType = $_POST['JobTipo'];

	$new_arr = array();
	
	if(strcmp($jobType, "Plumbing") == 0)
	{
		$success = mysql_query("select * from userInfo order by plumbingHours desc");
	
		if($success)
		{
			while ($result = mysql_fetch_assoc($success))
			{
				if(empty($result['userCode']))
				{
					if($result['JobID'] == 0)
					{
						array_push($new_arr ,$result['firstName'] . " " .$result['lastName']); 	
	
					}
				}
			}
			
		}	
	}
	else if(strcmp($jobType, "Drywall") == 0)
	{
		$success = mysql_query("select * from userInfo order by drywallHours desc");
		if($success)
		{
			while ($result = mysql_fetch_assoc($success))
			{
				if(empty($result['userCode']))
				{
					if($result['JobID'] == 0)
					{
						array_push($new_arr ,$result['firstName'] . " " .$result['lastName']); 	
	
					}
				}
			}
			
		}	
	
	}
	else if(strcmp($jobType, "Electrical") == 0)
	{
		$success = mysql_query("select * from userInfo order by electricalHours desc");
		if($success)
		{
			while ($result = mysql_fetch_assoc($success))
			{
				if(empty($result['userCode']))
				{
					if($result['JobID'] == 0)
					{
						array_push($new_arr ,$result['firstName'] . " " .$result['lastName']); 	
	
					}
				}
			}
			
		}	

	}


							   							
	  	
	echo json_encode($new_arr);
	

?>

