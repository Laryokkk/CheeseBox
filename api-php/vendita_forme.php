<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST");
header("Access-Control-Allow-Headers: X-Requested-With");
error_reporting(0);

require_once(__DIR__.'/connection.php');

$json = file_get_contents('php://input');
$data = json_decode($json, true);
$response = array();
$result = null;

$code = $data["code"];
$code = $data["code"];
$code = $data["code"];
$code = $data["code"];
$code = $data["code"];
$code = $data["code"];

if (isset($code)) {
    $stmt = $conn->prepare("CALL get_forme_in_stagionatura_by_caseificio(?)");
    $stmt->bind_param('s', $code);
    $stmt->execute();
    $result = $stmt->get_result();
} else {
    $stmt = $conn->prepare("CALL get_forme_in_stagionatura()");
    $stmt->execute();
    $result = $stmt->get_result();
}

if ($result != null) {
    $records = array();
    while ($row = $result->fetch_assoc()) {
        $records[] = $row;
    }
    $response = array(
        'data' => $records,
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