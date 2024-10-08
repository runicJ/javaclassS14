document.getElementsByTagName("body")[0].innerHTML += '<div class="demo-settings"><div class="demo-settings-toggle"><i class="ion ion-gear-a"></i></div><div class="demo-settings-options"><ul><li class="demo-toggle-skin" style="background-color: #000d35;" title="Default"></li><li class="demo-toggle-skin" style="background-color: #fbaf3b;" title="Purple"></li><li class="demo-toggle-skin" style="background-color: #addbc0;" title="Blue"></li><li class="demo-toggle-skin" style="background-color: #530127;" title="Orange"></li></ul></div></div>';

document.getElementsByClassName("demo-settings-toggle")[0].addEventListener("click", (e) => {
    if (document.getElementsByClassName("demo-settings")[0].classList.contains("active")) {
        document.getElementsByClassName("demo-settings")[0].classList.remove('active');
    } else {
        document.getElementsByClassName("demo-settings")[0].classList += ' active';
    }
});

if (localStorage.getItem("skin")) {
    document.getElementsByTagName("body")[0].classList = document.getElementsByTagName("body")[0].className.replace(/(^|\s)skin-\S+/g, '');
    document.getElementsByTagName("body")[0].classList += " skin-" + localStorage.getItem("skin");
}

let toggler = document.getElementsByClassName("demo-toggle-skin");
for (var i = toggler.length - 1; i >= 0; i--) {
    let me = toggler[i];
    me.addEventListener("click", (e) => {
        let _this = e.target;
        localStorage.removeItem("skin");
        localStorage.setItem("skin", _this.attributes.title.nodeValue.toLowerCase());
        document.getElementsByTagName("body")[0].classList = document.getElementsByTagName("body")[0].className.replace(/(^|\s)skin-\S+/g, '');
        document.getElementsByTagName("body")[0].classList += ' skin-' + _this.attributes.title.nodeValue.toLowerCase();
    });
}