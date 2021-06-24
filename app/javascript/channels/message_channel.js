import consumer from "./consumer"

consumer.subscriptions.create("MessageChannel", {
  connected() {
  },

  disconnected() {
  },

  received(data) {
    let url = window.location.href
    let param = url.split('/');
    let paramItem = param[param.length-1]
    if (paramItem == data.id) {
      const messages = document.getElementById('comments');
      const message = document.getElementsByClassName('comments_lists');

      const textElement = document.createElement('div');
      textElement.setAttribute('class', "comments_lists");

      const topElement = document.createElement('div');
      topElement.setAttribute('class', "comments_top");

      const nameElement = document.createElement('div');
      const timeElement = document.createElement('div');

      const bottomElement = document.createElement('div');
      bottomElement.setAttribute('class', "comments_bottom");

      messages.insertBefore(textElement, messages.firstElementChild);
      textElement.appendChild(topElement);
      textElement.appendChild(bottomElement);
      topElement.appendChild(nameElement);
      topElement.appendChild(timeElement);

      const name = `${data.nickname}`;
      nameElement.innerHTML = name;
      const time = `${data.time}`;
      timeElement.innerHTML = time;
      const text = `<p>${data.message.text}</p>`;
      bottomElement.innerHTML = text;

      const newComment = document.getElementById('comment_text');
      newComment.value='';

      const submitElement = document.querySelector('button[class="comment_btn"]');
      submitElement.disabled = false;
    }
  }
});