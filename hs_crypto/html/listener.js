
$(function () {
    function display(bool) {
        if (bool) {
            $("#phone").show();
        } else {
            $("#phone").hide();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })

    document.onkeyup = function(data) {
        if (data.which == 27) {
            $.post("https://hs_crypto/exit", JSON.stringify({}));
            return
        }
    };
    $("#close").click(function () {
        $.post('https://hs_crypto/exit', JSON.stringify({}));
        return
    })
    $("#buy").click(function () {
        $.post('https://hs_crypto/buy', JSON.stringify({}));
        return
    })
    $("#info").click(function () {
        $.post('https://hs_crypto/info', JSON.stringify({}));
        return
    })

})