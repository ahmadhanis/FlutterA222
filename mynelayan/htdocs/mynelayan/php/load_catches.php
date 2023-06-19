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

if (isset($_POST['cartuserid'])){
	$cartuserid = $_POST['cartuserid'];
}else{
	$cartuserid = '0';
}

if (isset($_POST['userid'])){
	$userid = $_POST['userid'];	
	$sqlloadcatches = "SELECT * FROM `tbl_catches` WHERE user_id = '$userid'";
	$sqlcart = "SELECT * FROM `tbl_carts` WHERE user_id = '$userid'";
}else if (isset($_POST['search'])){
	$search = $_POST['search'];
	$sqlloadcatches = "SELECT * FROM `tbl_catches` WHERE catch_name LIKE '%$search%'";
	$sqlcart = "SELECT * FROM `tbl_carts` WHERE user_id = '$cartuserid'";
}else{
	$sqlloadcatches = "SELECT * FROM `tbl_catches`";
	$sqlcart = "SELECT * FROM `tbl_carts` WHERE user_id = '$cartuserid'";
}

if (isset($sqlcart)){
	$resultcart = $conn->query($sqlcart);
	$number_of_result_cart = $resultcart->num_rows;
	if ($number_of_result_cart > 0) {
		$totalcart = 0;
		while ($rowcart = $resultcart->fetch_assoc()) {
			$totalcart = $totalcart+ $rowcart['cart_qty'];
		}
	}else{
		$totalcart = 0;
	}
}else{
	$totalcart = 0;
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
    $response = array('status' => 'success', 'data' => $catches, 'numofpage'=>"$number_of_page",'numberofresult'=>"$number_of_result", 'cartqty'=> $totalcart);
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
