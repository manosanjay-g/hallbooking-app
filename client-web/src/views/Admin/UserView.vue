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
                  Create a User
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
                    <label class="form-label">Username</label>
                    <input
                      type="text"
                      v-model="user.username"
                      class="form-control"
                      placeholder="johndoe"
                    />
                  </div>
                  <div class="mb-3">
                    <label class="form-label">Name</label>
                    <input
                      type="text"
                      v-model="user.name"
                      class="form-control"
                      placeholder="John Doe"
                    />
                  </div>
                  <div class="mb-3">
                    <label class="form-label">Email address</label>
                    <input
                      type="email"
                      v-model="user.email"
                      class="form-control"
                      placeholder="name@example.com"
                    />
                  </div>
                  <div class="mb-3">
                    <label class="form-label">Password</label>
                    <input
                      type="text"
                      v-model="user.password"
                      class="form-control"
                    />
                  </div>
                  <div class="input-group mb-3">
                    <label class="input-group-text" for="inputGroupSelect01"
                      >Department</label
                    >
                    <select
                      v-model="user.dept"
                      class="form-select"
                      id="inputGroupSelect01"
                    >
                      <option disabled value="">Choose...</option>
                      <option>Aeronautical Engineering</option>
                      <option>
                        Artificial Intelligence and Machine Learning
                      </option>
                      <option>Automobile Engineering</option>
                      <option>Biomedical Engineering</option>
                      <option>Biotechnology</option>
                      <option>Chemical Engineering</option>
                      <option>Civil Engineering</option>
                      <option>Computer Science and Design</option>
                      <option>Computer Science and Engineering</option>
                      <option>Computer Science and Business Systems</option>
                      <option>Electrical and Electronics Engineering</option>
                      <option>Electronics and Communication Engineering</option>
                      <option>Food Technology</option>
                      <option>Information Technology</option>
                      <option>Mechanical Engineering</option>
                      <option>Mechatronics</option>
                      <option>Robotics and Automation</option>
                    </select>
                  </div>
                  <div class="input-group mb-3">
                    <label class="input-group-text" for="inputGroupSelect01"
                      >Job</label
                    >
                    <select
                      v-model="user.job"
                      class="form-select"
                      id="inputGroupSelect01"
                    >
                      <option disabled value="">Choose...</option>
                      <option>Dean</option>
                      <option>HOD</option>
                      <option>Academic Head</option>
                      <option>Professor</option>
                      <option>Assistant Professor</option>
                      <option>Assistant Professor(SG)</option>
                      <option>Assistant Professor(SS)</option>
                      <option>Miscellaneous</option>
                    </select>
                  </div>
                  <div class="input-group mb-3">
                    <label class="input-group-text" for="inputGroupSelect01"
                      >Role</label
                    >
                    <select
                      v-model="user.role"
                      class="form-select"
                      id="inputGroupSelect01"
                    >
                      <option disabled value="">Choose...</option>
                      <option>Admin</option>
                      <option>User</option>
                    </select>
                  </div>
                </div>
                <div class="modal-footer">
                  <button
                    type="button"
                    class="btn btn-secondary"
                    data-bs-dismiss="modal"
                  >
                    Clear
                  </button>
                  <button class="btn btn-primary">Submit</button>
                </div>
              </form>
            </div>
          </div>
        </div>

        <div class="scrollable" v-if="!showModal && filteredUsers.length != 0">
          <table class="table table-bordered border-primary mt-4">
            <thead>
              <tr>
                <th scope="col">S.NO</th>
                <th scope="col">Username</th>
                <th scope="col">Name</th>
                <th scope="col">Email</th>
                <th scope="col">Hashed-Password</th>
                <th scope="col">dept</th>
                <th scope="col">job</th>
                <th scope="col">role</th>
                <th scope="col">Action</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(user, index) in filteredUsers" :key="user._id">
                <th scope="row">{{ index + 1 }}</th>
                <td>@{{ user.username }}</td>
                <td>{{ user.name }}</td>
                <td>{{ user.email }}</td>
                <td>{{ user.password }}</td>
                <td>{{ user.dept }}</td>
                <td>{{ user.job }}</td>
                <td>{{ user.role }}</td>
                <td>
                  <span class="actionbtns" @click="toggleModal(user)"
                    >Edit</span
                  >
                  <span v-if="authStore.userData.username != user.username"
                    >|</span
                  >
                  <span
                    v-if="authStore.userData.username != user.username"
                    class="actionbtns"
                    @click="handleRemove(user._id)"
                    >Remove</span
                  >
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        <p
          v-else-if="!showModal && filteredUsers.length == 0"
          class="text-muted py-4 text-center"
        >
          User not found
        </p>
        <div v-if="showModal" class="row my-3 justify-content-center">
          <div class="col">
            <div class="card" id="hall">
              <div class="card-body border border-dark rounded">
                <h3>Edit User</h3>

                <form @submit.prevent="handleEdit">
                  <div class="mb-3">
                    <label class="form-label">Username</label>
                    <input
                      type="text"
                      v-model="user.username"
                      class="form-control"
                      placeholder="johndoe"
                    />
                  </div>
                  <div class="mb-3">
                    <label class="form-label">Name</label>
                    <input
                      type="text"
                      v-model="user.name"
                      class="form-control"
                      placeholder="John Doe"
                    />
                  </div>
                  <div class="mb-3">
                    <label class="form-label">Email address</label>
                    <input
                      type="email"
                      v-model="user.email"
                      class="form-control"
                      placeholder="name@example.com"
                    />
                  </div>
                  <div class="mb-3">
                    <label class="form-label">Password</label>
                    <input
                      type="text"
                      v-model="user.password"
                      class="form-control"
                    />
                  </div>
                  <div class="input-group mb-3">
                    <label class="input-group-text" for="inputGroupSelect01"
                      >Department</label
                    >
                    <select
                      v-model="user.dept"
                      class="form-select"
                      id="inputGroupSelect01"
                    >
                      <option disabled value="">Choose...</option>
                      <option>Aeronautical Engineering</option>
                      <option>
                        Artificial Intelligence and Machine Learning
                      </option>
                      <option>Automobile Engineering</option>
                      <option>Biomedical Engineering</option>
                      <option>Biotechnology</option>
                      <option>Chemical Engineering</option>
                      <option>Civil Engineering</option>
                      <option>Computer Science and Design</option>
                      <option>Computer Science and Engineering</option>
                      <option>Computer Science and Business Systems</option>
                      <option>Electrical and Electronics Engineering</option>
                      <option>Electronics and Communication Engineering</option>
                      <option>Food Technology</option>
                      <option>Information Technology</option>
                      <option>Mechanical Engineering</option>
                      <option>Mechatronics</option>
                      <option>Robotics and Automation</option>
                    </select>
                  </div>
                  <div class="input-group mb-3">
                    <label class="input-group-text" for="inputGroupSelect01"
                      >Job</label
                    >
                    <select
                      v-model="user.job"
                      class="form-select"
                      id="inputGroupSelect01"
                    >
                      <option disabled value="">Choose...</option>
                      <option>Dean</option>
                      <option>HOD</option>
                      <option>Academic Head</option>
                      <option>Professor</option>
                      <option>Assistant Professor</option>
                      <option>Assistant Professor(SG)</option>
                      <option>Assistant Professor(SS)</option>
                      <option>Miscellaneous</option>
                    </select>
                  </div>
                  <div class="input-group mb-3">
                    <label class="input-group-text" for="inputGroupSelect01"
                      >Role</label
                    >
                    <select
                      v-model="user.role"
                      class="form-select"
                      id="inputGroupSelect01"
                    >
                      <option disabled value="">Choose...</option>
                      <option>Admin</option>
                      <option>User</option>
                    </select>
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

<script setup>
import axios from "axios";
import { ref, onMounted, computed } from "vue";
import { useAdminStore } from "../../store/adminStore";
import { useEventsStore } from "../../store/eventsStore";
import { useHallsStore } from "../../store/hallsStore";
import { useAuthStore } from "../../store/authStore";
import { useRouter } from "vue-router";

const adminStore = useAdminStore();
const hallsStore = useHallsStore();
const eventsStore = useEventsStore();
const authStore = useAuthStore();
const router = useRouter();
//Search Logic
let searchQuery = ref("");

let filteredUsers = computed(() => {
  if (searchQuery) {
    return adminStore.users.filter((user) => {
      return user.name.toLowerCase().includes(searchQuery.value.toLowerCase());
    });
  } else {
    return adminStore.users;
  }
});

//Fetch User Logic

//User manipulation logic
let user = ref({
  username: "",
  name: "",
  email: "",
  password: "",
  dept: "",
  job: "",
  role: "",
});

const handleSubmit = async () => {
  try {
    if (
      user.value.email == "" ||
      user.value.password == "" ||
      user.value.username == "" ||
      user.value.name == "" ||
      user.value.dept == "" ||
      user.value.role == "" ||
      user.value.job == ""
    ) {
      alert("All inputs are required");
    } else {
      let response = await axios
        .post(import.meta.env.VITE_SERVER_URL + "/auth/register", user.value)
        .then((res) => {
          console.log(res.data);
          router.go(0);
        });
    }
  } catch (err) {
    console.log(err);
  }
};

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
        import.meta.env.VITE_SERVER_URL + "/admin/delete/users/" + id,
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

const handleEdit = async () => {
  try {
    const token = localStorage.getItem("token");
    console.log(token);
    const config = {
      headers: {
        authorization: "Bearer " + token,
      },
    };
    if (
      user.email == "" ||
      user.password == "" ||
      user.username == "" ||
      user.name == "" ||
      user.dept == "" ||
      user.role == "" ||
      user.job == ""
    ) {
      alert("All inputs are required");
    } else {
      let response = await axios
        .post(
          import.meta.env.VITE_SERVER_URL + "/admin/manage/users/" + user._id,
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
};

const handleClear = () => {
  user = {};
};

//Modal logic
let showModal = ref(false);

const toggleModal = (userInfo) => {
  user.value = userInfo;
  showModal.value = !showModal.value;
};

onMounted(() => {
  adminStore.getUsersInfoAdmin();
  hallsStore.getHalls();
  eventsStore.getEvents();
  authStore.getUserInfo();
});
</script>
