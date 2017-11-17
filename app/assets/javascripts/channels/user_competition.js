App.competition = App.cable.subscriptions.create(
    {
        channel: "UserCompetitionChannel",
        comp_id: find_params('comp_id')
    },
    {
        connected: function () {

        },
        disconnected: function () {
        },
        received: function (data) {
            if (data.competition_index_sum) {
                console.log(data.competition_index_sum[0]);
                $.each(data.competition_index_sum, function (index, object) {
                    $("#compitition_index_sum_result_" + index).html(object)
                });
            }
            if (data.competition_master_commissions) {
                $.each(data.competition_master_commissions, function (index, object) {
                    result = -(data.competition_index_result[index].index_result * object);
                    $("#compitition_master_commission_index_result_" + index).html(result)
                });
            }
            if (data.competition_company_commissions) {
                $.each(data.competition_company_commissions, function (index, object) {
                    result = -(data.competition_index_result[index].index_result * object);
                    $("#compitition_company_commission_index_result_" + index).html(result)
                });
            }
            if (data.user_index_result) {
                $.each(data.user_index_result, function (index, object) {
                    $("#compitition_client_index_result_" + index).html(object.index_result)
                });
            }

            if(data.amount_to_play){
                $('#user_rermaining_amount').text(data.amount_to_play);
                $('#user_amount_used').text(data.amount_used);
                if(data.amount_to_play == 0) {
                    $('.competition_indexes').attr('disabled', true);
                }
            }
        }
    });
