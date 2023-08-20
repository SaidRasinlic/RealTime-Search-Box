/* import consumer from "./consumer";
// ...

const chatChannel = consumer.subscriptions.create("SearchCountsChannel", {
  connected() {
    console.log("Connected to ChatChannel");
  },
  received(data) {
    console.log("Received data:", data);
  }
}); */

// Manually subscribe to the channel
// chatChannel.perform("subscribed");

// Broadcast a message from Rails console
// ActionCable.server.broadcast("chat", message: "Hello, world!");
