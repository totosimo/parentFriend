import mapboxgl from 'mapbox-gl';
import Rails from '@rails/ujs';

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

//Obtain current position of the client
const initCurrentPosition = () => {navigator.geolocation.getCurrentPosition((position, error, options) => {
    const pa = position.coords.latitude;
    const pb = position.coords.longitude;
    const str_gsd = `latitude=${pa}&longitude=${pb}`

//Call DB to update current_user position values
    Rails.ajax({
        url: "/main",
        dataType: 'json',
        type: "post",
        data: str_gsd,
    })

//Display the map
    mapboxgl.accessToken = 'pk.eyJ1IjoiZ2VvcmdpdXMtc3RvaWN1cyIsImEiOiJja2tzZDN1dW8wbW16MndwY2k5ejBncnl6In0.l9u8Fk9ypU9iOM_wUXTAlA';
    const map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/streets-v9',
        center: [pb, pa],
        zoom: 14
    });

//Put a marker on the map
    const marker = new mapboxgl.Marker()
    .setLngLat([pb, pa])
    .addTo(map);
    });
};

//Export Function
export { initCurrentPosition };
