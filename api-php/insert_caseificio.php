<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST");
header("Access-Control-Allow-Headers: X-Requested-With");
// error_reporting(0);

$json = file_get_contents('php://input');
$data = json_decode($json, true);
$response = array();

$regione = $data["regione"];
$indirizzio = $data["indirizzio"];
$nome = $data["nome"];
$codice = $data["codice"];
$accountNome = $data["accountNome"];
$accountCognome = $data["accountCognome"];
$email = $data["email"];
$psw = $data["psw"];
$permission = "caseificio_".$codice;

require(__DIR__.'/connection.php');
$stmt1 = $conn->prepare("CALL insert_caseificio(?,?,?,?)");
$stmt1->bind_param('ssss', $codice, $nome, $indirizzio, $regione);
$stmt1->execute();
$conn->close();

require(__DIR__.'/connection.php');

$stmt2 = $conn->prepare("CALL insert_user(?,?,?,?,?)");
$stmt2->bind_param('sssss', $accountNome, $accountCognome, $email, $psw, $permission);
$stmt2->execute();
$result2 = $stmt2->get_result();

$response = array(
    'data' => null,
    'status' => 200,
);

header('Content-Type: application/json');
echo json_encode($response);

$stmt1->close();
$stmt2->close();
$conn->close();
exit();
?>