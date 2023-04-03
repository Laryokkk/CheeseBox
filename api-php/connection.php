<?php
$host = 'localhost:8889';
$username = 'root';
$password = 'root';
$database = 'CheeseBox';

$conn = new mysqli($host, $username, $password, $database);

if ($conn->connect_error) {
    die('Connection failed: ' . $conn->connect_error);
}
?>