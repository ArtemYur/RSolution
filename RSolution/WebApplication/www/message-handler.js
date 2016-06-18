// This recieves messages of type "alertMessageWithRepload" from the server.
Shiny.addCustomMessageHandler("alertMessageWithRepload",
  function (message) {
      alert(JSON.stringify(message));
      location.reload(true);
  }
);