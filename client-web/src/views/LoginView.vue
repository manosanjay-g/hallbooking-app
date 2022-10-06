<template>
  <div class="container vh-100">
    <div class="row justify-content-center my-5 align-items-center">
      <img
        src="https://www.rajalakshmi.org/image/logo2.png"
        id="logo"
        alt=""
        srcset=""
      />
    </div>
    <div class="row justify-content-center align-items-center" id="rowSignIn">
      <div class="col-12 justify-content-center" style="max-width: 34em">
        <div class="card text-left">
          <div
            class="progress"
            v-if="authStore.isLoading == true"
            style="height: 5px"
          >
            <div
              class="progress-bar progress-bar-striped progress-bar-animated"
              role="progressbar"
              style="width: 100%"
              aria-valuenow="100"
              aria-valuemin="0"
              aria-valuemax="100"
            ></div>
          </div>
          <div
            class="alert alert-danger mx-5 mt-3 text-center"
            v-if="authStore.error != null"
            role="alert"
          >
            {{ authStore.getErrorMessage }}
          </div>
          <form class="py-4 px-5" @submit.prevent="handleSubmit" method="post">
            <h3>Sign In</h3>
            <div class="form-group my-2">
              <label for="exampleInputEmail1">Email address</label
              ><input
                v-model="loginInfo.email"
                type="email"
                class="form-control"
                id="exampleInputEmail1"
                aria-describedby="emailHelp"
              />
            </div>
            <div class="form-group my-2">
              <label for="exampleInputPassword1">Password</label
              ><input
                v-model="loginInfo.password"
                type="password"
                class="form-control"
                id="exampleInputPassword1"
              />
            </div>
            <button
              type="submit"
              id="handleSubmitButton"
              class="btn btn-dark my-2"
            >
              Submit</button
            ><br />

            <!---->
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { reactive } from "vue";
import { useAuthStore } from "../store/authStore";

const authStore = useAuthStore();

const loginInfo = reactive({
  email: "",
  password: "",
});
const handleSubmit = () => {
  if (loginInfo.email == "" || loginInfo.password == "") {
    alert("All inputs are required");
  } else {
    authStore.login(loginInfo);
  }
};
</script>
<style>
#handleSubmitButton {
  background-color: #2e0249;
}
.--bs-progress-bar-bg {
  background-color: #2e0249 !important;
}
#logo {
  height: 8.75rem;
  width: 25rem;
}
</style>
