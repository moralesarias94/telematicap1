// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

import socket from "./socket"
  $(document).ready(function(){
    // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
    $('.modal').modal();
  });

  $( document ).ready(function() {
    $( "body" ).on( "click", ".delete_transaction", function() {
    var id = $( this ).attr('data-id');
    $.ajax({
            url: '/transaction/' + id,
            type: 'DELETE',
            success: function(result) {
                
                var balance = parseInt($("#wallet_balance").text());
                console.log(balance + " Balance")
                if($("#transaction_"+ id + "_value").attr('data-type') == "deposit"){
                  var value = $("#transaction_"+ id + "_value").attr('data-value');

                  balance-= parseInt($("#transaction_"+ id + "_value").attr('data-value'));
                }else{
                  var value = $("#transaction_"+ id + "_value").attr('data-value');

                  balance+= parseInt($("#transaction_"+ id + "_value").attr('data-value'));
                }
                $("#wallet_balance").text(balance)
                $("#transaction_" + id).remove()

            }
        });
    });
});
