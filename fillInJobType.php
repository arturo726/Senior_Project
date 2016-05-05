<?php


// Name: Artruo Martinez
// Due: May 4, 2016
// Senior Project
// Purpose: The file will check the user that is logged in and check whether or not they have been assigned
//          a job.  If the user does have a job, then it will return the type of job.  This information is passed
//	    to the app so it can automatically fill in the field for the user. 


	include("connect.php");
	include("sessionActive.php");

        mysql_select_db("beachelectric");

	$userEmail =  $_SESSION['userLogin'];	

	$sql = "select * from userInfo where userEmail='$userEmail'";

	$query =  mysql_query($sql);

	if($query)
	{
	
		$value = mysql_fetch_assoc($query);
		$Job_ID = $value['JobID'];
		

	        $sql = "select JobType from JobsAssigned where JobID='$Job_ID'";
		
		$output = mysql_query($sql);
	
 		$new_arr = array();
			
			if(mysql_num_rows($output) == 0)
			{
				array_push($new_arr,"no job");
				echo json_encode($new_arr);
				exit;
			}
		
			
			if($output >= 1)
			{
				 $values = mysql_fetch_assoc($output);
				
			         array_push($new_arr ,$values['JobType']); 	
	  			   
				 echo json_encode($new_arr);
			}
			
			

	}

?>
