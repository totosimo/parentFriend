import consumer from "./consumer";
const initChatroomCable = () => {
  let messagesContainer = document.getElementById('messages');
  let messageLast = document.getElementById('message-last');
  // console.log(messageLast)
  // if (messageLast != null) { messageLast.scrollIntoView(false) }
  if (messagesContainer) {
    messageLast.scrollIntoView(false)
    const id = messagesContainer.dataset.chatroomId;
    consumer.subscriptions.create({ channel: "ChatroomChannel", id: id }, {
      received(data) {
        document.querySelector("#message_content").value = ""
        document.querySelector("#message_content").placeholder = ""
        messagesContainer = document.getElementById('messages');
        console.log(data);
        let html = data.html
        let senderId = data.message_user_id
        // console.log(typeof(senderId))
        let currentUserId = document.querySelector('.chat-flexbox').dataset.currentUserId
        currentUserId = Number(currentUserId)
        // console.log(typeof(currentUserId))
        // console.log(currentUserId);
        messagesContainer.insertAdjacentHTML('beforeend', html);
        let lastMessage = document.getElementById(`message-${data.message_id}`)
        // console.log(`message-${data.message_id}`)
        // console.log(lastMessage)
        let userName = document.getElementById(`message-user-name-${data.message_id}`)
        // console.log(userName)
        userName.innerText = data.message_user_name
        if (senderId === currentUserId) {
          lastMessage.classList.add('my-message')
        } else {
          lastMessage.classList.remove('my-message')
        }
        lastMessage.scrollIntoView(false)
        // document.querySelector("input").value = '';
        // const test = document.querySelector("input");
        // console.log(test.dataset);
        // document.querySelectorAll('.message-container')[document.querySelectorAll('.message-container').length - 1].focus();
      },
    });
  }
}
export { initChatroomCable };
