$(function(){
    
    $('#left .main_menu').on('click', function(){
        
        if($(this).next('.sub_menu').hasClass('left_menu_show')){
            $(this).next('.sub_menu').slideUp("normal",function(){
                $(this).removeClass('left_menu_show').addClass('left_menu_hide')
            });	
        } else {	
            $(this).next('.sub_menu').slideDown("normal",function(){
                $(this).removeClass('left_menu_hide').addClass('left_menu_show')
            });		
        }
    })
    
})