<?php

    $name = "William";

    $results = Array("name" => $name);

    header("Content-Type: application/json");
    echo json_encode($results);

?>