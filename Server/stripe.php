<?php
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);
    require_once 'Libraries/stripe-php/init.php';


    \Stripe\Stripe::setApiKey('sk_test_tkEpk0DRXJR9fW0xtYuFBWNW00EAIkSzUW');
    $input = $_POST["amount"];

    $paymentIntent = \Stripe\PaymentIntent::create([
        'amount' => $input,
        'currency' => 'HRK',
    ]);
    
    $output = [
        'clientSecret' => $paymentIntent->client_secret
    ];
    
    echo json_encode($output);

    
?>