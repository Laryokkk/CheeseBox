<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST");
header("Access-Control-Allow-Headers: X-Requested-With");

$response = array(
    'data' => 'hellooooooo',
    'status' => 200,
);

echo json_encode($response);

exit();
?>