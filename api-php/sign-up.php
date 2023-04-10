<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST");
header("Access-Control-Allow-Headers: X-Requested-With");
error_reporting(0);

require_once(__DIR__.'/connection.php');

$json = file_get_contents('php://input');
$data = json_decode($json, true);
$response = array();

$firstname = $data["firstname"];
$lastname = $data["lastname"];
$email = $data["email"];
$psw = $data["psw"];

$stmt = $conn->prepare("CALL insert_user(?, ?, ?, ?)");
$stmt->bind_param('ssss', $firstname, $lastname, $email, $psw);

if ($stmt->execute()) {
    $result = $stmt->get_result()->fetch_assoc();
    $response = array(
        'data' => $result,
        'status' => 200,
    );
} else {
    $response = array(
        'data' => $conn->error,
        'status' => 404,
    );
}

header('Content-Type: application/json');
echo json_encode($response);

$stmt->close();
$conn->close();
exit();
?>