import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import LoginView from '../views/LoginView.vue'
import IndividualHall from '../views/IndividualHallView.vue'
import IndividualEvent from '../views/IndividualEventView.vue'
import BookedEvents from '../views/BookedEvents.vue'
import DashboardView from '../views/Admin/DashboardView.vue'
import EventView from '../views/Admin/EventView.vue'
import HallView from '../views/Admin/HallView.vue'
import UserView from '../views/Admin/UserView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/login',
      name: 'login',
      component: LoginView
    },
    {
      path: '/halls/:id',
      name: 'individual hall',
      component: IndividualHall
    },
    {
      path: '/events/:id',
      name: 'individual event',
      component: IndividualEvent
    },
    {
      path: '/profile/events',
      name: 'booked events',
      component: BookedEvents
    },
    {
      path: '/admin/dashboard',
      name: "admin dashboard",
      component: DashboardView
    },
    {
      path: '/admin/events',
      name: "admin events",
      component: EventView
    },
    {
      path: '/admin/halls',
      name: "admin halls",
      component: HallView
    },
    {
      path: '/admin/users',
      name: "admin users",
      component: UserView
    }

  ]
})

router.beforeEach(async (to, from) => {
  const token = localStorage.getItem('token')
  if (
    // make sure the user is authenticated
    token == null &&
    to.name !== 'login'
  ) {
    // redirect the user to the login page
    return { name: 'login' }
  }
})
export default router
