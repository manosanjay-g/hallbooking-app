<template>
  <router-link :to="routeName">
    <div class="card" id="event" style="width: 14rem; min-height: 20rem">
      <img :src="event_images[0]" class="card-img-top" alt="..." />
      <div class="card-body rounded-bottom bg-dark text-white text-center">
        <h6 id="event-name" class="card-title h4">{{ event_name }}</h6>
        <p class="event-info" v-if="event_desc.length > 69">
          {{ event_desc.substring(0, 70) + " ......" }}
        </p>
        <p class="event-info" v-else>
          {{ event_desc }}
        </p>
        <p class="event-info">{{ new Date(event_date).toDateString() }}</p>
      </div>
    </div>
  </router-link>
</template>

<script>
export default {
  props: [
    "event_name",
    "event_date",
    "event_time",
    "event_desc",
    "event_images",
    "id",
  ],
  computed: {
    routeName() {
      return "/events/" + this.id;
    },
  },
};
</script>

<style scoped>
#event {
  border-radius: 0.9375rem;
}
#event img {
  object-fit: cover;
  object-position: center;
  overflow: hidden;
  height: 10rem;
}
#event:hover {
  transform: translate3D(0, -1px, 0) scale(1.03);
  box-shadow: 8px 28px 50px rgba(39, 44, 49, 0.07),
    1px 6px 12px rgba(39, 44, 49, 0.04);
  transition: all 0.4s ease; /* zoom in */
  border-radius: 0.9375rem;
}
#event-name {
  font-size: 1.25rem;
}
.event-info {
  font-size: 0.75rem;
}
</style>
