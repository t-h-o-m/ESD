<?php
	try
	{
		$userdb='containus';
		$bddpass='soy5Rapr';
		$bdd = new PDO("mysql:host=localhost;dbname=containus", $userdb, $bddpass);
	}
catch (PDOException $e)
	{
	        die('Erreur : '.$e->getMessage());
	}


?>