<?php
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);
    require_once 'Libraries/meekrodb/db.class.php';
    DB::$user = 'Stripe';
    DB::$password = 'stripetest';
    DB::$dbName = 'Store';

    class Database {

        static function getProducts(){
            $results = DB::query("SELECT * FROM Products");
            echo json_encode($results, JSON_NUMERIC_CHECK);
        }

    }

    
?>