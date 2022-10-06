<template>
  <router-link :to="routeName">
    <div class="card" id="hall" style="width: 14rem">
      <img :src="props.hall_images[0]" class="card-img-top" alt="..." />
      <div class="card-body rounded-bottom bg-dark text-white text-center">
        <h6 id="hall-name" class="card-title">{{ props.hall_name }}</h6>
        <p class="hall-info">{{ props.hall_block }}</p>
        <p class="hall-info">Floor: {{ props.hall_floor }}</p>
        <p class="hall-info">Capacity: {{ props.hall_capacity }}</p>
      </div>
    </div>
  </router-link>
</template>
<script setup>
import { computed } from 'vue';

const props = defineProps( [
    "hall_name",
    "hall_block",
    "hall_floor",
    "hall_capacity",
    "id",
    "hall_images",
])

let routeName = computed(()=>{
      return "/halls/" + props.id;
})

</script>
<style scoped>
#hall {
  border-radius: 0.9375rem;
}
#hall img {
  object-fit: cover;
  object-position: center;
  overflow: hidden;
  height: 10rem;
}
#hall:hover {
  transform: translate3D(0, -1px, 0) scale(1.03);
  box-shadow: 8px 28px 50px rgba(39, 44, 49, 0.07),
    1px 6px 12px rgba(39, 44, 49, 0.04);
  transition: all 0.4s ease; /* zoom in */
  border-radius: 0.9375rem;
}
#hall-name {
  font-size: 1.25rem;
}
.hall-info {
  font-size: 0.75rem;
}
</style>
