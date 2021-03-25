var invoke;
$(document).ready(function() {
    invoke = function(object) {
        
        let type = object.getAttribute('data-type')
        let experiment = object.getAttribute('data-experiment')
        let signature = object.getAttribute('data-signature')

        let message = JSON.stringify({type:type, 
                                      experiment:experiment, 
                                      signature:signature,
                                      nonce:Math.random()})

        Shiny.onInputChange('jsValue', message)
    }
})
