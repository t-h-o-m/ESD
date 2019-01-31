<?php
session_start();
$consumerkey = $_SESSION['consumerkey'];
$applicationsecret = $_SESSION['applicationsecret'];
$applicationkey = $_SESSION['applicationkey'];
$projectid = $_POST['selectProjects'];
$_SESSION['projectid'] = $projectid;
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
        <meta name="description" content="">
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
                    <form action="part3.php" method="post">
                        <div class="form-group">
                            <label for="projectname">Project Name</label>
                            <input type="text" class="form-control" id="projectname" name="projectname" placeholder="Agilitation">
                        </div>
                        <div class="form-group">
                            <label for="region">Region</label>
                            <select class="form-control" id="regionid" name="regionid">
                                <?php
                                $getregion = shell_exec("sudo python script/get_region.py -ak $applicationkey -as $applicationsecret -ck $consumerkey -pid $projectid"); 
                                $json_region = json_decode($getregion); 
				                $length = count($json_region); 
                                    for ($i = 0; $i < $length; $i++) { ?>
                                        <option name="project" value="<?php echo $json_region[$i];?>"><?php echo $json_region[$i];?></option>
                                    <?php
                                     }
                                    ?>
                            </select>
                        </div>
                        <button type="submit" style="float:right" class="btn btn-primary">Suivant</button>
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
