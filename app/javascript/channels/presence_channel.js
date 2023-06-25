import consumer from "./consumer"

document.addEventListener('turbo:load', function (event) {
  const messages = document.getElementById('messages');

  if (messages) {
    createPresenceChannel(messages.dataset.roomId);
  }
})

function createPresenceChannel(roomId) {
  window.room = consumer.subscriptions.create({channel: "PresenceChannel", roomId: roomId}, {
    connected() {
      console.log('Connected to PresenceChannel');
    },

    disconnected() {
      console.log('Disconnected from PresenceChannel');
    },

    received(data) {
      console.log('Received data from PresenceChannel: ' + data['message']);
      document.getElementById('status').innerHTML = data.message;
    }
  });
}
