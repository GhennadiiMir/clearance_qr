class QrLogin {

  constructor(params) {
    // should contain:
    // qrDivId - div to show QR code
    // connectBtnId - which should be clicked to connect to mConto
    // loginProc - function to call when inquiry_token obtained from WS server
    this.params = params;

    this.qrDiv = document.getElementById(params.qrDivId);

    this.connectBtn = document.getElementById(params.connectBtnId);
    this.connectBtn.addEventListener("click", this.connect);
  }

  connect = () => {
    // prevent additional clicks
    this.connectBtn.setAttribute("disabled", "");
    this.connectBtn.removeEventListener("click", this.connect);

    // TODO: setup timer to renew code after 120 seconds

    // const ws = new WebSocket('ws://ws1.mconto.com:8112');
    const ws = new WebSocket('ws://localhost:8112/door');

    ws.addEventListener('message', (event) => {
      console.log('Message from server: ', event.data);
      var data = JSON.parse(event.data);
      console.log("data ")
      console.log(data);
      switch(data.packet_type) {
        case "qr_code":
          this.qrDiv.innerHTML = data.qr_svg;
          break;
        case "inquiry_token":
          this.params.loginProc(data.inquiry_token);
          break;
        case "errors":
          // show error messages
          break;
      }
    });

    ws.addEventListener('open', (event) => {
      console.log('Connection established');
    });

    ws.addEventListener('close', (event) => {

      console.log('Connection closed');
    });
  }
}

export default QrLogin;
