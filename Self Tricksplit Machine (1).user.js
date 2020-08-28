// ==UserScript==
// @name         Self Tricksplit Machine
// @namespace    http://tampermonkey.net/
// @version      1.0
// @description  Automatically perform a self tricksplit when executed, modified by Liso.
// @author       Pascal Hadiyanto
// @match        https://gota.io/web/
// @grant        none
// @run-at       document-end
// ==/UserScript==

window.addEventListener('keydown', keydown);
window.addEventListener('keyup', keyup);

var Feed = false;

var speed = 40;
document.getElementById("instructions").innerHTML += "<center><span class='text-muted'><span data-itr='instructions_e'> Press <b>E</b> or <b>4</b> to split 4x</span></span></center>";
document.getElementById("instructions").innerHTML += "<center><span class='text-muted'><span data-itr='instructions_3'> Press <b>3</b> to split 3x</span></span></center>";
document.getElementById("instructions").innerHTML += "<center><span class='text-muted'><span data-itr='instructions_d'> Press <b>D</b> or <b>2</b> to split 2x</span></span></center>";
document.getElementById("instructions").innerHTML += "<center><span class='text-muted'><span data-itr='instructions_q'> Press and hold <b>Q</b> for macro feed</span></span></center>";

function keydown(event) {
     // Self tricksplit variation #1
    if (event.keyCode == 69) {
        splitting();
        setTimeout(quadsplitting, speed);
    }
      // Self tricksplit variation #2
    if (event.keyCode == 68) {
        sixteensplit();
        setTimeout(splitting, speed);
    }
      // 256 split
    if (event.keyCode == 82) {
        splitting();
        setTimeout(splitting, speed);
        setTimeout(splitting, speed);
        setTimeout(splitting, speed);
        setTimeout(splitting, speed);
        setTimeout(splitting, speed);
        setTimeout(splitting, speed);
        setTimeout(splitting, speed);
    }
      // Split
    if (event.keyCode == 49) {
        splitting();
    }
}

function keyup(event) {
    if (event.keyCode == 87) {
        Feed = false;
    }
}

function eject() {
    if (Feed) {
        window.onkeydown({keyCode: 87}); // key W
        window.onkeyup({keyCode: 87});
        setTimeout(eject, speed);
    }
}
function splitting() {
  $("body").trigger($.Event("keydown", { keyCode: 32}));
  $("body").trigger($.Event("keyup", { keyCode: 32}));
}

function sixteensplit() {
  $("body").trigger($.Event("keydown", { keyCode: 51}));
  $("body").trigger($.Event("keyup", { keyCode: 51}));
}

function asplit() {
  $("body").trigger($.Event("keydown", { keyCode: 65}));
  $("body").trigger($.Event("keyup", { keyCode: 65}));
}

function quadsplitting() {
  $("body").trigger($.Event("keydown", { keyCode: 50}));
  $("body").trigger($.Event("keyup", { keyCode: 50}));
}
//Looking through the code now are we? ( ͡° ͜ʖ ͡°)
