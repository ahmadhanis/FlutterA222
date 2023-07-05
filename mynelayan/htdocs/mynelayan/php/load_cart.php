<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");
//SELECT Orders.OrderID, Customers.CustomerName, Orders.OrderDate FROM Orders INNER JOIN Customers ON Orders.CustomerID=Customers.CustomerID;


if (isset($_POST['userid'])){
	$userid = $_POST['userid'];	
	$sqlcart = "SELECT * FROM `tbl_carts` INNER JOIN `tbl_catches` ON tbl_carts.catch_id = tbl_catches.catch_id WHERE tbl_carts.user_id = '$userid'";
}

$result = $conn->query($sqlcart);
if ($result->num_rows > 0) {
    $cartitems["carts"] = array();
	while ($row = $result->fetch_assoc()) {
        $cartlist = array();
        $cartlist['cart_id'] = $row['cart_id'];
        $cartlist['catch_id'] = $row['catch_id'];
        $cartlist['catch_name'] = $row['catch_name'];
        $cartlist['catch_status'] = $row['catch_status'];
        $cartlist['catch_type'] = $row['catch_type'];
        $cartlist['catch_desc'] = $row['catch_desc'];
        $cartlist['catch_qty'] = $row['catch_qty'];
        $cartlist['catch_price'] = $row['catch_price'];
        $cartlist['cart_qty'] = $row['cart_qty'];
        $cartlist['cart_price'] = $row['cart_price'];
        $cartlist['user_id'] = $row['user_id'];
        $cartlist['seller_id'] = $row['seller_id'];
        $cartlist['cart_date'] = $row['cart_date'];
        array_push($cartitems["carts"] ,$cartlist);
    }
    $response = array('status' => 'success', 'data' => $cartitems);
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
