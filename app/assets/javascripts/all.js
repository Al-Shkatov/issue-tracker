var sys_message = function(opts){
    var defaults={
        level:'notify',
        message:'System Notify',
        delay:2000
    };
    for(var i in defaults){
        if(opts.hasOwnProperty(i)){
            defaults[i] = opts[i]
        }
    }
    var message_container = $('<div />',{
        'class':'system-notify level-'+defaults.level+' text-center',
        'text':defaults.message,
    });
    $('.inner').prepend(message_container);
    setTimeout(function(){message_container.remove();},defaults.delay);
};

