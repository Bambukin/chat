import consumer from "./consumer"

document.addEventListener('turbo:load', function (event) {
  const messages = document.getElementById('messages');

  if (messages) {
    createRoomChannel(messages.dataset.roomId);
    messages.scrollTop = messages.scrollHeight;
  }
})

document.addEventListener('keypress', function (event) {
  if (event.target.matches('#message_body')) {
    const message = event.target.value;
    if (event.keyCode === 13 && message !== '') {
      room.speak(message);
      event.target.value = '';
      event.preventDefault();
    } else if (event.keyCode === 13 && message === '') {
      event.preventDefault();
    }
  }
});


function createRoomChannel(roomId) {
  window.room = consumer.subscriptions.create({channel: "RoomChannel", roomId: roomId}, {
    connected() {
      console.log('Connected to RoomChannel');
    },

    disconnected() {
      console.log('Disconnected from RoomChannel');
    },

    received(data) {
      console.log('Received data from RoomChannel: ' + data['message']);

      const messages = document.getElementById('messages');
      messages.innerHTML += data.message;
      messages.scrollTop = messages.scrollHeight;
    },

    speak: function (message) {
      this.perform('speak', {message: message});
    }
  })
}
