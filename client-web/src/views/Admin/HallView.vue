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
          <div class="col">
            <button
              type="button"
              class="btn btn-primary"
              data-bs-toggle="modal"
              data-bs-target="#exampleModal"
            >
              Create
            </button>
          </div>
        </div>
        <!--Create User Modal -->
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
                <h5 class="modal-title" id="exampleModalLabel">
                  Create a Hall
                </h5>
                <button
                  type="button"
                  class="btn-close"
                  data-bs-dismiss="modal"
                  aria-label="Close"
                ></button>
              </div>
              <form @submit.prevent="handleSubmit">
                <div class="modal-body">
                  <div class="mb-3">
                    <label class="form-label">Name</label>
                    <input
                      type="text"
                      v-model="hall.name"
                      class="form-control"
                    />
                  </div>
                  <div class="mb-3">
                    <label class="form-label">Description</label>
                    <input
                      type="text"
                      v-model="hall.description"
                      class="form-control"
                    />
                  </div>
                  <div class="mb-3">
                    <label class="form-label">Building</label>
                    <input
                      type="text"
                      v-model="hall.building"
                      class="form-control"
                    />
                  </div>
                  <div class="mb-3">
                    <label class="form-label">Floor</label>
                    <input
                      type="text"
                      v-model="hall.floor"
                      class="form-control"
                    />
                  </div>
                  <div class="mb-3">
                    <label class="form-label">Capacity</label>
                    <input
                      type="text"
                      v-model="hall.capacity"
                      class="form-control"
                    />
                  </div>
                  <div class="mb-3">
                    <label for="formFileMultiple" class="form-label"
                      >Select one or more files for hall images</label
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
                </div>
                <div class="modal-footer">
                  <button
                    type="button"
                    class="btn btn-secondary"
                    data-bs-dismiss="modal"
                  >
                    Cancel
                  </button>
                  <button class="btn btn-primary">Submit</button>
                </div>
              </form>
            </div>
          </div>
        </div>

        <div class="scrollable" v-if="!showModal && filteredHalls.length != 0">
          <table class="table table-bordered border-primary mt-4">
            <thead>
              <tr>
                <th scope="col">S.NO</th>
                <th scope="col">Name</th>
                <th scope="col">Building</th>
                <th scope="col">Floor</th>
                <th scope="col">Capacity</th>
                <th scope="col">Action</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(hall, index) in filteredHalls" :key="hall._id">
                <th scope="row">{{ index + 1 }}</th>
                <td>{{ hall.name }}</td>
                <td>{{ hall.building }}</td>
                <td>{{ hall.floor }}</td>
                <td>{{ hall.capacity }}</td>
                <td>
                  <span class="actionbtns" @click="toggleModal(hall)"
                    >Edit</span
                  >
                  |
                  <span class="actionbtns" @click="handleRemove(hall._id)"
                    >Remove</span
                  >
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        <p
          v-else-if="!showModal && filteredHalls.length == 0"
          class="text-muted py-4 text-center"
        >
          Hall not found
        </p>
        <div v-if="showModal" class="row my-3 justify-content-center">
          <div class="col">
            <div class="card" id="hall">
              <div class="card-body border border-dark rounded">
                <h3>Edit Hall</h3>

                <form @submit.prevent="handleEdit">
                  <div class="mb-3">
                    <label class="form-label">Name</label>
                    <input
                      type="text"
                      v-model="hall.name"
                      class="form-control"
                    />
                  </div>
                  <div class="mb-3">
                    <label class="form-label">Description</label>
                    <input
                      type="text"
                      v-model="hall.description"
                      class="form-control"
                    />
                  </div>
                  <div class="mb-3">
                    <label class="form-label">Building</label>
                    <input
                      type="text"
                      v-model="hall.building"
                      class="form-control"
                    />
                  </div>
                  <div class="mb-3">
                    <label class="form-label">Floor</label>
                    <input
                      type="text"
                      v-model="hall.floor"
                      class="form-control"
                    />
                  </div>
                  <div class="mb-3">
                    <label for="formFileMultiple" class="form-label"
                      >Select one or more files for hall images</label
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
                    <label class="form-label">Capacity</label>
                    <input
                      type="text"
                      v-model="hall.capacity"
                      class="form-control"
                    />
                  </div>

                  <div class="row">
                    <div class="col">
                      <button
                        type="button"
                        @click="toggleModal({})"
                        class="btn btn-danger me-3 my-3"
                      >
                        Cancel
                      </button>
                      <button
                        type="button"
                        @click="handleClear"
                        class="btn btn-danger me-3 my-3"
                      >
                        Clear
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
    filteredHalls() {
      if (this.searchQuery) {
        return this.halls.filter((hall) => {
          return hall.name
            .toLowerCase()
            .includes(this.searchQuery.toLowerCase());
        });
      } else {
        return this.halls;
      }
    },
  },
  data() {
    return {
      searchQuery: "",
      halls: [],
      hall: {
        name: "",
        description: "",
        building: "",
        floor: "",
        capacity: "",
        images: null,
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
    uploadImage(event) {
      console.log(event.target.files);
      this.hall.images = event.target.files;
      console.log(this.hall.images);
    },
    getEventsInfoAdmin() {
      try {
        const token = localStorage.getItem("token");
        const config = {
          headers: {
            authorization: "Bearer " + token,
          },
        };
        const hall = axios
          .get(import.meta.env.VITE_SERVER_URL + "/halls/", config)
          .then((res) => {
            console.log(res.data);
            this.halls = res.data.halls;
          });
      } catch (err) {
        console.log(err);
      }
    },
    async handleSubmit() {
      try {
        const formData = new FormData();
        const token = localStorage.getItem("token");
        const config = {
          headers: {
            authorization: "Bearer " + token,
          },
        };
        if (
          this.hall.name == "" ||
          this.hall.building == "" ||
          this.hall.floor == "" ||
          this.hall.capacity == ""
        ) {
          alert("All inputs are required");
        } else {
          for (const i of Object.keys(this.hall.images)) {
            formData.append("images", this.hall.images[i]);
          }
          formData.append("name", this.hall.name);
          formData.append("description", this.hall.description);
          formData.append("building", this.hall.building);
          formData.append("floor", this.hall.floor);
          formData.append("capacity", this.hall.capacity);

          let response = await axios
            .post(
              import.meta.env.VITE_SERVER_URL + "/admin/add/halls",
              formData,
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
            import.meta.env.VITE_SERVER_URL + "/admin/delete/halls/" + id,
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
        const formData = new FormData();

        const token = localStorage.getItem("token");
        console.log(token);
        const config = {
          headers: {
            authorization: "Bearer " + token,
          },
        };
        if (
          this.hall.name == "" ||
          this.hall.building == "" ||
          this.hall.floor == "" ||
          this.hall.capacity == ""
        ) {
          alert("All inputs are required");
        } else {
          for (const i of Object.keys(this.hall.images)) {
            formData.append("images", this.hall.images[i]);
          }
          formData.append("name", this.hall.name);
          formData.append("description", this.hall.description);
          formData.append("building", this.hall.building);
          formData.append("floor", this.hall.floor);
          formData.append("capacity", this.hall.capacity);
          let response = await axios
            .post(
              import.meta.env.VITE_SERVER_URL +
                "/admin/manage/halls/" +
                this.hall._id,
              formData,
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
    toggleModal(hall) {
      this.hall = hall;
      this.showModal = !this.showModal;
    },
    handleClear() {
      this.hall = {};
    },
  },
};
</script>
