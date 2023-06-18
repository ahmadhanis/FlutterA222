<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$results_per_page = 10;
if (isset($_POST['pageno'])){
	$pageno = (int)$_POST['pageno'];
}else{
	$pageno = 1;
}
$page_first_result = ($pageno - 1) * $results_per_page;
	
if (isset($_POST['userid'])){
	$userid = $_POST['userid'];	
	$sqlloadcatches = "SELECT * FROM `tbl_catches` WHERE user_id = '$userid'";
}else if (isset($_POST['search'])){
	$search = $_POST['search'];
	$sqlloadcatches = "SELECT * FROM `tbl_catches` WHERE catch_name LIKE '%$search%'";
}else{
	$sqlloadcatches = "SELECT * FROM `tbl_catches`";
}

$result = $conn->query($sqlloadcatches);
$number_of_result = $result->num_rows;
$number_of_page = ceil($number_of_result / $results_per_page);
$sqlloadcatches = $sqlloadcatches . " LIMIT $page_first_result , $results_per_page";
$result = $conn->query($sqlloadcatches);

if ($result->num_rows > 0) {
    $catches["catches"] = array();
	while ($row = $result->fetch_assoc()) {
        $catchlist = array();
        $catchlist['catch_id'] = $row['catch_id'];
        $catchlist['user_id'] = $row['user_id'];
        $catchlist['catch_name'] = $row['catch_name'];
        $catchlist['catch_type'] = $row['catch_type'];
        $catchlist['catch_desc'] = $row['catch_desc'];
        $catchlist['catch_price'] = $row['catch_price'];
        $catchlist['catch_qty'] = $row['catch_qty'];
        $catchlist['catch_lat'] = $row['catch_lat'];
        $catchlist['catch_long'] = $row['catch_long'];
        $catchlist['catch_state'] = $row['catch_state'];
        $catchlist['catch_locality'] = $row['catch_locality'];
		$catchlist['catch_date'] = $row['catch_date'];
        array_push($catches["catches"],$catchlist);
    }
    $response = array('status' => 'success', 'data' => $catches, 'numofpage'=>"$number_of_page",'numberofresult'=>"$number_of_result");
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
