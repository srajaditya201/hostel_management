Shiny.addCustomMessageHandler('shinyCookieParam', function(data) {
        let key = data.name;
        let val = data.value;
        if (typeof(val) !== 'string'){
            // If it's not a raw string, JSON.stringify
            val = JSON.stringify(val);
        }
        let param = data.parameters
        Cookies.set(key, val, param);
    });
    
    
    Shiny.addCustomMessageHandler('shinyCookieGetParam', function(data) {
        let key =data.getToken;
        var cookie = Cookies.get('tata_capital_token');
        if (typeof cookie !== "undefined") {
          Shiny.onInputChange("cookie_resp", cookie);
        } else {
          var cookie = "NA";
          Shiny.onInputChange("cookie_resp", cookie);
        }
    });
    
    function triggerGetCookie(){
      let interv = setInterval(
        () => {
          Shiny.onInputChange('get_cookie_trigger', 1)
          clearInterval(interv)
        },
        1000
      )
    };
    
    Shiny.addCustomMessageHandler('shinyCookieRem', function(data) {
        let key_remove =data.getToken;
        Cookies.remove('tata_capital_token');
        Shiny.onInputChange('cookie_removed',0)
    });