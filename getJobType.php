<?php

        include("connect.php");
        include("sessionActive.php");

        mysql_select_db("beachelectric");

        $userEmail =  $_SESSION['userLogin'];

	$sql = "job select JobID from userInfo where userEmail='$userEmail'";

        $query =  mysql_query($sql);

        if($query)
        {

                $value = mysql_fetch_assoc($query);
                $Job_ID = $value['JobID'];

                #then some magic happens where the jobID is returned
		#to be translated

        }

        }

?>
