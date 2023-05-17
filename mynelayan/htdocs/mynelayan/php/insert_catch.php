<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$catch_name = $_POST['catchname'];
$catch_desc = $_POST['catchdesc'];
$catch_price = $_POST['catchprice'];
$catch_qty = $_POST['catchqty'];
$catch_type = $_POST['type'];
$image = $_POST['image'];

$sqlinsert = "INSERT INTO `tbl_catches`(`catch_name`, `catch_desc`, `catch_type`, `catch_price`, `catch_qty`) VALUES ('$catch_name ','$catch_desc','$catch_type','$catch_price','$catch_qty')";

if ($conn->query($sqlinsert) === TRUE) {
	$filename = mysqli_insert_id($conn);
	$response = array('status' => 'success', 'data' => null);
	$decoded_string = base64_decode($image);
	$path = '../assets/catches/'.$filename.'.png';
	file_put_contents($path, $decoded_string);
    sendJsonResponse($response);
}else{
	$response = array('status' => 'failed', 'data' => null);
	sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>