function check(){
  const messages = document.querySelectorAll(".message");
  messages.forEach(function (message) {
    if (message.getAttribute("data-load") != null) {
      return null; 
    }
    message.setAttribute("data-load", "true");
    message.addEventListener("click", () => {
      const messageId = message.getAttribute("data-id");
      const XHR =new XMLHttpRequest();
      XHR.open("GET", `/messages/${messageId}`, true);
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => {
        if (XHR.status != 200) {
          alert(`Error ${XHR.status}: ${XHR.statusText}`);
          return null;
        }
        const item = XHR.response.message;
        if (item.checked === true) {
          message.setAttribute("data-check", "true")
        } else if (item.checked === false) {
          message.removeAttribute("data-check");
        }
      };
    });
  });
}
setInterval(check, 1000);