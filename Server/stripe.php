<?php
    /*ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);*/
    require_once 'Libraries/stripe-php/init.php';
    require_once './Database.php';


    \Stripe\Stripe::setApiKey('YOUR STRIPE SECRET KEY');
    $json = file_get_contents('php://input');
    $data = json_decode($json);

    $paymentIntent = \Stripe\PaymentIntent::create([
        'amount' => calculateOrderAmount($data->items, $data->shippment),
        'currency' => $data->currency
    ]);

    function calculateOrderAmount($items, $shippment) {
        $price = getPriceOfProducts($items, $shippment);
        //echo "Price is "+($price*100);
        return ($price*100);
    }


    function getPriceOfProducts($items, $shippment) {
        $db = new Database;
        $products = $db->getProductsForSearch();

        $money = 0;
        foreach ($products as $p) {
            foreach ($items as $value) {
                if($p['id'] == $value){
                    $money += $p['price'];
                }
            }
        }

        if($shippment == "UPS") {
            $money += 10;
        }else {
            $money += 15;
        }
    
        return $money;

    }
    
    $output = [
        'clientSecret' => $paymentIntent->client_secret
    ];
    
    echo json_encode($output);

    
?>
