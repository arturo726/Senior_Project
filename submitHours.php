<?php


include("connect.php");
include("sessionActive.php");
	

	mysql_select_db("beachelectric");
                                 
        $jobHours = $_POST['jobHours'];
	
	$jobType = mysql_real_escape_string($_POST['jobType']);
  
	$Useremail =  $_SESSION['userLogin'];	

	$sql = "select * from userInfo where userEmail='$Useremail'";

	$query =  mysql_query($sql);		 
	

	if($query)
	{
		$JobAssigned = mysql_fetch_assoc($query);
		$removeJob = $JobAssigned['JobID'];	
		
		if($removeJob != 0)
		{
			if(strcmp($jobType, "Plumbing") == 0)
			{
				$success =  mysql_query("update userInfo set plumbingHours=plumbingHours+'$jobHours' where userEmail='$Useremail'"); 
			 

			}
			else if(strcmp($jobType, "Drywall") == 0)
			{
				$success =  mysql_query("update userInfo set drywallHours=drywallHours+'$jobHours' where userEmail='$Useremail'");   

			}
			else if(strcmp($jobType, "Electrical") == 0)
			{
				$success =  mysql_query("update userInfo set electricalHours=electricalHours+'$jobHours' where userEmail='$Useremail'");   
			}
		
	
			       
			if($success)
			{
			
				echo 'Successfully added';
				$sql = "delete from JobsAssigned where JobID='$removeJob'";
				$deletedJob = mysql_query($sql);
			
				if($deletedJob)
				{
					echo "Job deleted";
					$sql = "update userInfo set JobID='0' where userEmail='$Useremail'";
					$jobremoved = mysql_query($sql);
				
					if($jobremoved)
					{
						echo "Job removed";
					}
				}
				else
				{
					echo "nah the job is still there";
				}
			
	
			}
	
			else
			{
				echo "nah $success";
			}
		}
		else
		{
			echo "no job assigned";
		}

	  

       }
?>
