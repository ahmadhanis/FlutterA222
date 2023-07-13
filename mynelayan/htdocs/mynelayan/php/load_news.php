<?php

include_once("dbconnect.php");

$sqlloadnews = "SELECT * FROM `tbl_news` ORDER BY created_at";
$result = $conn->query($sqlloadnews);

if ($result->num_rows > 0) {
    $newsdata["news"] = array();
	while ($row = $result->fetch_assoc()) {
	    $newslist = array();
	    $newslist['news_id'] = $row['news_id'];
	    $newslist['news_title'] = $row['news_title'];
	    $newslist['news_detail'] = $row['news_detail'];
	    $newslist['created_at'] = $row['created_at'];
	    array_push($newsdata["news"],$newslist);
	}
	$response = array('status' => 'success', 'data' => $newsdata);
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