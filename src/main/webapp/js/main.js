let x, y, r;
window.addEventListener('load', onStart, false);
window.addEventListener('load', onload, false);
let canvas;

canvas = $("#graph-canvas");


function onload () {
    const xTableValues = document.getElementsByClassName("xRes");
    const yTableValues = document.getElementsByClassName("yRes");
    const rTableValues = document.getElementsByClassName("rRes");
    for (let i = 0; i < xTableValues.length; i++) {
        drawPointByRelativeCoordinates(xTableValues[i].innerHTML, yTableValues[i].innerHTML, rTableValues[i].innerHTML);
    }
}


function drawPoint(x, y) {
    let ctxAxes = canvas[0].getContext('2d');
    ctxAxes.setLineDash([2, 2]);
    ctxAxes.beginPath();
    ctxAxes.stroke();
    ctxAxes.fillStyle = 'red';
    ctxAxes.arc(x, y, 2, 0, 2 * Math.PI);
    ctxAxes.fill();
}

function drawPointByRelativeCoordinates(relX, relY, relR) {
    drawPoint(relX*120/relR + 150, -(relY*120/relR - 150))
}

canvas.on("click", function (event) {
    if (validateR()) {
        let offX = event.offsetX;
        let offY = event.offsetY;
        let x = ((offX - 150) * r) / 120;
        let y = -((offY - 150) * r) / 120;
        window.x = x;
        window.y = y;
        if(window.x>=-5 && window.x<=3){
        if (sendCheckAreaRequest(window.x, window.y, r)) {
            drawPoint(offX, offY);
        }}else{
            showError("X не входит в область допустимых значений");
        }
    } else {
        showError("R не выбранно.")
    }
})



function isNumber(input) {
    return !isNaN(parseFloat(input)) && isFinite(input);
}



function validateX() {
    if (x == undefined) {
        showError("Нужно выбрать X");
        return false;
    }
    if (x<-5 || x>3){
        showError("X не входит в область допустимых значений");
        return false;
    }
    return true;
}

function validateY() {
    const Y_MIN = -5;
    const Y_MAX = 5;
    y = document.getElementById("y-input").value;
    if (y === '') {
        showError("Введите Y");
        return false;
    }
    y=y.replace(',' , '.');
    if (!isNumber(y)) {
        showError("Y не является числом");
        return false;
    }
    if (!((y > Y_MIN) && (y < Y_MAX))) {
        showError("Y не входит в область допустимых значений");
        return false;
    }
    return true;
}
function choosR(element){
    r = element.value;
}

function choosX(element){
    x = element.value;
}

function validateR() {
    if (r === undefined) {
        showError("Выберите R.");
        return false;
    }
    return true;
}

function submit() {
    if (validateX() & validateY() & validateR()) {
        sendCheckAreaRequest(x, y, r);
    }
}

function sendCheckAreaRequest(x, y, r) {
    $('#errors').empty();
    return $.get("process", {
        'x': x,
        'y': y,
        'r': r
    }).done(function (result) {
        document.getElementById("result-table").innerHTML = result;
        drawPointByRelativeCoordinates(x, y, r);
        return true;
    })
}
function showError(message) {
    $('#errors').append(`<li>${message}</li>`)
}
function onStart() {
    $.get("process", {
        'start': true
    }).done(function (data) {
        document.getElementById("result-table").innerHTML = data;
        onload();
    })
}
