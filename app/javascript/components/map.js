import mapboxgl from 'mapbox-gl';
// Selecting Elements
const formSelector = document.getElementById("geo-form");

//Enable High Accuracy
const options = {
    enableHighAccuracy: true,
    timeout: 5000,
    maximumAge: 0
  };

//Define Error Handling
const error = (err) => {
console.warn(`ERROR(${err.code}): ${err.message}`);
};

// Obtain current position of the client
const displayMap = () => {navigator.geolocation.watchPosition((position, error, options) => {
    const pa = position.coords.latitude;
    const pb = position.coords.longitude;
    const gsd = [pa, pb];
    mapboxgl.accessToken = 'pk.eyJ1IjoiZ2VvcmdpdXMtc3RvaWN1cyIsImEiOiJja2tzZDN1dW8wbW16MndwY2k5ejBncnl6In0.l9u8Fk9ypU9iOM_wUXTAlA';
    const map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/streets-v9',
        center: [gsd[1], gsd[0]],
        zoom: 14
    });
    const marker = new mapboxgl.Marker()
    .setLngLat([gsd[1], gsd[0]])
    .addTo(map);
    });
};

//Fire Up Positioning Algo
const initCurrentPosition = (event) => {
    event.preventDefault();
    displayMap();
};

//Add Event Listener
formSelector.addEventListener("submit", initCurrentPosition);

//Export Function
export { initCurrentPosition };