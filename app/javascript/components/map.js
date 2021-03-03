import mapboxgl from 'mapbox-gl';
// Selecting Elements
const formSelector = document.getElementById("geo-form");

// Obtaining current position of the client
const los = () => {navigator.geolocation.getCurrentPosition((position) => {
    const pa = position.coords.latitude;
    const pb = position.coords.longitude;
    const gsd = [pa, pb];
    mapboxgl.accessToken = 'pk.eyJ1IjoiZ2VvcmdpdXMtc3RvaWN1cyIsImEiOiJja2tzZDN1dW8wbW16MndwY2k5ejBncnl6In0.l9u8Fk9ypU9iOM_wUXTAlA';
    const map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/streets-v9',
        center: [gsd[1], gsd[0]],
        zoom: 12
    });
    const marker = new mapboxgl.Marker()
    .setLngLat([gsd[1], gsd[0]])
    .addTo(map);
    });
}

const initCurrentPosition = (event) => {
    event.preventDefault();
    los();
};

formSelector.addEventListener("submit", initCurrentPosition);

export { initCurrentPosition };


// import mapboxgl from 'mapbox-gl';

// // Selecting Elements
// const formSelector = document.getElementById("geo-form");
// const userInput = document.querySelector("#address");

// // Retrieving Geo Coordinates from API Response
// const handleResponse = (data) => {
//   const coordinatesResponse = data.features[0].geometry.coordinates;
//   return coordinatesResponse;
// };

// navigator.geolocation.getCurrentPosition((position) => {
//     console.log(position.coords.latitude, position.coords.longitude);
//   });

// // Displayiing a Map
// const mapDisplay = (array) => {
//   mapboxgl.accessToken = 'pk.eyJ1IjoiZ2VvcmdpdXMtc3RvaWN1cyIsImEiOiJja2tzZDN1dW8wbW16MndwY2k5ejBncnl6In0.l9u8Fk9ypU9iOM_wUXTAlA';
//   const map = new mapboxgl.Map({
//     container: 'map',
//     style: 'mapbox://styles/mapbox/streets-v9',
//     center: [array[0], array[1]],
//     zoom: 12
//   });
//   new mapboxgl.Marker()
//     .setLngLat([array[0], array[1]])
//     .addTo(map);
// };

// const initCurrentPosition = (event) => {
//   event.preventDefault();
//   const apiCoordinatesUrl = `https://api.mapbox.com/geocoding/v5/mapbox.places/${userInput.value}.json?access_token=pk.eyJ1IjoiZ2VvcmdpdXMtc3RvaWN1cyIsImEiOiJja2tzZDN1dW8wbW16MndwY2k5ejBncnl6In0.l9u8Fk9ypU9iOM_wUXTAlA`;
//   fetch(apiCoordinatesUrl).then(response => response.json()).then(handleResponse).then(mapDisplay);
// };

// formSelector.addEventListener("submit", initCurrentPosition);