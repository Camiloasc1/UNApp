
jQuery(document).ready(function() {
	
    /*
        Fullscreen background
    */
    $.backstretch([
					"/login-page/img/1.jpg"
	              ,"/login-page/img/2.jpg"
	              ,"/login-page/img/3.jpg"

	             ], {duration: 4000, fade: 750});
    
    /*
        Form validation
    */
    $('.login-form input[type="text"], .login-form input[type="password"], .login-form textarea').on('focus', function() {
    	$(this).removeClass('input-error');
    });
    
    $('.login-form').on('submit', function(e) {
    	
    	$(this).find('input[type="text"], input[type="password"], textarea').each(function(){
    		if( $(this).val() == "" ) {
    			e.preventDefault();
    			$(this).addClass('input-error');
    		}
    		else {
    			$(this).removeClass('input-error');
    		}
    	});
    	
    });
    
    
});
