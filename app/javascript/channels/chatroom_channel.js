import consumer from "./consumer";

const initChatroomCable = () => {
  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.chatroomId;

    consumer.subscriptions.create({ channel: "ChatroomChannel", id: id }, {
      received(data) {
        messagesContainer.insertAdjacentHTML('beforeend', data);
        document.querySelector("input").value = '';
        // document.querySelectorAll('.message-container')[document.querySelectorAll('.message-container').length - 1].focus();
      },
    });
  }
}

export { initChatroomCable };
