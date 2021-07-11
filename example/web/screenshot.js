import html2canvas from './html2canvas.min.js';

function screenshot() {
    console.log("in screenshot");
    let body = document.querySelector("#capture");
    console.log(body);
    // let screenshot = html2canvas(body).then(canvas => {
    //     console.log(canvas);
    // });

    // return screenshot;
}

window.logger = (flutter_value) => {
    console.log({ js_context: this, flutter_value });
}