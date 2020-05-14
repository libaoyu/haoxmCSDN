(function() {
    var metaEl = document.querySelector('meta[name="viewport"]')
    var metaCtt = metaEl ? metaEl.content : ''
    var matchScale = metaCtt.match(/initial\-scale=([\d\.]+)/)
    var matchWidth = metaCtt.match(/width=([^,\s]+)/)
    if (metaEl && !matchScale && (matchWidth && matchWidth[1] != 'device-width')) {
        var width = parseInt(matchWidth[1])
        var iw = window.innerWidth || width
        var ow = window.outerWidth || iw
        var sw = window.screen.width || iw
        var saw = window.screen.availWidth || iw
        var ish = window.screen.height || ih
        var sah = window.screen.availHeight || ih
        var w = Math.min(iw, ow, sw, saw, ish, sah)
        var scale = w / width
        if (scale < 1) {
            metaEl.content += ',initial-scale=' + scale +
            ',maximum-scale=' + scale +
            ', minimum-scale=' + scale + ',user-scalable=no';
        }
    }
}())