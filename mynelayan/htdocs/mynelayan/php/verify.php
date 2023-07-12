<?php
//error_reporting(0);
include_once("dbconnect.php");
$email = $_GET['email'];
$otp = $_GET['otp'];
$sqlverify = "SELECT * FROM tbl_users WHERE user_email = '$email' AND user_otp = '$otp'";
$result = $conn->query($sqlverify);

if ($result->num_rows > 0) {
   $newotp = '1';
   $sqlupdate = "UPDATE tbl_users SET user_otp = '$newotp' WHERE user_email = '$email'";
   if ($conn->query($sqlupdate) === TRUE) {
        echo "<script>alert('Successful. You can now login through the MyNelayan app')</script>";
    }else{
        echo "<script>alert('Failed')</script>";
    }
}else{
     echo "<script>alert('Invalid')</script>";
}
 
?>