<template>
  <div class="container-fluid">
    <div class="row vh-100">
      <div class="col pt-5">
        <div class="row">
          <div class="col">
            <div
              class="d-flex justify-content-between"
              role="search"
              style="width: 500px"
            >
              <input
                class="form-control me-2"
                type="search"
                placeholder="Search"
                aria-label="Search"
                v-model="searchQuery"
              />
              <button class="btn btn-outline-success" type="submit">
                Search
              </button>
            </div>
          </div>
        </div>

        <div class="scrollable" v-if="!showModal && filteredEvents.length != 0">
          <table class="table table-bordered border-primary mt-4">
            <thead>
              <tr>
                <th scope="col">S.NO</th>
                <th scope="col">Name</th>
                <th scope="col">Description</th>
                <th scope="col">Date</th>
                <th scope="col">Time Slot</th>
                <th scope="col">Hall</th>
                <th scope="col">User ID</th>
                <th scope="col">User Dept</th>
                <th scope="col">User Job</th>
                <th scope="col">Action</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(event, index) in filteredEvents" :key="event._id">
                <th scope="row">{{ index + 1 }}</th>
                <td>{{ event.name }}</td>
                <td>{{ event.description }}</td>
                <td>{{ event.date }}</td>
                <td>{{ event.time_slot }}</td>
                <td>{{ getHallName(event.hall_id) }}</td>
                <td>{{ event.user_id }}</td>
                <td>{{ event.user_dept }}</td>
                <td>{{ event.user_job }}</td>
                <td>
                  <span class="actionbtns" @click="handleRemove(event._id)"
                    >Remove</span
                  >
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        <p
          v-else-if="!showModal && filteredEvents.length == 0"
          class="text-muted py-4 text-center"
        >
          Event not found
        </p>
      </div>
    </div>
  </div>
</template>
<style scoped>
.scrollable {
  overflow-x: scroll;
}
.actionbtns {
  color: rgb(61, 61, 255);
  cursor: pointer;
}
</style>
<script>
import axios from "axios";
import { mapGetters } from "vuex";
export default {
  computed: {
    ...mapGetters(["getHallName"]),
    filteredEvents() {
      if (this.searchQuery) {
        return this.events.filter((event) => {
          return event.name
            .toLowerCase()
            .includes(this.searchQuery.toLowerCase());
        });
      } else {
        return this.events;
      }
    },
  },
  data() {
    return {
      searchQuery: "",
      events: [],
      user: {
        username: "",
        name: "",
        email: "",
        password: "",
        dept: "",
        job: "",
        role: "",
      },
      showModal: false,
    };
  },
  created() {
    this.$store.dispatch("setHalls");
  },
  mounted() {
    this.getEventsInfoAdmin();
    this.$store.dispatch("setEvents");
    const email = localStorage.getItem("email");
    this.$store.dispatch("getUserInfo", email);
  },
  methods: {
    getEventsInfoAdmin() {
      try {
        const token = localStorage.getItem("token");
        const config = {
          headers: {
            authorization: "Bearer " + token,
          },
        };
        const hall = axios
          .get(import.meta.env.VITE_SERVER_URL + "/events/", config)
          .then((res) => {
            console.log(res.data);
            this.events = res.data.events;
          });
      } catch (err) {
        console.log(err);
      }
    },
    async handleSubmit() {
      try {
        if (
          this.user.email == "" ||
          this.user.password == "" ||
          this.user.username == "" ||
          this.user.name == "" ||
          this.user.dept == "" ||
          this.user.role == "" ||
          this.user.job == ""
        ) {
          alert("All inputs are required");
        } else {
          let response = await axios
            .post(import.meta.env.VITE_SERVER_URL + "/auth/register", this.user)
            .then((res) => {
              console.log(res.data);
              this.$router.go(0);
            });
        }
      } catch (err) {
        console.log(err.response);
      }
    },
    async handleRemove(id) {
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
        this.$router.go(0);
      } catch (err) {
        console.log(err);
      }
    },
    async handleEdit() {
      try {
        const token = localStorage.getItem("token");
        console.log(token);
        const config = {
          headers: {
            authorization: "Bearer " + token,
          },
        };
        if (
          this.user.email == "" ||
          this.user.password == "" ||
          this.user.username == "" ||
          this.user.name == "" ||
          this.user.dept == "" ||
          this.user.role == "" ||
          this.user.job == ""
        ) {
          alert("All inputs are required");
        } else {
          let response = await axios
            .post(
              import.meta.env.VITE_SERVER_URL +
                "/admin/manage/users/" +
                this.user._id,
              this.user,
              config
            )
            .then((res) => {
              console.log(res.data);
              this.$router.go(0);
            });
        }
      } catch (err) {
        console.log(err.response);
      }
    },
    toggleModal(user) {
      this.user = user;
      this.showModal = !this.showModal;
    },
    handleClear() {
      this.user = {};
    },
  },
};
</script>