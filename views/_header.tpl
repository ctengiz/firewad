<%
if not defined('show_topbar'):
    setdefault('show_topbar', True)
end

if not defined('show_sidebar'):
    setdefault('show_sidebar', True)
end
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <!--
    @todo
    <link rel="icon" href="../../favicon.ico">
    -->

    <title>Firewad - {{session['db_code']}}</title>

    <!-- Bootstrap core CSS -->
    <link href="/static/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Fontawesome -->
    <link href="/static/font-awesome-4.3.0/css/font-awesome.min.css" rel="stylesheet">

    <!-- Base Css -->
    <link href="/static/base.css" rel="stylesheet">
    <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,800,700,400italic,600italic,700italic,800italic,300italic" rel="stylesheet" type="text/css">


    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>

<!-- Fixed navbar -->
%if show_topbar:
<nav class="navbar navbar-inverse navbar-fixed-top ">
    <div class="container-fluid">

        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a href="javascript:void(0);" class="navbar-brand">
                <span class="fa fa-angle-double-left" data-toggle="offcanvas" title="Maximize Panel"></span>
            </a>
            <a class="navbar-brand" href="/{{session['db_code']}}">{{session['db_code']}}</a>
        </div>

        <div class="collapse navbar-collapse" id="navbar">
            <ul class="nav navbar-nav">
                <li><a href="#">Home</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>

            <ul class="nav navbar-nav navbar-right">
                <li><a href="#">Settings</a></li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Projeler <span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">

                        <!-- todo
                        for adb in appconf.db:
                        <li><a href="/db/{{adb}}">{{adb}}</a></li>
                        end
                        -- >
                    </ul>
                </li>
                <!-- todo
                if session['logged_in']:
                    <li><a href="/system/logout">Logout</a></li>
                else:
                    <li><a href="/system/login">Login</a></li>
                end
                -->
            </ul>
        </div><!--/.nav-collapse -->

    </div>
</nav>
%end

<!-- Begin page content -->
<div class="container-fluid" >
    %if show_sidebar:
    <div class="row row-offcanvas row-offcanvas-left">
        <div class="col-xs-6 col-sm-3 sidebar-offcanvas do-not-print" role="navigation">
            <ul class="list-group menu-list">
                <li class="list-group-item"><i class="glyphicon glyphicon-align-justify"></i> <b>Hızlı Erişim</b></li>
                <li class="list-group-item"><input type="text" class="form-control search-query" placeholder="program kodu"></li>
                <li class="list-group-item" style="font-size: 14px;"><b>Menü</b></li>
                %if 'menu' in session:
                {{!prj_menu_to_html(session['menu'], style='list-group-collapse-only-list')}}
                %end
            </ul>
        </div>

    <div class="col-xs-12 col-sm-9 content">
    %else:
    <div class="col-xs-12 content">
    %end


