<template>
  <div class="container-fluid" id="home">
    <div class="row px-2 mt-4" v-if="navBarStore.query == ''">
      <span class="heading">Recommended Halls</span>
    </div>
    <div class="row px-2 mt-4" v-else>
      <span class="heading">Searched Halls</span>
    </div>
    <div class="my-3 p-2 media-scroller" v-if="hallStore.getHallsLength != 0">
      <hall-card
        v-for="hall in filteredHalls"
        :key="hall._id"
        :hall_block="hall.building"
        :hall_capacity="hall.capacity"
        :hall_floor="hall.floor"
        :hall_name="hall.name"
        :id="hall._id"
        :hall_images="hall.images"
      />
    </div>
    <h6
      v-else-if="hallStore.getHallsLength == 0 && navBarStore.query == ''"
      class="text-center my-5 text-muted"
    >
      No halls to Recommend
    </h6>
    <h6
      v-if="filteredHalls.length == 0 && navBarStore.query != ''"
      class="text-center my-5 text-muted"
    >
      Hall not found
    </h6>

    <div class="row px-2 mt-4" v-if="navBarStore.query == ''">
      <span class="heading">Upcoming Events</span>
    </div>
    <div class="row px-2 mt-4" v-else>
      <span class="heading">Searched Events</span>
    </div>
    <div class="media-scroller my-3 p-2" v-if="eventStore.getEventsLength != 0">
      <event-card
        v-for="event in filteredEvents"
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
    <h6
      v-else-if="eventStore.getEventsLength == 0 && navBarStore.query == ''"
      class="text-center my-5 text-muted"
    >
      No events to Recommend
    </h6>
    <h6
      v-if="filteredEvents.length == 0 && navBarStore.query != ''"
      class="text-center my-5 text-muted"
    >
      Event not found
    </h6>
  </div>
</template>

<script setup>
import {computed, onMounted} from 'vue'

import HallCard from "../components/home/HallCard.vue";
import EventCard from "../components/home/EventCard.vue";

import { useAuthStore } from '../store/authStore';
import {useHallsStore} from '../store/hallsStore';
import {useEventsStore} from '../store/eventsStore';
import { useNavBarStore } from '../store/navBarStore';

const authStore = useAuthStore();
const navBarStore = useNavBarStore();

//Halls
const hallStore = useHallsStore();
let filteredHalls = computed(()=>{
  if (navBarStore.query) {
        return hallStore.halls.filter((hall) => {
          return hall.name
            .toLowerCase()
            .includes(navBarStore.query.toLowerCase());
        });
      } else {
        return hallStore.halls;
      }
})

//Events
const eventStore = useEventsStore();
let filteredEvents = computed(()=>{
  if (navBarStore.query) {
        return eventStore.events.filter((event) => {
          return event.name
            .toLowerCase()
            .includes(navBarStore.query.toLowerCase());
        });
      } else {
        return eventStore.events;
      }
})

onMounted(()=>{
  hallStore.getHalls();
  eventStore.getEvents();
  authStore.getUserInfo();
})

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
</style>
