<template>
  <nav class="navbar navbar-expand-lg navbar-dark" id="navbar">
    <div class="container-fluid">
      <router-link to="/" class="navbar-brand" href="#"
        >Hall Booking</router-link
      >
      <form
        class="d-flex"
        role="search"
        v-if="authStore.userData != [] && currentRoute == 'home'"
      >
        <input
          class="form-control me-2"
          type="search"
          placeholder="Search for Halls and Events"
          aria-label="Search"
          id="search-bar"
          @keyup="setSearchQuery"
          v-if="
            currentRoute != 'admin dashboard' &&
            currentRoute != 'admin events' &&
            currentRoute != 'admin halls' &&
            currentRoute != 'admin users'
          "
        />
      </form>
      <button
        class="navbar-toggler"
        type="button"
        data-bs-toggle="collapse"
        data-bs-target="#navbarNav"
        aria-controls="navbarNav"
        aria-expanded="false"
        aria-label="Toggle navigation"
      >
        <span class="navbar-toggler-icon"></span>
      </button>
      <div
        class="collapse navbar-collapse"
        v-if="authStore.isLoggedIn == true"
        id="navbarNav"
      >
        <ul class="navbar-nav ms-auto">
          <li class="nav-item">
            <a
              class="nav-link active"
              aria-current="page"
              id="account-section"
              href="#"
            >
              <span class="material-icons px-2">account_circle</span>
              <li class="nav-item dropdown">
                <a
                  class="nav-link dropdown-toggle"
                  href="#"
                  id="navbarDarkDropdownMenuLink"
                  role="button"
                  data-bs-toggle="dropdown"
                  aria-expanded="false"
                >
                  Hi , {{ authStore.userData.name }}
                </a>
                <ul
                  style="min-width: 12rem"
                  class="dropdown-menu dropdown-menu-dark"
                  aria-labelledby="navbarDarkDropdownMenuLink"
                >
                  <li>
                    <router-link
                      to="/profile/events"
                      class="dropdown-item"
                      href="#"
                      >Booked Events</router-link
                    >
                  </li>
                  <li class="nav-item dropdown" v-if="authStore.getAdminState">
                    <router-link
                      to="/admin/dashboard"
                      class="dropdown-item"
                      href="#"
                      >Dashboard (Admin)</router-link
                    >
                  </li>
                  <li class="nav-item dropdown" v-if="authStore.getAdminState">
                    <router-link
                      to="/admin/users"
                      class="dropdown-item"
                      href="#"
                      >Users (Admin)</router-link
                    >
                  </li>
                  <li class="nav-item dropdown" v-if="authStore.getAdminState">
                    <router-link
                      to="/admin/halls"
                      class="dropdown-item"
                      href="#"
                      >Halls (Admin)</router-link
                    >
                  </li>
                  <li class="nav-item dropdown" v-if="authStore.getAdminState">
                    <router-link
                      to="/admin/events"
                      class="dropdown-item"
                      href="#"
                      >Events (Admin)</router-link
                    >
                  </li>
                  <!-- <li><span class="dropdown-item" href="#">Profile</span></li> -->
                  <li>
                    <span class="dropdown-item" @click="handleSignOut"
                      >Sign Out</span
                    >
                  </li>
                </ul>
              </li>
            </a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</template>
<script setup>
import { computed } from "vue";
import { useRoute } from "vue-router";
import { useAuthStore } from "../store/authStore";
import { useNavBarStore } from "../store/navBarStore";
const route = useRoute();

const authStore = useAuthStore();
const navBarStore = useNavBarStore();

let currentRoute = computed(() => {
  return route.name;
});

authStore.getUserInfo();
authStore.checkLoginState();

const handleSignOut = () => {
  authStore.logout();
};

const setSearchQuery = (event) => {
  navBarStore.setSearchQuery(event.target.value);
};
</script>
<style scoped>
#account-section {
  display: flex;
  flex-direction: row;
  align-items: center;
}
#navbar {
  background-color: #2e0249;
}
#search-bar {
  padding: 0.075rem 0.75rem;
}
#user-greetings {
  font-size: 0.8125rem;
}
</style>
