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
const initCurrentPosition = () => {

    const mapElement = document.getElementById('mapusers');

    navigator.geolocation.getCurrentPosition((position, error, options) => {
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
        if (mapElement) { // only build a map if there's a div#map to inject into
            mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
                const map = new mapboxgl.Map({
                container: 'mapusers',
                style: 'mapbox://styles/pdunleav/cjofefl7u3j3e2sp0ylex3cyb',
                // style: 'mapbox://styles/mapbox/streets-v11',
                center: [pb, pa],
                zoom: 14
            });

            //Put a marker on the map
            const marker = new mapboxgl.Marker()
            .setLngLat([pb, pa])
            .addTo(map);
        };
    });
};

//Export Function
export { initCurrentPosition };
