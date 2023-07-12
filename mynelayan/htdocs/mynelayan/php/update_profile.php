<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

if (isset($_POST['image'])) {
    $image = $_POST['image'];
    $userid = $_POST['userid'];
    
    $decoded_string = base64_decode($image);
	$path = '../assets/profileimages/'.$userid.'.png';
	file_put_contents($path, $decoded_string);
	$response = array('status' => 'success', 'data' => null);
    sendJsonResponse($response);
    // $decoded_string = base64_decode($encoded_string);
    // $path = '../assets/profileimages/' . $userid . '.png';
    // if (file_put_contents($path, $decoded_string)){
    //     $response = array('status' => 'success', 'data' => null);
    //     sendJsonResponse($response);
    // }else{
    //     $response = array('status' => 'failed', 'data' => null);
    //     sendJsonResponse($response);
    // }
    die();
}

if (isset($_POST['newphone'])) {
    $phone = $_POST['newphone'];
    $userid = $_POST['userid'];
    $sqlupdate = "UPDATE tbl_users SET user_phone ='$phone' WHERE user_id = '$userid'";
    databaseUpdate($sqlupdate);
    die();
}

if (isset($_POST['oldpass'])) {
    $oldpass = sha1($_POST['oldpass']);
    $newpass = sha1($_POST['newpass']);
    $userid = $_POST['userid'];
    include_once("dbconnect.php");
    $sqllogin = "SELECT * FROM tbl_users WHERE user_id = '$userid' AND user_password = '$oldpass'";
    $result = $conn->query($sqllogin);
    if ($result->num_rows > 0) {
    	$sqlupdate = "UPDATE tbl_users SET user_password ='$newpass' WHERE user_id = '$userid'";
            if ($conn->query($sqlupdate) === TRUE) {
                $response = array('status' => 'success', 'data' => null);
                sendJsonResponse($response);
            } else {
                $response = array('status' => 'failed', 'data' => null);
                sendJsonResponse($response);
            }
    }else{
        $response = array('status' => 'failed', 'data' => null);
        sendJsonResponse($response);
    }
}

if (isset($_POST['newname'])) {
    $name = $_POST['newname'];
    $userid = $_POST['userid'];
    $sqlupdate = "UPDATE tbl_users SET user_name ='$name' WHERE user_id = '$userid'";
    databaseUpdate($sqlupdate);
    die();
}


function databaseUpdate($sql){
    include_once("dbconnect.php");
    if ($conn->query($sql) === TRUE) {
        $response = array('status' => 'success', 'data' => null);
        sendJsonResponse($response);
    } else {
        $response = array('status' => 'failed', 'data' => null);
        sendJsonResponse($response);
    }
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>