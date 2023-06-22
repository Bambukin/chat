import consumer from "./consumer"

document.addEventListener('turbo:load', function (event) {
  const messages = document.getElementById('messages');

  if (messages) {
    createRoomChannel(messages.dataset.roomId);
  }
})

document.addEventListener('keypress', function(event) {
  if (event.target.matches('#message_body')) {
    const message = event.target.value;
    if (event.keyCode === 13 && message !== '') {
      room.speak(message);
      event.target.value = '';
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

      document.getElementById('messages').innerHTML += data.message;
    },

    speak: function (message) {
      this.perform('speak', {message: message});
    }
  })
}
