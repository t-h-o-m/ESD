<?php
session_start();
$consumerkey = $_SESSION['consumerkey'];
$applicationsecret = $_SESSION['applicationsecret'];
$applicationkey = $_SESSION['applicationkey'];
$projectid = $_SESSION['projectid'] ;
$projectname = $_SESSION['projectname'];
$regionid = $_SESSION['regionid'] ;

if (isset($_POST['sshkey'])){
$sshkey = $_POST['sshkey'];
$flavorid = $_POST['flavorid'];

$_SESSION['sshkey'] = $sshkey;
$_SESSION['flavorid'] = $flavorid;
}

?>
    <!doctype html>
    <!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
    <!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
    <!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
    <!--[if gt IE 8]><!-->
    <html class="no-js" lang="">
    <!--<![endif]-->

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>ESD</title>
        <meta name="description" content="Sufee Admin - HTML5 Admin Template">
        <meta name="viewport" content="width=device-width, initial-scale=1">

 

        <link rel="stylesheet" href="./assets/css/normalize.css">
        <link rel="stylesheet" href="./assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="./assets/css/font-awesome.min.css">
        <link rel="stylesheet" href="./assets/css/themify-icons.css">
        <link rel="stylesheet" href="./assets/css/flag-icon.min.css">
        <link rel="stylesheet" href="./assets/css/cs-skin-elastic.css">
        <!-- <link rel="stylesheet" href="assets/css/bootstrap-select.less"> -->
        <link rel="stylesheet" href="./assets/scss/style.css">
        <link rel="stylesheet" href="./assets/css/lib/chosen/chosen.min.css">

        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800' rel='stylesheet' type='text/css'>

        <!-- <script type="text/javascript" src="https://cdn.jsdelivr.net/html5shiv/3.7.3/html5shiv.min.js"></script> -->

    </head>

    <body>
        <!-- Left Panel -->
        <aside id="left-panel" class="left-panel">
            <nav class="navbar navbar-expand-sm navbar-default">
                <div class="navbar-header">
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#main-menu" aria-controls="main-menu" aria-expanded="false" aria-label="Toggle navigation">
                        <i class="fa fa-bars"></i>
                    </button>
           
                </div>
                <div id="main-menu" class="main-menu collapse navbar-collapse">
                    <ul class="nav navbar-nav">
                        <li>
                            <a href="./index.php"> <i class="menu-icon fa fa-dashboard"></i>Tableau de bord </a>

                    </ul>
                </div>
            </nav>
        </aside>
        <!-- Right Panel -->
        <div id="right-panel" class="right-panel">
            <!-- Header-->
            <header id="header" class="header">
                <div class="header-menu">
                    <div class="col-sm-7">
                        <a id="menuToggle" class="menutoggle pull-left"><i class="fa fa fa-tasks"></i></a>
                    </div>
                    <div class="col-sm-5">
                        <div class="user-area dropdown float-right">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">

                            </a>

                        </div>
                    </div>
                </div>
            </header>
            <!-- Header-->

            <div class="breadcrumbs">
                <div class="col-sm-4">
                    <div class="page-header float-left">
                        <div class="page-title">
                            <h1>Création d'une instance</h1>
                        </div>
                    </div>
                </div>
                <div class="col-sm-8">
                    <div class="page-header float-right">
                        <div class="page-title">
                            <ol class="breadcrumb text-right">
                                <li><a href="">Création d'une instance</a></li>

                            </ol>
                        </div>
                    </div>
                </div>
            </div>

            <div class="content mt-3">
                <div class="animated fadeIn">
                    <?php
                    if (isset($_POST['confirm'])) {
$flavorid = $_SESSION['flavorid'];
$sshkey = $_SESSION['sshkey']; 
$imageid = $_SESSION['imageid']; 
    
    $createinstance = shell_exec("sudo sh master.sh $projectname $regionid $flavorid $imageid $sshkey $applicationkey $applicationsecret $consumerkey $projectid"); 
                      $machine1 = shell_exec("sudo cat resultat.json"); 
                      $machine2 = shell_exec("sudo cat resultat2.json"); 
                      $machine3 = shell_exec("sudo cat resultat3.json"); 

                    ?>
                            <div class="alert alert-success" role="alert">
                                <h4 class="alert-heading">Succès !</h4>
                                <p>Vous avez bien creer les 3 machines virtuelles chez OVH. Elles ont les IPs suivantes :.</p>
                                <hr>
                                <p class="mb-0">Machine 1 : <?php echo $machine1 ?>/ Machine 2 : <?php echo $machine2 ?>/ Machine 3 : <?php echo $machine3 ?></p>
                            </div>
                            <textarea id='myText'  rows="30" cols="225"><?php echo $createinstance; ?></textarea>
<?php } ?>                        
<form action="" method="post">
                            <div class="form-group">
                                <label for="projectname">Project Name</label>
                                <input type="text" readonly class="form-control" id="projectname" value="<?php echo $projectname ?>">
                            </div>
                            <div class="form-group">
                                <label for="regionid">Region</label>
                                <input type="text" readonly class="form-control" id="regionid" value="<?php echo $regionid ?>">
                            </div>
                            <div class="form-group">
                                <label for="regionid">Flavor id</label>
                                <input type="text" readonly class="form-control" id="regionid" value="<?php echo $flavorid ?>">
                            </div>
                            <div class="form-group">
                                <label for="regionid">SSH Key</label>
                                <input type="text" readonly class="form-control" id="sshkey" value="<?php echo $sshkey ?>">
                            </div>
                            <div class="form-group">
                                <label for="image">Image id</label>
                                <?php
                                $getimage = shell_exec("sudo python script/get_images.py -ak $applicationkey -as $applicationsecret -ck $consumerkey -rid $regionid -pid $projectid"); 
                                $json_image = json_decode($getimage, true); 
				                $length = count($json_image); 
                                    for ($i = 0; $i < $length; $i++) { 
					if ($json_image[$i]['name'] == "Debian 9"){
					?>

                                    <input type="text" readonly class="form-control" id="imageid" value="<?php echo $json_image[$i]['id'];?>" placeholder="<?php echo " Image : ".$json_image[$i]['name'];?>">
                                    <?php
                        $_SESSION['imageid'] = $json_image[$i]['id'];
					} else { }
                                     }
                                    ?>

                            </div>
                            <?php
                        if (!isset($_POST['confirm'])) {

    ?>
                                <button type="submit" style="float:right" name="confirm" class="btn btn-primary">Confirmer</button>
                                <?php
                        }
                            ?>
                        </form>
                </div>
            </div>

        </div>


        <script src="./assets/js/vendor/jquery-2.1.4.min.js"></script>
        <script src="./assets/js/popper.min.js"></script>
        <script src="./assets/js/plugins.js"></script>
        <script src="./assets/js/main.js"></script>
        <script src="./assets/js/lib/chosen/chosen.jquery.min.js"></script>

        <script>
            jQuery(document).ready(function () {
                jQuery(".standardSelect").chosen({
                    disable_search_threshold: 10,
                    no_results_text: "Oops, nothing found!",
                    width: "100%"
                });
            });
        </script>

    </body>

    </html>
