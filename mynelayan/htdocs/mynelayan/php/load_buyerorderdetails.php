<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

if (isset($_POST['buyerid']) && isset($_POST['orderbill'])){
	$buyerid = $_POST['buyerid'];	
	$orderbill = $_POST['orderbill'];
	$sellerid = $_POST['sellerid'];
	$sqlorderdetails = "SELECT * FROM `tbl_orderdetails` INNER JOIN `tbl_catches` ON tbl_orderdetails.catch_id = tbl_catches.catch_id WHERE tbl_orderdetails.buyer_id = '$buyerid' AND tbl_orderdetails.order_bill = '$orderbill' AND tbl_orderdetails.seller_id = '$sellerid'";
}else{
    $sqlorderdetails = "NA";
}

//	$sqlcart = "SELECT * FROM `tbl_carts` INNER JOIN `tbl_catches` ON tbl_carts.catch_id = tbl_catches.catch_id WHERE tbl_carts.user_id = '$userid'";
//`orderdetail_id`, `order_bill`, `catch_id`, `orderdetail_qty`, `orderdetail_paid`, `buyer_id`, `seller_id`, `orderdetail_date`

$result = $conn->query($sqlorderdetails);
if ($result->num_rows > 0) {
    $oderdetails["orderdetails"] = array();
	while ($row = $result->fetch_assoc()) {
        $orderdetailslist = array();
        $orderdetailslist['orderdetail_id'] = $row['orderdetail_id'];
        $orderdetailslist['order_bill'] = $row['order_bill'];
        $orderdetailslist['catch_id'] = $row['catch_id'];
        $orderdetailslist['catch_name'] = $row['catch_name'];
        $orderdetailslist['orderdetail_qty'] = $row['orderdetail_qty'];
        $orderdetailslist['orderdetail_paid'] = $row['orderdetail_paid'];
        $orderdetailslist['buyer_id'] = $row['buyer_id'];
        $orderdetailslist['seller_id'] = $row['seller_id'];
        $orderdetailslist['orderdetail_date'] = $row['orderdetail_date'];
        array_push($oderdetails["orderdetails"] ,$orderdetailslist);
    }
    $response = array('status' => 'success', 'data' => $oderdetails,'mysql'=>$sqlorderdetails);
    sendJsonResponse($response);
}else{
     $response = array('status' => 'failed', 'data' => null, 'mysql'=> $sqlorderdetails);
    sendJsonResponse($response);
}
function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
