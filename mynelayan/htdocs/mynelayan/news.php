<?php

require_once 'php/dbconnect.php';

// Check if form was submitted
if (isset($_POST['news_title']) && isset($_POST['news_detail'])) {
    // Get form data
    $news_title = $_POST['news_title'];
    $news_detail = $_POST['news_detail'];

    // Insert data into database
    $sql = "INSERT INTO tbl_news (news_title, news_detail) VALUES ('$news_title', '$news_detail')";
    $result = $conn->query($sql);

    // Check if data was inserted successfully
    if ($result) {
        echo '<script>alert("Success")</script>';
    } else {
        echo '<script>alert("Failed")</script>';
    }
}

if (isset($_GET['news_id']) && isset($_GET['op'])) {
    // Get form data
    $news_id = $_GET['news_id'];
    $op = $_GET['op'];

    // Insert data into database
    echo $sql = "DELETE FROM `tbl_news` WHERE news_id = '$news_id'";
    $result = $conn->query($sql);

    // Check if data was inserted successfully
    if ($result) {
        echo '<script>alert("Success")</script>';
    } else {
        echo '<script>alert("Failed")</script>';
    }
}

$news="<!DOCTYPE html>
<html>
<head>
<title>News Manager</title>
<link rel='stylesheet' href='https://www.w3schools.com/w3css/4/w3.css'>
</head>
<body>
<div class='w3-container w3-padding' style='max-width:600px;margin:auto'>
<h1>Add News</h1>
<form action='news.php' method='post'>
<div class='w3-container'>
<label for='news_title'>News Title</label>
<input type='text' name='news_title' class='w3-input' required>
</div>
<div class='w3-container w3-padding' >
<label for='news_detail'>News Details</label>
<textarea name='news_detail' class='w3-input w3-border' rows='10' cols='50'></textarea>
</div>
<input type='submit' value='Add News' class='w3-button w3-blue'>
</form>
</div>
</body>
</html>";

echo $news;

$sql = "SELECT * FROM tbl_news";
$result = $conn->query($sql);


// Loop through news data and display it in table
if ($result) {
    // Create table to display news data
echo '<table class="w3-table w3-striped" style="max-width:600px; margin:auto">';
echo '<thead>';
echo '<tr>';
echo '<th>News Title</th>';
echo '<th>News Details</th>';
echo '<th>News Date</th>';
echo '<th>Delete</th>';
echo '</tr>';
echo '</thead>';
echo '<tbody>';

    while ($row = mysqli_fetch_assoc($result)) {
        echo '<tr>';
        echo '<td>' . $row['news_title'] . '</td>';
        echo '<td>' . $row['news_detail'] . '</td>';
        echo '<td>' . date_format(date_create($row['created_at']),'d/m/Y') . '</td>';
        echo '<td><a href="news.php?news_id=' . $row['news_id'] . '&op=delete" class="w3-button w3-red">Delete</a></td>';
        echo '</tr>';
    }
    echo '</tbody>';
echo '</table>';
}
?>

<script>
function deleteNews(id) {
    if (confirm("Are you sure you want to delete this news article?")) {
        window.location.href = "delete_news.php?id=" + id;
    }
}
</script>