<template>
  <div class="container-fluid px-0 vh-100">
    <div
      id="carouselExampleFade"
      class="carousel slide carousel-fade mb-4"
      data-bs-ride="carousel"
    >
      <div class="carousel-inner">
        <div
          v-for="image in hallData.images"
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
    <div class="row heading px-4">About the Hall</div>
    <div class="row jusify-content-center">
      <div class="col-md-9 px-4">
        <p v-if="hallData.description != ''">
          {{ hallData.description }}
        </p>
        <p class="text-muted" v-else>
          No description for this hall has been provided
        </p>
      </div>
      <div class="col-md-3">
        <div class="card" id="hall" style="width: 16rem">
          <div class="card-body border border-dark rounded">
            <h6 id="hall-name" class="card-title">{{ hallData.name }}</h6>
            <p class="hall-info">{{ hallData.building }}</p>
            <p class="hall-info">Floor: {{ hallData.floor }}</p>
            <p class="hall-info">Capacity: {{ hallData.capacity }}</p>
            <button
              data-bs-toggle="modal"
              data-bs-target="#exampleModal"
              type="button"
              id="bookButton"
              class="btn btn-primary w-100"
            >
              Book
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Create event modal -->
    <div
      class="modal fade"
      id="exampleModal"
      tabindex="-1"
      aria-labelledby="exampleModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Book Hall</h5>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
              aria-label="Close"
            ></button>
          </div>
          <form @submit.prevent="handleBooking">
            <div class="modal-body">
              <div class="mb-3">
                <label class="form-label">Event name</label>
                <input
                  type="text"
                  class="form-control"
                  v-model="bookingData.event_name"
                  id="NameInput"
                />
              </div>
              <div class="mb-3">
                <label class="form-label">Event Description</label>
                <textarea
                  class="form-control"
                  id="exampleFormControlTextarea1"
                  v-model="bookingData.event_desc"
                  rows="3"
                ></textarea>
              </div>

              <div class="mb-3">
                <label for="DateInput" class="form-label">Date</label>
                <input
                  type="date"
                  v-model="bookingData.event_date"
                  class="form-control"
                />
              </div>
              <div class="mb-3">
                <label for="formFileMultiple" class="form-label"
                  >Select one or more files</label
                >
                <input
                  class="form-control"
                  type="file"
                  accept="image/png, image/gif, image/jpeg"
                  @change="uploadImage"
                  id="formFileMultiple"
                  multiple
                />
              </div>
              <label for="customRange2" class="form-label"
                >Capacity ({{ bookingData.event_capacity }})</label
              >
              <input
                type="range"
                class="form-range"
                min="1"
                :max="hallData.capacity"
                id="customRange2"
                v-model="bookingData.event_capacity"
              />
              <div class="mb-3">
                <label for="TimeSlotInput" class="form-label">Time slots</label>
                <div class="form-check">
                  <input
                    class="form-check-input"
                    type="checkbox"
                    value="8AM - 9AM"
                    id="flexCheckDefault"
                    v-model="bookingData.event_timeslots"
                  />
                  <label class="form-check-label" for="flexCheckDefault">
                    8AM - 9AM
                  </label>
                </div>
                <div class="form-check">
                  <input
                    class="form-check-input"
                    type="checkbox"
                    value="9AM - 10AM"
                    id="flexCheckDefault"
                    v-model="bookingData.event_timeslots"
                  />
                  <label class="form-check-label" for="flexCheckDefault">
                    9AM - 10AM
                  </label>
                </div>
                <div class="form-check">
                  <input
                    class="form-check-input"
                    type="checkbox"
                    value="10AM - 11AM"
                    id="flexCheckDefault"
                    v-model="bookingData.event_timeslots"
                  />
                  <label class="form-check-label" for="flexCheckDefault">
                    10AM - 11AM
                  </label>
                </div>
                <div class="form-check">
                  <input
                    class="form-check-input"
                    type="checkbox"
                    value="11AM - 12PM"
                    id="flexCheckDefault"
                    v-model="bookingData.event_timeslots"
                  />
                  <label class="form-check-label" for="flexCheckDefault">
                    11AM - 12PM
                  </label>
                </div>
                <div class="form-check">
                  <input
                    class="form-check-input"
                    type="checkbox"
                    value="12PM - 1PM"
                    id="flexCheckDefault"
                    v-model="bookingData.event_timeslots"
                  />
                  <label class="form-check-label" for="flexCheckDefault">
                    12PM - 1PM
                  </label>
                </div>
                <div class="form-check">
                  <input
                    class="form-check-input"
                    type="checkbox"
                    value="1PM - 2PM"
                    id="flexCheckDefault"
                    v-model="bookingData.event_timeslots"
                  />
                  <label class="form-check-label" for="flexCheckDefault">
                    1PM - 2PM
                  </label>
                </div>
                <div class="form-check">
                  <input
                    class="form-check-input"
                    type="checkbox"
                    value="2PM - 3PM"
                    id="flexCheckDefault"
                    v-model="bookingData.event_timeslots"
                  />
                  <label class="form-check-label" for="flexCheckDefault">
                    2PM - 3PM
                  </label>
                </div>
              </div>
            </div>
            <div class="modal-footer">
              <button
                type="button"
                class="btn btn-secondary"
                data-bs-dismiss="modal"
              >
                Cancel
              </button>
              <button data-bs-dismiss="modal" class="btn btn-primary">
                Submit
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
    <!-- Create event modal ends -->
    <div class="row heading px-4 mt-5">Upcoming Events</div>
    <div class="media-scroller my-3 p-2">
      <event-card
        v-for="event in events"
        :key="event._id"
        :event_date="event.date"
        :event_desc="event.description"
        :event_name="event.name"
        :event_time="event.time_slot"
        :event_images="event.images"
        :hall_id="event.hall_id"
        :id="event._id"
      />
    </div>
    <p class="text-muted text-center my-4" v-if="events.length == 0">
      No events are taking place
    </p>
  </div>
</template>

<script setup>
import EventCard from "../components/individual_hall/EventCard.vue";
import { ref, onMounted } from "vue";
import axios from "axios";
import { useRoute, useRouter } from "vue-router";
import { useAuthStore } from "../store/authStore";
const router = useRouter();
const route = useRoute();

//Load Hall Info
let hallData = ref({});
let events = ref([]);
const loadHallData = async () => {
  try {
    const token = localStorage.getItem("token");
    const hallResponse = await axios
      .get(import.meta.env.VITE_SERVER_URL + "/halls/" + route.params.id, {
        headers: {
          authorization: "Bearer " + token,
        },
      })
      .then((res) => {
        hallData.value = res.data.hall;
      });
    const eventsResponse = await axios
      .get(
        import.meta.env.VITE_SERVER_URL + "/events/hall/" + route.params.id,
        {
          headers: {
            authorization: "Bearer " + token,
          },
        }
      )
      .then((res) => {
        events.value = res.data.events;
      });
  } catch (err) {
    console.log(err);
  }
};

//Booking Logic
const authStore = useAuthStore();
let bookingData = ref({
  event_name: "",
  event_desc: "",
  event_date: "",
  event_timeslots: ref([]),
  images: null,
  event_capacity: 1,
});
const handleBooking = async () => {
  try {
    const username = localStorage.getItem("username");
    const formData = new FormData();
    for (const i of Object.keys(bookingData.value.images)) {
      formData.append("images", bookingData.value.images[i]);
    }
    formData.append("name", bookingData.value.event_name);
    formData.append("description", bookingData.value.event_desc);
    formData.append("date", bookingData.value.event_date);
    formData.append("capacity", bookingData.value.event_capacity);
    for (const i of Object.keys(bookingData.value.event_timeslots)) {
      formData.append("timeSlot", bookingData.value.event_timeslots[i]);
    }
    formData.append("hallID", hallData.value._id);
    formData.append("username", username);
    formData.append("dept", authStore.userData.dept);
    formData.append("job", authStore.userData.job);
    const bookingResponse = await axios
      .post(import.meta.env.VITE_SERVER_URL + "/book/events", formData)
      .then((res) => {
        router.replace("/");
      });
  } catch (err) {
    let error = err.response.data ? err.response.data.error : err;
    alert(err);
  }
};
const uploadImage = (event) => {
  bookingData.value.images = event.target.files;
};

onMounted(() => {
  loadHallData();
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
