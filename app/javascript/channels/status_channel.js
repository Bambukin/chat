import consumer from "./consumer"

document.addEventListener('turbo:load', function (event) {
  const messages = document.getElementById('messages');

  if (messages) {
    createStatusChannel(messages.dataset.roomId);
  }
})

function createStatusChannel(roomId) {
  consumer.subscriptions.create({channel: "StatusChannel", roomId: roomId}, {
    connected() {
      console.log('Connected to StatusChannel');
    },

    disconnected() {
      console.log('Disconnected from StatusChannel');
    },

    received(data) {
      console.log('Received data from StatusChannel: ' + data['message']);
      document.getElementById('status').innerHTML = data.message;
    }
  });
}
