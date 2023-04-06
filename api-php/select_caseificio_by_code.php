<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST");
header("Access-Control-Allow-Headers: X-Requested-With");

require_once(__DIR__.'/connection.php');

$json = file_get_contents('php://input');
$data = json_decode($json, true);
$response = array();

$code = $data["code"];

$stmt = $conn->prepare("CALL select_caseificio_by_code(?)");
$stmt->bind_param('s', $code);

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