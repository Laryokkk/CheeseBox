<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST");
header("Access-Control-Allow-Headers: X-Requested-With");

require_once(__DIR__.'/connection.php');

$json = file_get_contents('php://input');
$data = json_decode($json, true);
$response = array();

$code = $data["code"];
$quantity = $data["quantity"];
$type = $data["type"];

$stmt = $conn->prepare("CALL insert_milk(?,?,?)");
$stmt->bind_param('sis', $code, $quantity, $type);

if ($stmt->execute()) {
    $result = $stmt->get_result();
    if ($result) {
        $row = $result->fetch_assoc();
        $response = array(
            'data' => $row,
            'status' => 200,
        );
    } else {
        $response = array(
            'data' => "No results found",
            'status' => 201,
        );
    }
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