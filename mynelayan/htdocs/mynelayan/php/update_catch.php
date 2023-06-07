<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$catchid = $_POST['catchid'];
$catch_name = $_POST['catchname'];
$catch_desc = addslashes($_POST['catchdesc']);
$catch_price = $_POST['catchprice'];
$catch_qty = $_POST['catchqty'];
$catch_type = $_POST['type'];


$sqlupdate = "UPDATE `tbl_catches` SET `catch_name`='$catch_name',`catch_type`='$catch_type',`catch_desc`='$catch_desc',`catch_price`='$catch_price',`catch_qty`='$catch_qty' WHERE `catch_id` = '$catchid'";

if ($conn->query($sqlupdate) === TRUE) {
	$response = array('status' => 'success', 'data' => null);
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