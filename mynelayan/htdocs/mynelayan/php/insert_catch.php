<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$userid = $_POST['userid'];
$catch_name = $_POST['catchname'];
$catch_desc = $_POST['catchdesc'];
$catch_price = $_POST['catchprice'];
$catch_qty = $_POST['catchqty'];
$catch_type = $_POST['type'];
$latitude = $_POST['latitude'];
$longitude = $_POST['longitude'];
$state = $_POST['state'];
$locality = $_POST['locality'];
$image = $_POST['image'];
$status = "New";
$sqlinsert = "INSERT INTO `tbl_catches`(`user_id`,`catch_name`, `catch_desc`, `catch_type`, `catch_price`, `catch_qty`, `catch_lat`, `catch_long`, `catch_state`, `catch_locality`, `catch_status`) VALUES ('$userid','$catch_name','$catch_desc','$catch_type','$catch_price','$catch_qty','$latitude','$longitude','$state','$locality','New')";

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