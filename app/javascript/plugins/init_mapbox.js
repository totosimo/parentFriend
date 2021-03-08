import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

const initMapbox = () => {
  const mapElement = document.getElementById('mapEvents');

  const fitMapToMarkers = (map, markers) => {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
    map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  };

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'mapEvents',
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
    const geocoder = new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
      mapboxgl: mapboxgl, placeholder: "Find Events", collapsed: false });
      const geocoderDiv = document.getElementById('geocoder');
      if (geocoderDiv.innerHTML.length === 0) {
        geocoderDiv.appendChild(geocoder.onAdd(map));
      }
    }
  };
  export { initMapbox };
