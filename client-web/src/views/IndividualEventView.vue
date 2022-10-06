<template>
  <div class="container-fluid px-0 vh-100">
    <div
      id="carouselExampleFade"
      class="carousel slide carousel-fade mb-4"
      data-bs-ride="carousel"
    >
      <div class="carousel-inner">
        <div
          v-for="image in eventData[0].images"
          :key="image"
          class="carousel-item active"
        >
          <img :src="image" class="d-block w-100" alt="..." />
        </div>
      </div>
      <button
        class="carousel-control-prev"
        type="button"
        data-bs-target="#carouselExampleFade"
        data-bs-slide="prev"
      >
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
      </button>
      <button
        class="carousel-control-next"
        type="button"
        data-bs-target="#carouselExampleFade"
        data-bs-slide="next"
      >
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
      </button>
    </div>
    <div class="row heading px-4">About the Event</div>
    <div class="row jusify-content-center">
      <div class="col-md-9 px-4">
        <p v-if="eventData[0].description != ''">
          {{ eventData[0].description }}
        </p>
        <p class="text-muted" v-else>
          No description for this hall has been provided
        </p>
      </div>
      <div class="col-md-3 mb-3">
        <div class="card" id="hall" style="width: 16rem">
          <div class="card-body border border-dark rounded">
            <h6 id="hall-name" class="card-title fw-bold text-center">
              {{ eventData[0].name }}
            </h6>
            <p class="hall-info">{{ eventData.date }}</p>
            <p class="hall-info">
              <span class="fw-bold">Participants: </span
              >{{ eventData[0].capacity }}
            </p>
            <p class="hall-info fw-bold">Time Slots</p>
            <p v-for="time in eventData[0].time_slot" :key="time">{{ time }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import axios from "axios";
import { ref, onMounted } from "vue";
import { useRoute, useRouter } from "vue-router";
import { useAuthStore } from "../store/authStore";
const route = useRoute();

//Load Individual Event Info
let eventData = ref([]);
const authStore = useAuthStore();
const loadEventData = async () => {
  try {
    const token = localStorage.getItem("token");
    const event = await axios
      .get(import.meta.env.VITE_SERVER_URL + "/events/" + route.params.id, {
        headers: {
          authorization: "Bearer " + token,
        },
      })
      .then((res) => {
        console.log(res.data.event);
        eventData.value = res.data.event;
      });
  } catch (err) {
    console.log(err);
  }
};
loadEventData();
onMounted(() => {
  loadEventData();
  authStore.getUserInfo();
});
</script>

<style scoped>
#carouselExampleFade .carousel-item img {
  object-fit: cover;
  object-position: center;
  overflow: hidden;
  height: 50vh;
}
.heading {
  font-size: 1.25rem;
  font-weight: bold;
}
#bookButton {
  background-color: #2e0249;
}
.media-scroller {
  display: grid;
  grid-auto-flow: column;
  grid-auto-columns: 18%;
  overflow-x: auto;
  overscroll-behavior-inline: contain;
}
.v-enter-active,
.v-leave-active {
  transition: opacity 0.5s ease;
}

.v-enter-from,
.v-leave-to {
  opacity: 0;
}
</style>
