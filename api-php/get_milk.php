<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST");
header("Access-Control-Allow-Headers: X-Requested-With");

require_once(__DIR__.'/connection.php');

$json = file_get_contents('php://input');
$data = json_decode($json, true);
$response = array();
$result = null;

$start = $data["start"];
$end = $data["end"];
$code = $data["code"];

if (isset($code)) {
    if (isset($start) && isset($end)) {
        $stmt = $conn->prepare("CALL get_milk_by_caseificio_and_range(?,?,?)");
        $stmt->bind_param('sss', $start, $end, $code);
        $stmt->execute();
        $result = $stmt->get_result();
    } else {
        $stmt = $conn->prepare("CALL get_milk_by_caseificio(?)");
        $stmt->bind_param('s', $code);
        $stmt->execute();
        $result = $stmt->get_result();
    }
} else {
    if (isset($start) && isset($end)) {
        $stmt = $conn->prepare("CALL get_milk_by_range(?,?)");
        $stmt->bind_param('ss', $start, $end);
        $stmt->execute();
        $result = $stmt->get_result();
    } else {
        $stmt = $conn->prepare("CALL get_milk()");
        $stmt->execute();
        $result = $stmt->get_result();
    }
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