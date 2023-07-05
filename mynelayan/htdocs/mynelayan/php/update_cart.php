<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$cartid = $_POST['cartid'];
$newqty = $_POST['newqty'];
$newprice = $_POST['newprice'];

$sql = "UPDATE `tbl_carts` SET `cart_qty`= $newqty ,`cart_price`= $newprice WHERE  `cart_id` = '$cartid'";

if ($conn->query($sql) === TRUE) {
		$response = array('status' => 'success', 'data' => $sql);
		sendJsonResponse($response);
	}else{
		$response = array('status' => 'failed', 'data' => $sql);
		sendJsonResponse($response);
	}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>