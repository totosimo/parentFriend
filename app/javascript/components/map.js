import mapboxgl from 'mapbox-gl';
import Rails from '@rails/ujs';
import 'mapbox-gl/dist/mapbox-gl.css';

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

    const mapElement = document.getElementById('mapUsers');
    const fitMapToMarkers = (map, markers) => {
        const bounds = new mapboxgl.LngLatBounds();
        markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
        map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
    };

    if (mapElement) {
        navigator.geolocation.getCurrentPosition((position, error, options) => {
            const pa = position.coords.latitude;
            const pb = position.coords.longitude;
            const str_gsd = `latitude=${pa}&longitude=${pb}`

            //Call DB to update current_user position values
            Rails.ajax({
                url: "/meet",
                dataType: 'json',
                type: "post",
                data: str_gsd,
            })

            //Display the map
            mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
            const map = new mapboxgl.Map({
                container: 'mapUsers',
                style: 'mapbox://styles/pdunleav/cjofefl7u3j3e2sp0ylex3cyb'
            });
            //Add geolocation control to the map
            map.addControl(
                new mapboxgl.GeolocateControl({
                    positionOptions: {
                    enableHighAccuracy: true
                    },
                    trackUserLocation: true
                })
            );
            const markers = JSON.parse(mapElement.dataset.markers);
            markers.forEach((marker) => {
                const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);
                new mapboxgl.Marker()
                    .setLngLat([ marker.lng, marker.lat ])
                    .setPopup(popup) // add this
                    .addTo(map);
            });
            fitMapToMarkers(map, markers);      
        });
    };
};

//Export Function
export { initCurrentPosition };


//HOW TO DETERMINE CURRENT POSITION WITH PURE JAVASCRIPT
// import mapboxgl from 'mapbox-gl';
// import Rails from '@rails/ujs';

// //Enable High Accuracy
// const options = {
//     enableHighAccuracy: true,
//     timeout: 5000,
//     maximumAge: 0
//   };

// //Define Error Handling
// const error = (err) => {
// console.warn(`ERROR(${err.code}): ${err.message}`);
// };

// //Obtain current position of the client
// const initCurrentPosition = () => {

//     const mapElement = document.getElementById('mapUsers');

//     if (mapElement) {
//         navigator.geolocation.getCurrentPosition((position, error, options) => {
//         const pa = position.coords.latitude;
//         const pb = position.coords.longitude;
//         const str_gsd = `latitude=${pa}&longitude=${pb}`

//         //Call DB to update current_user position values
//             Rails.ajax({
//                 url: "/meet",
//                 dataType: 'json',
//                 type: "post",
//                 data: str_gsd,
//             })

//         //Display the map
//             if (mapElement) { // only build a map if there's a div#map to inject into
//                 mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
//                     const map = new mapboxgl.Map({
//                     container: 'mapUsers',
//                     style: 'mapbox://styles/pdunleav/cjofefl7u3j3e2sp0ylex3cyb',
//                     center: [pb, pa],
//                     zoom: 14
//                 });
//                 //Add geolocation control to the map
//                 map.addControl(
//                     new mapboxgl.GeolocateControl({
//                     positionOptions: {
//                         enableHighAccuracy: true
//                     },
//                     trackUserLocation: true
//                     })
//                 );
//                 //Put a marker on the map
//                 const marker = new mapboxgl.Marker()
//                 .setLngLat([pb, pa])
//                 .addTo(map);
//             };
//         });
//     };
// };

// //Export Function
// export { initCurrentPosition };