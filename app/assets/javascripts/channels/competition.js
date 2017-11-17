App.competition = App.cable.subscriptions.create(
    {
        channel: "CompetitionChannel",
        comp_id: find_params('comp_id')
    },
    {
        connected: function () {

        },
        disconnected: function () {
        },
        received: function (data) {
            if (data.is_closed) {
                $('.competition_indexes').attr('disabled', true)
            }
            else
            {
                $.each(data.competition, function (index, object) {
                   $("#compitition_index_result_" + index).html(object.index_result)
                });
            }
        }
    });


function find_params(name) {
    var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
    return results[1] || 0;
}