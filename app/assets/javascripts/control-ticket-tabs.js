(function($) {
    $(function() {
        var cache = {
            unassigned: 0,
            open: 0,
            hold: 0,
            closed: 0
        };
        var controls = ['reply', 'change-status', 'details'];
        var load_tickets = function(type, offset) {
            $.ajax({
                type: 'POST',
                url: base_url + 'control/get_tickets',
                data: {type: type, offset: offset},
                success: function(response) {
                    if (response.length === 0) {
                        cache[type] = -1;
                    }
                    html_tickets($('#' + type), response);
                }
            });
        };
        var html_tickets = function(cont, tickets) {
            for (var i in tickets) {
                cont.append(tpl_ticket(tickets[i]));
            }
        };
        var tpl_ticket = function(ticket) {
            var container = $('<div />', {'class': 'control-ticket-item'});
            container.append($('<h4 />', {'class': 'ticket-title', text: ticket.subject}));
            container.append($('<p />', {text: ticket.body}));
            container.append($('<input />', {name: 'ticket_data', type: 'hidden', value: JSON.stringify(ticket)}));
            var control = $('<div />', {'class': 'controls'});
            for (var i in controls) {
                var text = controls[i].replace(/\-/g, ' ');
                control.append($('<a />',
                        {
                            'class': 'btn btn-default control-button',
                            'data-type': controls[i],
                            text: text
                        }));
            }
            container.append(control);
            return container;
        };
        load_tickets('unassigned', cache.unassigned);
        cache.unassigned += per_load;

        $('a[data-toggle="tab"]').on('shown.bs.tab', function(e) {
            var type = $(e.target).attr('href').replace('#', '');
            if (cache[type] === 0) {
                load_tickets(type, cache[type]);
                cache[type] += per_load;
            }
        });
        $('.load-more').click(function() {
            var type = $('.tab-pane.active').attr('id');
            if (cache[type] > 0) {
                load_tickets(type, cache[type]);
                cache[type] += per_load;
            }
        });
        $(document).delegate('.control-button', 'click', function() {
            var method = $(this).data('type');
            if (control_methods.hasOwnProperty(method) && typeof control_methods[method] == 'function') {
                var ticket = JSON.parse($(this).parents('.control-ticket-item').find('input[type="hidden"]').val());
                control_methods[method]($(this), ticket);
            }
        });
        $(document).delegate('input[name="change_status"]', 'change', function() {
            var ticket_wrap = $(this).parents('.control-ticket-item');
            ticket_wrap.find('a[data-type="change-status"]').popover('hide');
            var ticket = JSON.parse(ticket_wrap.find('input[type="hidden"]').val());
            var status_id = $(this).val();
            $.ajax({
                url:base_url+'tickets/change_status',
                type:'post',
                data:{ticket_id:ticket.id,status_id:status_id},
                success:function(response){
                    console.log(response);
                    var to = $('#'+response.type);
                    var animate_block=$('<div />').css({
                        'position':'absolute',
                        'left':ticket_wrap.offset().left,
                        'top':ticket_wrap.offset().top
                    });
                    animate_block.append(ticket_wrap.clone());
                    $('body').append(animate_block);
                    ticket_wrap.hide();
                    animate_block.animate({
                        'left':$('a[href="#'+response.type+'"]').offset().left,
                        'top':$('a[href="#'+response.type+'"]').offset().top,
                        'opacity':0
                    },900,function(){
                        $(this).remove();
                        to.prepend(ticket_wrap);
                        ticket_wrap.show();
                        
                    });
                }
            });
        });
        $(document).delegate('.control-button', 'shown.bs.popover', function() {
            var ticket = JSON.parse($(this).parents('.control-ticket-item').find('input[type="hidden"]').val());
            $(this).parent()
                    .find('input[name="change_status"][value="' + ticket.ticket_status_id + '"]')
                    .attr('checked', 'checked');
        });
        var control_methods = {
            details: function(elem, ticket) {
                window.location.href = base_url + 'ticket/' + ticket.uid;
            },
            reply: function(elem, ticket) {
                window.location.href = base_url + 'ticket/' + ticket.uid+'#comment';
            },
            'change-status': function(elem, ticket) {
                if (typeof elem.data('bs.popover') === 'undefined') {
                    elem.popover({
                        html: true,
                        title: 'Select status',
                        content: function() {
                            return format_statuses();
                        }
                    }).popover('show');
                }
            }
        };
        var format_statuses = function() {
            if (typeof cache.statuses === 'undefined') {
                cache.statuses = '';
                for (var i in statuses) {
                    cache.statuses += tpl_status(statuses[i]);
                }
            }
            return cache.statuses;
        };
        var tpl_status = function(status) {
            var alias = status.name.replace(/\s/g, '-').toLowerCase();
            var row = $('<div />', {'class': 'row'}).css({'white-space': 'nowrap'});
            var label = $('<label />', {text: status.name, 'for': alias});
            var input = $('<input />', {type: 'radio', value: status.id, name: 'change_status', id: alias});
            row.append(label.prepend(input));
            return row[0].outerHTML;
        };
    });
})(jQuery);