<?php

// Name: Artruo Martinez
// Due: May 4, 2016
// Senior Project
// Purpose: The file will receive the information when a forman submits a job for a worker.  It will be
//	    inserted into the JobsAssigned tablle and it will update the useIndfo table to show
//          that a user now has a job 

include("connect.php");
	
	$jobType = $_POST['JobTipo'];
	$worker = $_POST['assignedWorker']; 
	$site = $_POST['workSite'];
        	
	$site = mysql_real_escape_string($site);
       
	mysql_select_db("beachelectric");
	$s =  mysql_query("insert into JobsAssigned (JobType,  WorkerAssigned, Location) values ('$jobType','$worker', '$site')");
                       
                        
	if($s){	
			$query = "select * from JobsAssigned where JobType='$jobType' and WorkerAssigned='$worker' and Location='$site'";
			$value = mysql_query($query);
			
			if($value)
			{	
				$check = mysql_fetch_assoc($value);
				     	
				
				$job_Id = $check['JobID'];		 
			    
                        
				$name = explode(" ", $worker);
			
				$query = "update userInfo set JobID='$job_Id' where firstName='$name[0]' and lastName='$name[1]'";
                        
				$result = mysql_query($query);
			
				if($result)
				{
					echo "true";
				}
				
			
			
		        
			}
	}			
	else{

		echo "nah $s";
	}

?>
