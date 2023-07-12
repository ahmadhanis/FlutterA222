<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}
$userid = $_POST['userid'];

include_once("dbconnect.php");

$sqlloaduser = "SELECT * FROM `tbl_users` WHERE user_id = '$userid'";
$result = $conn->query($sqlloaduser);

if ($result->num_rows > 0) {
	while ($row = $result->fetch_assoc()) {
		$userarray = array();
		$userarray['id'] = $row['user_id'];
		$userarray['email'] = $row['user_email'];
		$userarray['name'] = $row['user_name'];
		$userarray['phone'] = $row['user_phone'];
		$userarray['password'] = $row['user_password'];
		$userarray['otp'] = $row['user_otp'];
		$userarray['datereg'] = $row['user_datereg'];
		$response = array('status' => 'success', 'data' => $userarray);
		sendJsonResponse($response);
	}
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