<template>
  <footer
    v-if="getUserDataLength != 0"
    id="footer"
    class="text-center text-white"
  >
    <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2)">
      <a class="text-primary" href="https://www.rajalakshmi.org/"
        >Rajalakshmi Engineering College</a
      >
      © 2022 |
      <span>Made by students of 2nd year CSE-C (2024)</span>
    </div>
  </footer>
</template>
<style scoped>
#footer {
  background-color: #2e0249;
}
</style>
<script>
import { mapGetters } from "vuex";
export default {
  computed: {
    ...mapGetters(["getUserDataLength"]),
  },
  methods: {},
};
</script>