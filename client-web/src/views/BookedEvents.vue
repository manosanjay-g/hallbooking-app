<template>
  <div class="container-fluid mx-2">
    <div class="row mt-4 px-2">
      <span class="heading" v-if="!showModal">Booked Events</span>
    </div>
    <div
      v-if="eventsStore.getEventsByUserLength != 0 && !showModal"
      class="media-scroller my-3 p-2"
    >
      <event-card
        v-for="event in eventsStore.getEventsByUser"
        :key="event._id"
        :event_date="event.date"
        :event_desc="event.description"
        :event_name="event.name"
        :event_time="event.time_slot"
        :event_images="event.images"
        :hall_id="event.hall_id"
        @click="toggleModal(event)"
      />
    </div>

    <h6
      v-else-if="eventsStore.getEventsByUserLength == 0"
      class="text-center my-5 text-muted"
    >
      No events have been booked by you
    </h6>

    <div v-if="showModal" class="row my-3 justify-content-center">
      <div class="col-4">
        <div class="card" id="hall" style="width: 35rem; margin: 0">
          <div class="card-body border border-dark rounded">
            <h3>Edit Event</h3>
            <form @submit.prevent="handleEdit">
              <div class="mb-3">
                <label for="BatsmanLabel" class="form-label">Event name</label>
                <input
                  type="text"
                  class="form-control"
                  v-model="event.name"
                  id="NameInput"
                />
              </div>
              <div class="mb-3">
                <label for="BowlerLabel" class="form-label"
                  >Event Description</label
                >
                <textarea
                  class="form-control"
                  id="exampleFormControlTextarea1"
                  v-model="event.description"
                  rows="3"
                ></textarea>
              </div>

              <div class="mb-3">
                <label for="DateInput" class="form-label">Date</label>
                <input type="date" v-model="event.date" class="form-control" />
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

              <div class="mb-3">
                <label for="TimeSlotInput" class="form-label">Time slots</label>
                <div class="form-check">
                  <input
                    class="form-check-input"
                    type="checkbox"
                    v-model="event.time_slot"
                    value="8AM - 9AM"
                    id="8AM_9AM"
                  />
                  <label class="form-check-label" for="8AM_9AM">
                    8AM - 9AM
                  </label>
                </div>
                <div class="form-check">
                  <input
                    class="form-check-input"
                    type="checkbox"
                    v-model="event.time_slot"
                    value="9AM - 10AM"
                    id="9AM_10AM"
                  />
                  <label class="form-check-label" for="9AM_10AM">
                    9AM - 10AM
                  </label>
                </div>
                <div class="form-check">
                  <input
                    class="form-check-input"
                    type="checkbox"
                    v-model="event.time_slot"
                    value="10AM - 11AM"
                    id="10AM_11AM"
                  />
                  <label class="form-check-label" for="10AM_11AM">
                    10AM - 11AM
                  </label>
                </div>
                <div class="form-check">
                  <input
                    class="form-check-input"
                    type="checkbox"
                    v-model="event.time_slot"
                    value="11AM - 12PM"
                    id="11AM_12PM"
                  />
                  <label class="form-check-label" for="11AM_12PM">
                    11AM - 12PM
                  </label>
                </div>
                <div class="form-check">
                  <input
                    class="form-check-input"
                    type="checkbox"
                    v-model="event.time_slot"
                    value="12PM - 1PM"
                    id="12PM_1PM"
                  />
                  <label class="form-check-label" for="12PM_1PM">
                    12PM - 1PM
                  </label>
                </div>
                <div class="form-check">
                  <input
                    class="form-check-input"
                    type="checkbox"
                    v-model="event.time_slot"
                    value="1PM - 2PM"
                    id="1PM_2PM"
                  />
                  <label class="form-check-label" for="1PM_2PM">
                    1PM - 2PM
                  </label>
                </div>
                <div class="form-check">
                  <input
                    class="form-check-input"
                    type="checkbox"
                    v-model="event.time_slot"
                    value="2PM - 3PM"
                    id="2PM_3PM"
                  />
                  <label class="form-check-label" for="2PM_3PM">
                    2PM - 3PM
                  </label>
                </div>
              </div>
              <div class="row">
                <div class="col">
                  <button
                    @click="toggleModal"
                    type="button"
                    class="btn btn-danger me-3 my-3"
                  >
                    Cancel
                  </button>
                  <button
                    @click="handleRemove(event._id)"
                    type="button"
                    class="btn btn-danger me-3 my-3"
                  >
                    Delete
                  </button>
                  <button class="btn btn-success">Submit</button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import axios from "axios";
import EventCard from "../components/booked_events/EventCard.vue";
import { useEventsStore } from "../store/eventsStore";
import { useHallsStore } from "../store/hallsStore";
import { ref } from "vue";
import { useRouter } from "vue-router";

const router = useRouter();

const hallStore = useHallsStore();
const eventsStore = useEventsStore();

//Initialize the data
let showModal = ref(false);
let event = ref({
  name: "",
  description: "",
  date: "",
  time_slot: ref([]),
  images: null,
  capacity: 1,
});

//Handle Edit
const handleEdit = async () => {
  try {
    const token = localStorage.getItem("token");
    console.log(token);
    const formData = new FormData();
    for (const i of Object.keys(event.value.images)) {
      formData.append("images", event.value.images[i]);
    }

    const config = {
      headers: {
        authorization: "Bearer " + token,
      },
    };
    if (
      event.value.name == "" ||
      event.value.description == "" ||
      event.value.date == "" ||
      event.value.time_slot == []
    ) {
      alert("All inputs are required");
    } else {
      formData.append("name", event.value.name);
      formData.append("hallID", event.value.hall_id);
      formData.append("description", event.value.description);
      formData.append("date", event.value.date);
      formData.append("capacity", event.value.capacity);
      for (const i of Object.keys(event.value.time_slot)) {
        formData.append("timeSlot", event.value.time_slot[i]);
      }
      let response = await axios
        .post(
          import.meta.env.VITE_SERVER_URL + "/events/manage/" + event.value._id,
          formData,
          config
        )
        .then((res) => {
          console.log(res.data);
          router.go(0);
        });
    }
  } catch (err) {
    alert(err);
  }
};
//Handle Remove
const handleRemove = async (id) => {
  try {
    const token = localStorage.getItem("token");
    console.log(id, token);
    const config = {
      headers: {
        authorization: "Bearer " + token,
      },
    };
    let response = await axios
      .delete(
        import.meta.env.VITE_SERVER_URL + "/admin/delete/events/" + id,
        config
      )
      .then((res) => {
        console.log(res);
      });
    router.go(0);
  } catch (err) {
    console.log(err);
  }
};
//Upload Image
const uploadImage = async (e) => {
  event.value.images = e.target.files;
};
//Toggle Modal
const toggleModal = async (event) => {
  event.value = event;
  showModal.value = !showModal.value;
};

hallStore.getHalls();
eventsStore.getEvents();
</script>
<style scoped>
.media-scroller {
  display: grid;
  grid-auto-flow: column;
  grid-auto-columns: 18%;
  overflow-x: auto;
  overscroll-behavior-inline: contain;
}
.heading {
  font-size: 1.25rem;
  font-weight: bold;
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
