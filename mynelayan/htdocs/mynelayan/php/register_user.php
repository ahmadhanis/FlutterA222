<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require '/home4/slumber6/PHPMailer/src/Exception.php';
require '/home4/slumber6/PHPMailer/src/PHPMailer.php';
require '/home4/slumber6/PHPMailer/src/SMTP.php';

if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$name = $_POST['name'];
$email = $_POST['email'];
$phone = $_POST['phone'];
$password = sha1($_POST['password']);
$otp = rand(10000,99999);

$sqlinsert = "INSERT INTO `tbl_users`(`user_email`, `user_name`, `user_phone`, `user_password`, `user_otp`) VALUES ('$email','$name','$phone','$password','$otp')";

if ($conn->query($sqlinsert) === TRUE) {
    mailOtp($email,$name,$otp);
	$response = array('status' => 'success', 'data' => null);
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

function mailOtp($email,$name,$otp){
    $subject = 'MyNelayan - Account Verification';
    $body = "
    <html>
    <head>
    <title></title>
    </head>
    <body>
    <h4>Welcome to MyNelayan</h4>
    <p>Dear $name,<br>
     Thank you for registering your account with us. To complete your registration, please click on the following button/link<br><br>
     <a href ='https://slumberjer.com/mynelayan/php/verify.php?email=$email&otp=$otp'><button>Verify your account</button></a><br><br>
     Once your account has been verified, you can open the MyNelayan app on your phone and login.<br>
    </body>
    </html>
    ";
    $mail = new PHPMailer(true);
        try {
    
        $mail->isSMTP();                                            //Send using SMTP
        $mail->Host       = 'mail.slumberjer.com';                 //Set the SMTP server to send through
        $mail->SMTPAuth   = true;                                   //Enable SMTP authentication
        $mail->Username   = 'mynelayan@slumberjer.com';            //SMTP username
        $mail->Password   = '!@mSNq4hHF5L';                         //SMTP password
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_SMTPS;            //Enable implicit TLS encryption
        $mail->Port       = 465;                                    //TCP port to connect to; use 587 if you have set `SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS`
    
        //Recipients
        $mail->setFrom('mynelayan@slumberjer.com', 'MyNelayan mail notification');
        $mail->addAddress($email, $name);     //Add a recipient
       
       
        //Content
        $mail->isHTML(true);                                  //Set email format to HTML
        $mail->Subject = $subject;
        $mail->Body    = $body;
        $mail->send();
        //echo 'Message has been sent';
    } catch (Exception $e) {
        //echo "Message could not be sent. Mailer Error: {$mail->ErrorInfo}";
    }    
}
?>