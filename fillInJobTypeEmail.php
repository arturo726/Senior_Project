<?php

// Name: Judah Parham, Giovana Mejia
// Due: May 4, 2016
// Senior Project
// Purpose: The file will check the user login credentials
//          it will detrmine whether the user is a foreman or worker, directing them to the appropriate page.
//	    or if they are in the system. This then is returned to the Android app. 

        include("connect.php");
        include("sessionActive.php");

        mysql_select_db("beachelectric");

        $Useremail = mysql_real_escape_string($_POST['userEmail']);

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

