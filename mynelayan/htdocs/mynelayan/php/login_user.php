<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

$email = $_POST['email'];
$pass = sha1($_POST['password']);

include_once("dbconnect.php");

$sqllogin = "SELECT * FROM `tbl_users` WHERE user_email = '$email' AND user_password = '$pass'";
$result = $conn->query($sqllogin);

if ($result->num_rows > 0) {
	while ($row = $result->fetch_assoc()) {
		$userarray = array();
		$userarray['id'] = $row['user_id'];
		$userarray['email'] = $row['user_email'];
		$userarray['name'] = $row['user_name'];
		$userarray['phone'] = $row['user_phone'];
		$userarray['password'] = $_POST['password'];
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