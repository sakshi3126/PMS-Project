
$(document).ready(function(){
    let bulkUpdate = () => {
        $(".bulk-update-form").on('click', '.bulk-update', function (event) {
            var formSelector = $(".bulk-update-form"),
                datastring = $(formSelector).serialize();
            $.ajax({
                type: "GET",
                url: $(formSelector).attr('action'),
                data: datastring,
                dataType: "json",
                success: function success(data) {
                    $('.bulk-update-form').modal('hide');
                    if (data.success == 0) {
                        alert(data.message);
                    } else {
                        window.location.reload();
                    }
                },
                error: function error(_error) {
                    if (_error.responseJSON && _error.responseJSON.error)
                        $(formSelector).find('.error').empty().html("<div class='p-1'>" + _error.responseJSON.error + "</div>");
                }
            });
            event.preventDefault();
        });
    }

});
