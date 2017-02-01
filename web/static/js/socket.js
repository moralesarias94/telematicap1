// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "web/static/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/my_app/endpoint.ex":
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/2" function
// in "web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, pass the token on connect as below. Or remove it
// from connect if you don't care about authentication.

socket.connect()

// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("room:lobby", {})
let payment_submit = document.querySelector("#add_payment")
let desc = document.querySelector("#transaction_desc")
let value = document.querySelector("#transaction_value")
let type = document.querySelector("#transaction_type")
let deposit_desc = document.querySelector("#deposit_desc")
let deposit_value = document.querySelector("#deposit_value")
let deposit_type = document.querySelector("#deposit_type")
let deposit_submit = document.querySelector("#add_deposit")
let deposit_wallet_id = document.querySelector("#deposit_wallet")
let transaction_wallet_id = document.querySelector("#transaction_wallet")

deposit_submit.addEventListener("click", event => {

if(deposit_desc.value && deposit_value.value && deposit_type.value){
    channel.push("new_transaction", {body: {desc: deposit_desc.value, value: deposit_value.value, type: deposit_type.value, wallet_id: transaction_wallet_id.value}});
    desc.value = "";
    value.value = "";
  }
});

payment_submit.addEventListener("click", event => {

if(desc.value && value.value && type.value){
    channel.push("new_transaction", {body: {desc: desc.value, value: value.value, type: type.value, wallet_id: deposit_wallet_id.value}});
    desc.value = "";
    value.value = "";
  }
})

channel.on("new_transaction", payload => {
  let icon = "";
  if(payload.body.type == "deposit"){
    icon = "local_atm";
  }else{
    icon = "payment";
  }
  $( '#transactions_list' ).append('<li id="transaction_'+payload.body.id+'"><div class="collapsible-header"<p><i class="material-icons">' + icon + '</i>' + payload.body.desc + '<span id="transaction_'+payload.body.id+'_value" data-type="'+payload.body.type+'" data-value="'+payload.body.value+'">'+' $'+payload.body.value+' <i style="float: right; color: red" data-id="'+payload.body.id+'" class="delete_transaction material-icons">delete</i></p></div></li>')
  $('#wallet_balance').text(payload.body.balance)
  console.log("Recibiendo");
  console.log(payload);
})

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

export default socket
