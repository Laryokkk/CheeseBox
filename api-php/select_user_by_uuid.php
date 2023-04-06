<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST");
header("Access-Control-Allow-Headers: X-Requested-With");

require_once(__DIR__.'/connection.php');

$json = file_get_contents('php://input');
$data = json_decode($json, true);
$response = array();

$uuid = $data["uuid"];

$stmt = $conn->prepare("CALL select_user_by_uuid(?)");
$stmt->bind_param('s', $uuid);

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