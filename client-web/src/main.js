import 'bootstrap/dist/css/bootstrap.css'
import 'material-icons/iconfont/material-icons.css';
import { createPinia } from 'pinia';
import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import vuex from './store/vuexStore'
const pinia = createPinia()
const app = createApp(App)

app.use(router)
app.use(pinia).use(vuex)
app.mount('#app')

import 'bootstrap/dist/js/bootstrap.js'