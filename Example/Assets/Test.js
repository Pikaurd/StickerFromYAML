var s = 'None'

if ("geolocation" in navigator) {
    /* geolocation is available */
    
    navigator.geolocation.getCurrentPosition(getPosition, errorHandle)
//    sleep(1000)
} else {
    /* geolocation IS NOT available */
}

function getPosition(p) {
    s = String(p.coords)
}

function errorHandle(e) {
    s = String(e)
}
