var sabio = {
    utilities: {}
    , layout: {}
    , page: {
        handlers: {
        }
        , startUp: null
    }
    , services: {}
    , ui: {}

};
sabio.moduleOptions = {
    APPNAME: "SabioApp"
    , extraModuleDependencies: []
        , runners: []
        , page: sabio.page//we need this object here for later use
}


sabio.layout.startUp = function () {

    console.debug("sabio.layout.startUp");

    // The following line initializes jQuery widgets from the
    // Color Admin theme, if you are using it.
    if (window.App && window.App.init) {
        App.init();
    }

    //this does a null check on sabio.page.startUp
    if (sabio.page.startUp) {
        console.debug("sabio.page.startUp");
        sabio.page.startUp();
    }
};
sabio.APPNAME = "SabioApp";//legacy



$(document).ready(sabio.layout.startUp);