



<?php

// Name: Artruo Martinez
// Due: May 4, 2016
// Senior Project
// Purpose: The file will check the user login credentials
//          it will detrmine whether the user is a foreman or worker, directing them to the appropriate page.
//	    or if they are in the system. This then is returned to the iOS app. 

	include("connect.php");
	
	      

   session_start();
  

	$Useremail = $_POST['Email'];
      
	$Userpass = $_POST['Password'];

        mysql_select_db("beachelectric");

	$query = "select * from userInfo where userEmail='$Useremail' and userPassword='$Userpass'";


        $q = mysql_query($query);
        
       	

        if(mysql_num_rows($q)>=1)
	{
	    $s = mysql_real_escape_string($Useremail);
	    $_SESSION['userLogin'] = $s;	    

            $check = mysql_fetch_assoc($q);
	    $userCode = $check['userCode'];
	
            if(!empty($userCode))
	    {
		echo "you are a foreman";	
	    }
	    else
	    {
		echo "you are a worker";	
	    }		
	}
	else
	{
		echo "not in the system";	
	} 

?>
