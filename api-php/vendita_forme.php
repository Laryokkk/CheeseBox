<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST");
header("Access-Control-Allow-Headers: X-Requested-With");
// error_reporting(0);

$json = file_get_contents('php://input');
$data = json_decode($json, true);
$response = array();
$result = null;

$quantita = $data["quantita"];
$scelta = $data["scelta"];
$stagionatura = $data["stagionatura"];
$nome = $data["nome"];
$iva = $data["iva"];
$prezzo = $data["prezzo"];

require(__DIR__.'/connection.php');
$stmt1 = $conn->prepare("CALL insert_or_get_acquirente_id(?, ?)");
$stmt1->bind_param('ss', $nome, $iva);
$stmt1->execute();
$idAcqirente = $stmt1->get_result();

if ($idAcqirente != null) {
    $idAcqirente = $idAcqirente->fetch_assoc()['id_acquirente'];
    $conn->close();
    
    require(__DIR__.'/connection.php');
    $stmt2 = $conn->prepare("CALL sell_forme(?,?,?,?,?)");
    $stmt2->bind_param('iiisi', $idAcqirente, $prezzo, $stagionatura, $scelta, $quantita);
    $stmt2->execute();
    $result2 = $stmt2->get_result();

    if ($result2 != null) {
        $records = array();
        while ($row = $result2->fetch_assoc()) {
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

} else {
    $response = array(
        'data' => $conn->error,
        'status' => 404,
    );
}

header('Content-Type: application/json');
echo json_encode($response);

$stmt1->close();
$stmt2->close();
$conn->close();
exit();
?>