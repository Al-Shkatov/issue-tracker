(function($){
    $(function(){
        $('#ticket_status_id').change(function(){
            var status_id = $(this).val();
            $.ajax({
                url:base_url+'tickets/change_status',
                type:'post',
                data:{ticket_id:ticket_id,status_id:status_id},
                success:function(response){
                    var mess='You successfuly '+response.type+' ticket';
                    sys_message({level:'success',message:mess})
                }
            });
        });
        $('.reply').click(function(){
            $('#ticket_comment_parent_id').val($(this).data('comment-id'));
            $('#ticket_comment_body').focus();
        });
    });
})(jQuery);