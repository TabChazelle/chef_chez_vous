import { Controller } from "@hotwired/stimulus"
// import mapboxgl from 'mapbox-gl' // Don't forget this!

export default class extends Controller {
  static values = {
    apiKey: String,
    marker: Object
  }

  connect() {
    console.log("Map controller connected")
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })

    // this.#addMarkersToMap()
    // this.#fitMapToMarkers()
  }
}

//   #addMarkersToMap() {
//     const marker = this.markerValue
//     new mapboxgl.Marker({ "element": this.#createMarkerElement(marker) })
//       .setLngLat([ marker.lng, marker.lat ])
//       .addTo(this.map)
//   }

//   #fitMapToMarkers() {
//     const marker = this.markerValue
//     const bounds = new mapboxgl.LngLatBounds()
//     bounds.extend([ marker.lng, marker.lat ])
//     this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
//   }

//   #createMarkerElement(marker) {
//     const element = document.createElement('div')
//     element.className = 'marker'
//     element.style.backgroundImage = `url(${marker.image_url})`
//     element.style.backgroundSize = 'cover'
//     element.style.width = '25px'
//     element.style.height = '25px'
//     return element
//   }
// }
