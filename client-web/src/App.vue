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

<template >
  <navbar />
  <RouterView />
  <!-- <footer-component /> -->
</template>

<style>
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
