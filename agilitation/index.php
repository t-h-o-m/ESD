<?php
session_start();


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
        <meta name="description" content="ESD">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link rel="apple-touch-icon" href="./images/Contain'us.png">
        <link rel="shortcut icon" href="./images/Contain'us.png">

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
                    <a class="navbar-brand" href=""><img src="./images/agilitation.png" alt="Logo"></a>
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
                            <div class="user-menu dropdown-menu">
                                <a class="nav-link" href="./deconnexion_administrateur.php"><i class="fa fa-power -off"></i>Déconnexion</a>
                            </div>
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
if (isset($_POST['consumerkey'])) {
    $consumerkey                   = $_POST['consumerkey'];
    $applicationsecret             = $_POST['applicationsecret'];
    $applicationkey                = $_POST['applicationkey'];
    $_SESSION["consumerkey"]       = $consumerkey;
    $_SESSION["applicationsecret"] = $applicationsecret;
    $_SESSION["applicationkey"]    = $applicationkey;
    
    echo "<html>	 
                    	                  <div class=\"row\">
                    <div class=\"col-xs-6 col-sm-12\">
                    <div class=\"card\">
                            <div class=\"card-header\">
							
                                <strong class=\"card-title\">Veuillez sélectionner le projet sur lequel vous souhaitez travailler : </strong>
                            </div>
                            <div class=\"card-body\">
<form method=\"post\" action=\"part2.php\">
  <div class=\"form-group\">
    <label for=\"selectProjects\">Projets : </label>
    <select class=\"form-control\" name=\"selectProjects\">";
    $command   = shell_exec("sudo python script/check_credentials.py -ak $applicationkey -as $applicationsecret -ck $consumerkey");
    $json_data = json_decode($command);
    
    $length = count($json_data);
    for ($i = 0; $i < $length; $i++) {
?>
                        <option name="project" value="<?php
        echo $json_data[$i];
?>">
                            <?php
        echo $json_data[$i];
?>
                        </option>
                        <?php
    }
    echo "
			</select>
            <br />
<input type=\"submit\" style=\"float:right\" class=\"btn btn-primary\" name=\"selection\" value=\"Sélectionner\"/>
                          </div>
			</form>
			</div>
                        </div>
                        </div>
                        </div></html>";
}
?>
                            <div class="row">
                                <div class="col-xs-6 col-sm-6">
                                    <div class="card">
                                        <div class="card-header">
                                            <strong class="card-title">Insérez vos crédentials</strong>
                                        </div>
                                        <div class="card-body">
                                            <form method="post" action="./index.php">
                                                <div class="form-group">
                                                    <label for="consumerkey">Consumer Key</label>
                                                    <input type="text" class="form-control" id="consumerkey" name="consumerkey">
                                                </div>
                                                <div class="form-group">
                                                    <label for="applicationkey">Application Key</label>
                                                    <input type="text" class="form-control" id="applicationkey" name="applicationkey">
                                                </div>
                                                <div class="form-group">
                                                    <label for="applicationsecret">Application Secret</label>
                                                    <input type="text" class="form-control" id="applicationsecret" name="applicationsecret">
                                                </div>
                                                <button type="submit" style="float:right" class="btn btn-primary">Envoyer</button>
                                            </form>


                                        </div>
                                    </div>

                                </div>
                            </div>
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
