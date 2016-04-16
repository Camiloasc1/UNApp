<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <link href="${request.contextPath}/welcome-index/css/freelancer.css" rel="stylesheet">
</head>

<body>
<!-- Header -->
<header>
    <div class="container_image">
        <img class="img-responsive main_image" src="${request.contextPath}/welcome-index/img/welcome.jpg" alt="">
        <div class="row window_search" >
            <div id="custom-search-input" class="col-xs-12 col-sm-8 col-sm-offset-2 col-lg-6 col-lg-offset-3">
                <img class="img-responsive main_unapp search-logo" src="${assetPath(src: 'search_logo.png')}" alt="">

                <form method = "get" action = "course/search" >
                    <div class="input-group">
                        <input style ="color: #41AF8A" name="query" type="text" class="form-control input-lg" placeholder="Buscar un Profesor o Materia..."/>
                        <span class="input-group-btn">
                            <button class="btn btn-info btn-lg" type="submit">
                                <i class="glyphicon glyphicon-search"></i>
                            </button>
                        </span>
                    </div>
                </form>


            </div>
        </div>
    </div>
</header>

<!-- Portfolio Grid Section -->
<section id="portfolio">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <h2>Desarrolladores</h2>
                <hr class="star-primary">
            </div>
        </div>

        <div class="row">
            <div class="col-sm-4 portfolio-item">
                <a href="#portfolioModal1" class="portfolio-link" data-toggle="modal">
                    <div class="caption">
                        <div class="caption-content">
                            <i class="fa fa-search-plus fa-3x"></i>
                        </div>
                    </div>
                    <img src="${request.contextPath}/welcome-index/img/desarroladores/Kevin.jpg" class="img-responsive"
                         alt="">
                </a>
            </div>

            <div class="col-sm-4 portfolio-item">
                <a href="#portfolioModal2" class="portfolio-link" data-toggle="modal">
                    <div class="caption">
                        <div class="caption-content">
                            <i class="fa fa-search-plus fa-3x"></i>
                        </div>
                    </div>
                    <img src="${request.contextPath}/welcome-index/img/desarroladores/Mauricio.jpg"
                         class="img-responsive" alt="">
                </a>
            </div>

            <div class="col-sm-4 portfolio-item">
                <a href="#portfolioModal3" class="portfolio-link" data-toggle="modal">
                    <div class="caption">
                        <div class="caption-content">
                            <i class="fa fa-search-plus fa-3x"></i>
                        </div>
                    </div>
                    <img src="${request.contextPath}/welcome-index/img/desarroladores/Camilo.jpg" class="img-responsive"
                         alt="">
                </a>
            </div>

            <div class="col-sm-4 portfolio-item">
                <a href="#portfolioModal4" class="portfolio-link" data-toggle="modal">
                    <div class="caption">
                        <div class="caption-content">
                            <i class="fa fa-search-plus fa-3x"></i>
                        </div>
                    </div>
                    <img src="${request.contextPath}/welcome-index/img/desarroladores/Dorian.png" class="img-responsive"
                         alt="">
                </a>
            </div>

            <div class="col-sm-4 portfolio-item">
                <a href="#portfolioModal5" class="portfolio-link" data-toggle="modal">
                    <div class="caption">
                        <div class="caption-content">
                            <i class="fa fa-search-plus fa-3x"></i>
                        </div>
                    </div>
                    <img src="${request.contextPath}/welcome-index/img/desarroladores/logo_big.png"
                         class="img-responsive" alt="">
                </a>
            </div>

            <div class="col-sm-4 portfolio-item">
                <a href="#portfolioModal6" class="portfolio-link" data-toggle="modal">
                    <div class="caption">
                        <div class="caption-content">
                            <i class="fa fa-search-plus fa-3x"></i>
                        </div>
                    </div>
                    <img src="${request.contextPath}/welcome-index/img/desarroladores/Diego.png" class="img-responsive"
                         alt="">
                </a>
            </div>
        </div>
    </div>
</section>

<!-- About Section -->
<section class="success" id="about">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <h2>Acerca</h2>
                <hr class="star-light">
            </div>
        </div>

        <div class="row">
            <div class="col-lg-4 col-lg-offset-2">
                <p>Freelancer is a free bootstrap theme created by Start Bootstrap. The download includes the complete source files including HTML, CSS, and JavaScript as well as optional LESS stylesheets for easy customization.</p>
            </div>

            <div class="col-lg-4">
                <p>Whether you're a student looking to showcase your work, a professional looking to attract clients, or a graphic artist looking to share your projects, this template is the perfect starting point!</p>
            </div>
        </div>
    </div>
</section>

<!-- Contact Section -->
<section id="contact">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <h2>Contactanos</h2>
                <hr class="star-primary">
            </div>
        </div>

        <div class="row">
            <div class="col-lg-8 col-lg-offset-2">
                <!-- To configure the contact form email address, go to mail/contact_me.php and update the email address in the PHP file on line 19. -->
                <!-- The form should work on most web servers, but if the form is not working you may need to configure your web server differently. -->
                <form name="sentMessage" id="contactForm" novalidate>
                    <div class="row control-group">
                        <div class="form-group col-xs-12 floating-label-form-group controls">
                            <label>Name</label>
                            <input type="text" class="form-control" placeholder="Name" id="name" required
                                   data-validation-required-message="Please enter your name.">

                            <p class="help-block text-danger"></p>
                        </div>
                    </div>

                    <div class="row control-group">
                        <div class="form-group col-xs-12 floating-label-form-group controls">
                            <label>Email Address</label>
                            <input type="email" class="form-control" placeholder="Email Address" id="email" required
                                   data-validation-required-message="Please enter your email address.">

                            <p class="help-block text-danger"></p>
                        </div>
                    </div>

                    <div class="row control-group">
                        <div class="form-group col-xs-12 floating-label-form-group controls">
                            <label>Phone Number</label>
                            <input type="tel" class="form-control" placeholder="Phone Number" id="phone" required
                                   data-validation-required-message="Please enter your phone number.">

                            <p class="help-block text-danger"></p>
                        </div>
                    </div>

                    <div class="row control-group">
                        <div class="form-group col-xs-12 floating-label-form-group controls">
                            <label>Message</label>
                            <textarea rows="5" class="form-control" placeholder="Message" id="message" required
                                      data-validation-required-message="Please enter a message."></textarea>

                            <p class="help-block text-danger"></p>
                        </div>
                    </div>
                    <br>

                    <div id="success"></div>

                    <div class="row">
                        <div class="form-group col-xs-12">
                            <button type="submit" class="btn btn-success btn-lg">Enviar</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

<!-- Footer-->
<footer class="text-center">
    <!--<div class="footer-above">
        <div class="container">
            <div class="row">
                <div class="footer-col col-md-4">
                    <h3>Location</h3>
                    <p>3481 Melrose Place<br>Beverly Hills, CA 90210</p>
                </div>
                <div class="footer-col col-md-4">
                    <h3>Around the Web</h3>
                    <ul class="list-inline">
                        <li>
                            <a href="#" class="btn-social btn-outline"><i class="fa fa-fw fa-facebook"></i></a>
                        </li>
                        <li>
                            <a href="#" class="btn-social btn-outline"><i class="fa fa-fw fa-google-plus"></i></a>
                        </li>
                        <li>
                            <a href="#" class="btn-social btn-outline"><i class="fa fa-fw fa-twitter"></i></a>
                        </li>
                        <li>
                            <a href="#" class="btn-social btn-outline"><i class="fa fa-fw fa-linkedin"></i></a>
                        </li>
                        <li>
                            <a href="#" class="btn-social btn-outline"><i class="fa fa-fw fa-dribbble"></i></a>
                        </li>
                    </ul>
                </div>
                <div class="footer-col col-md-4">
                    <h3>About Freelancer</h3>
                    <p>Freelance is a free to use, open source Bootstrap theme created by <a href="http://startbootstrap.com">Start Bootstrap</a>.</p>
                </div>
            </div>
        </div>
    </div>-->
    <div class="footer-below">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    Copyright &copy; UN-App 2016
                </div>
            </div>
        </div>
    </div>
</footer>

<!-- Scroll to Top Button (Only visible on small and extra-small screen sizes) -->
<div class="scroll-top page-scroll visible-xs visible-sm">
    <a class="btn btn-primary" href="#page-top">
        <i class="fa fa-chevron-up"></i>
    </a>
</div>

<!-- Portfolio Modals -->
<div class="portfolio-modal modal fade" id="portfolioModal1" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-content">
        <div class="close-modal" data-dismiss="modal">
            <div class="lr">
                <div class="rl">
                </div>
            </div>
        </div>

        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2">
                    <div class="modal-body">
                        <h2>Kevin Castro</h2>
                        <hr class="star-primary">
                        <img src="${request.contextPath}/welcome-index/img/desarroladores/Kevin.jpg"
                             class="img-responsive img-centered" alt="">

                        <p>Info sobre Kevin</p>
                        <ul class="list-inline item-details">
                            <li>Facebook:
                                <strong><a href="https://www.facebook.com/KeCastroPo">Kevin</a>
                                </strong>
                            </li>
                            <li>Correo:
                                <strong><a href="mailto:keacastropo@unal.edu.co">Kevin</a>
                                </strong>
                            </li>
                            <li>Github:
                                <strong><a href="https://github.com/kecastro">Kevin</a>
                                </strong>
                            </li>
                        </ul>
                        <button type="button" class="btn btn-default" data-dismiss="modal"><i
                                class="fa fa-times"></i> Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="portfolio-modal modal fade" id="portfolioModal2" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-content">
        <div class="close-modal" data-dismiss="modal">
            <div class="lr">
                <div class="rl">
                </div>
            </div>
        </div>

        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2">
                    <div class="modal-body">
                        <h2>Mauricio Rondon</h2>
                        <hr class="star-primary">
                        <img src="${request.contextPath}/welcome-index/img/desarroladores/Mauricio.jpg"
                             class="img-responsive img-centered" alt="">

                        <p>Info sobre Mauricio</p>
                        <ul class="list-inline item-details">
                            <li>Facebook:
                                <strong><a href="https://www.facebook.com/andres.rondon.73">Mauricio</a>
                                </strong>
                            </li>
                            <li>Correo:
                                <strong><a href="mailto:keacastropo@unal.edu.co">Mauricio</a>
                                </strong>
                            </li>
                            <li>Github:
                                <strong><a href="https://github.com/Camiloasc1">Mauricio</a>
                                </strong>
                            </li>
                        </ul>
                        <button type="button" class="btn btn-default" data-dismiss="modal"><i
                                class="fa fa-times"></i> Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="portfolio-modal modal fade" id="portfolioModal3" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-content">
        <div class="close-modal" data-dismiss="modal">
            <div class="lr">
                <div class="rl">
                </div>
            </div>
        </div>

        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2">
                    <div class="modal-body">
                        <h2>Camilo Sanchez</h2>
                        <hr class="star-primary">
                        <img src="${request.contextPath}/welcome-index/img/desarroladores/Camilo.jpg"
                             class="img-responsive img-centered" alt="">

                        <p>Info sobre Camilo</p>
                        <ul class="list-inline item-details">
                            <li>Facebook:
                                <strong><a href="https://www.facebook.com/camiloandres.sanchezcubillos.5">Camilo</a>
                                </strong>
                            </li>
                            <li>Correo:
                                <strong><a href="mailto:keacastropo@unal.edu.co">Camilo</a>
                                </strong>
                            </li>
                            <li>Github:
                                <strong><a href="https://github.com/Camiloasc1">Camilo</a>
                                </strong>
                            </li>
                        </ul>
                        <button type="button" class="btn btn-default" data-dismiss="modal"><i
                                class="fa fa-times"></i> Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="portfolio-modal modal fade" id="portfolioModal4" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-content">
        <div class="close-modal" data-dismiss="modal">
            <div class="lr">
                <div class="rl">
                </div>
            </div>
        </div>

        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2">
                    <div class="modal-body">
                        <h2>Dorian Abad</h2>
                        <hr class="star-primary">
                        <img src="${request.contextPath}/welcome-index/img/desarroladores/Dorian.png"
                             class="img-responsive img-centered" alt="">

                        <p>Info sobre Dorian</p>
                        <ul class="list-inline item-details">
                            <li>Facebook:
                                <strong><a href="https://www.facebook.com/dorian.abath">Dorian</a>
                                </strong>
                            </li>
                            <li>Correo:
                                <strong><a href="mailto:keacastropo@unal.edu.co">Dorian</a>
                                </strong>
                            </li>
                            <li>Github:
                                <strong><a href="https://github.com/kecastro">Dorian</a>
                                </strong>
                            </li>
                        </ul>
                        <button type="button" class="btn btn-default" data-dismiss="modal"><i
                                class="fa fa-times"></i> Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="portfolio-modal modal fade" id="portfolioModal5" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-content">
        <div class="close-modal" data-dismiss="modal">
            <div class="lr">
                <div class="rl">
                </div>
            </div>
        </div>

        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2">
                    <div class="modal-body">
                        <h2>UN-APP</h2>
                        <hr class="star-primary">
                        <img src="${request.contextPath}/welcome-index/img/desarroladores/logo_big.png"
                             class="img-responsive img-centered" alt="">

                        <p>Info sobre la aplicacion</p>
                        <ul class="list-inline item-details">
                            <li>Facebook:
                                <strong><a href="https://www.facebook.com/diego.rojas.37266136">UN-App</a>
                                </strong>
                            </li>
                            <li>Correo:
                                <strong><a href="mailto:keacastropo@unal.edu.co">UN-App</a>
                                </strong>
                            </li>
                            <li>Github:
                                <strong><a href="https://github.com/kecastro">UN-App</a>
                                </strong>
                            </li>
                        </ul>
                        <button type="button" class="btn btn-default" data-dismiss="modal"><i
                                class="fa fa-times"></i> Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="portfolio-modal modal fade" id="portfolioModal6" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-content">
        <div class="close-modal" data-dismiss="modal">
            <div class="lr">
                <div class="rl">
                </div>
            </div>
        </div>

        <div class="container">
            <div class="row">
                <div class="col-lg-8 col-lg-offset-2">
                    <div class="modal-body">
                        <h2>Diego Rojas</h2>
                        <hr class="star-primary">
                        <img src="${request.contextPath}/welcome-index/img/desarroladores/Diego.png"
                             class="img-responsive img-centered" alt="">

                        <p>Info sobre Diego</p>
                        <ul class="list-inline item-details">
                            <li>Facebook:
                                <strong><a href="https://www.facebook.com/diego.rojas.37266136">Diego</a>
                                </strong>
                            </li>
                            <li>Correo:
                                <strong><a href="mailto:keacastropo@unal.edu.co">Diego</a>
                                </strong>
                            </li>
                            <li>Github:
                                <strong><a href="https://github.com/kecastro">Diego</a>
                                </strong>
                            </li>
                        </ul>
                        <button type="button" class="btn btn-default" data-dismiss="modal"><i
                                class="fa fa-times"></i> Close</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
