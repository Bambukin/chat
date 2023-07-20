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
      const { status, user } = data
      console.log(`Received data from StatusChannel: ${status}-${user}`);
      let userNickname = document.getElementById(user);

      if (status === 'online') {
        if (userNickname) return

        document.getElementById('status').innerHTML += ` <span id="${user}">${user}</span>`
      } else if (status === 'offline') {
        userNickname.remove();
      }
    }
  });
}
