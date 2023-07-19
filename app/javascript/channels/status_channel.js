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
      console.log(`Received data from StatusChannel: ${data.user}-${data.status}`);
      let userNickname = document.getElementById(data.user);

      if (data.status === 'online') {
        if (userNickname) return

        let spaceNode = document.createTextNode(' ');
        document.getElementById('status').appendChild(spaceNode);

        let spanElement = document.createElement('span');
        spanElement.textContent = data.user;
        spanElement.setAttribute('id', data.user)
        document.getElementById('status').appendChild(spanElement);
      } else if (data.status === 'offline') {
        userNickname.remove();
      }
    }
  });
}
