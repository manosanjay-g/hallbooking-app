<script>
import Navbar from "./components/NavbarComponent.vue";
import FooterComponent from "./components/FooterComponent.vue";
export default {
  components: {
    Navbar,
    FooterComponent,
  },
};
</script>

<template>
  <navbar />
  <RouterView v-if="!showModal" />
  <!-- Create event modal -->

  <div v-if="showModal" class="row my-3 mb-5 justify-content-center">
    <div class="col-4">
      <div class="card" id="hall" style="width: 35rem; margin: 0">
        <div class="card-body border border-dark rounded">
          <h3>Book Event</h3>
          <form @submit.prevent="handleBooking">
            <div class="modal-body">
              <div class="mb-3">
                <label for="DateInput" class="form-label">Date</label>
                <input
                  type="date"
                  class="form-control"
                  v-model="bookingData.event_date"
                />
              </div>

              <label for="formFileMultiple" class="form-label">Capacity</label>
              <div class="input-group input-group-sm mb-3">
                <span
                  class="input-group-text"
                  id="inputGroup-sizing-sm"
                  role="button"
                  @click="
                    bookingData.event_capacity == 0
                      ? (bookingData.event_capacity = 0)
                      : (bookingData.event_capacity =
                          bookingData.event_capacity - 5)
                  "
                  >-5</span
                >
                <input
                  type="text"
                  class="form-control"
                  v-model="bookingData.event_capacity"
                  aria-describedby="inputGroup-sizing-sm"
                  min="0"
                  placeholder="0"
                />
                <span
                  class="input-group-text"
                  id="inputGroup-sizing-sm "
                  role="button"
                  @click="
                    bookingData.event_capacity = bookingData.event_capacity + 5
                  "
                  >+5</span
                >
              </div>
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
              <div id="recHalls" v-if="recommendedHalls.length != 0">
                <h6>Recommended Halls</h6>
                <div class="container-fluid border mx-1 pt-3 rounded">
                  <div class="row mb-3 px-3">
                    <div class="col">Image</div>
                    <div class="col">Description</div>
                  </div>
                  <div class="row">
                    <button data-bs-dismiss="modal" class="btn btn-success">
                      Select Hall
                    </button>
                  </div>
                </div>
              </div>
              <div class="mb-3 mt-3" v-if="recommendedHalls.length != 0">
                <label class="form-label">Event name</label>
                <input
                  type="text"
                  class="form-control"
                  id="NameInput"
                  v-model="bookingData.event_name"
                  placeholder="Event name..You can change it later"
                />
              </div>
              <div class="mb-3 mt-3" v-if="recommendedHalls.length != 0">
                <label class="form-label">Event Description</label>
                <textarea
                  class="form-control"
                  id="exampleFormControlTextarea1"
                  rows="3"
                  v-model="bookingData.event_desc"
                  placeholder="Event description..You can change it later"
                ></textarea>
              </div>
            </div>
            <div class="modal-footer">
              <button
                type="button"
                class="btn btn-danger mx-2"
                @click="showModal = false"
              >
                Cancel
              </button>
              <button
                data-bs-dismiss="modal"
                @click="searchRecommendedHalls"
                class="btn btn-primary mx-2"
              >
                Search
              </button>
              <button :disabled="disabled" class="btn btn-success mx-2">
                Submit
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
  <!-- Create event modal ends -->
  <!-- <footer-component /> -->
  <footer
    class="footer mt-auto fixed-bottom mt-2"
    v-if="currentRoute == 'home'"
  >
    <div class="container-fluid px-0 flex justify-content-center">
      <div class="row justify-content-center">
        <div class="col">
          <button
            type="button"
            @click="showModal = !showModal"
            class="btn btn-outline text-light w-100 py-2"
            id="bookForEvent"
          >
            Book for an event
          </button>
        </div>
      </div>
    </div>
  </footer>
</template>

<script setup>
import { computed } from "vue";
import { useAuthStore } from "./store/authStore";
import { ref, onMounted } from "vue";

import { useRoute } from "vue-router";
const route = useRoute();
let currentRoute = computed(() => {
  return route.name;
});

let disabled = ref(true);
let showModal = ref(false);
//Booking Logic
const authStore = useAuthStore();
let recommendedHalls = ref([]);
let bookingData = ref({
  event_name: "",
  event_desc: "",
  event_date: "",
  event_timeslots: ref([]),
  event_capacity: 0,
});
const searchRecommendedHalls = async () => {
  if (
    bookingData.value.date == "" ||
    [...bookingData.value.event_timeslots].length == 0 ||
    bookingData.value.event_capacity == 0
  ) {
    alert("Feed the required information");
  }
  recommendedHalls.value.push({});
};
// const handleBooking = async () => {
//   try {
//     const username = localStorage.getItem("username");
//     const formData = new FormData();
//     formData.append("name", bookingData.value.event_name);
//     formData.append("description", bookingData.value.event_desc);
//     formData.append("date", bookingData.value.event_date);
//     formData.append("capacity", bookingData.value.event_capacity);
//     for (const i of Object.keys(bookingData.value.event_timeslots)) {
//       formData.append("timeSlot", bookingData.value.event_timeslots[i]);
//     }
//     formData.append("hallID", hallData.value._id);
//     formData.append("username", username);
//     formData.append("dept", authStore.userData.dept);
//     formData.append("job", authStore.userData.job);
//     const bookingResponse = await axios
//       .post(import.meta.env.VITE_SERVER_URL + "/book/events", formData)
//       .then((res) => {
//         router.replace("/");
//       });
//   } catch (err) {
//     let error = err.response.data ? err.response.data.error : err;
//     alert(err);
//   }
// };

onMounted(() => {
  authStore.getUserInfo();
});
</script>

<style>
#bookForEvent {
  border-radius: 0 !important;
}
#bookForEvent:hover {
  color: white !important;
  background-color: #198754;
}
footer {
  background-color: #2e0249;
}
a {
  text-decoration: none;
}
body {
  font-family: "Montserrat", sans-serif;
}

/* Hide scrollbar for Chrome, Safari and Opera */
::-webkit-scrollbar {
  display: none;
}

/* Hide scrollbar for IE, Edge and Firefox */
html {
  -ms-overflow-style: none; /* IE and Edge */
  scrollbar-width: none; /* Firefox */
}
</style>
