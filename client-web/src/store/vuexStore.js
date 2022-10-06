import axios from 'axios';
import { createStore } from 'vuex'
export default createStore({
    state: {
        isLoggedIn: false,
        isAdmin: false,
        user: [],
        halls: [],
        events: [],
        searchQuery: "",
    },
    getters: {
        loginState(state) {
            return state.isLoggedIn
        },
        getUserDataLength(state) {
            return state.user.length
        },
        getEventsByUser(state) {
            const user_id = localStorage.getItem("username")
            return state.events.filter(event => event.user_id === user_id)
        },
        getEventsLength(state) {
            return state.events.length
        },
        getEventsByUserLength(state) {
            const user_id = localStorage.getItem("username")

            return state.events.filter(event => event.user_id === user_id).length
        },
        getHallsLength(state) {
            return state.halls.length
        },
        getAdminState(state) {
            return state.isAdmin
        },
        getHallName: (state) => (id) => {
            const hallName = state.halls.find(hall => hall._id === id);
            return hallName.name
        }
    },
    mutations: {
        LOGIN: (state) => {
            state.isLoggedIn = true

        },
        LOGOUT: (state) => {
            state.isLoggedIn = false
            state.isAdmin = false
            state.user = []
            localStorage.removeItem("token");
        },
        SET_TOKEN: (payload) => {
            localStorage.setItem('token', payload.data)
        },
        DELETE_TOKEN: () => {
            localStorage.removeItem('token')
        },
        SET_HALLS: (state, payload) => {
            state.halls = payload
        },
        SET_EVENTS: (state, payload) => {
            state.events = payload
        },
        SET_USER_INFO: (state, payload) => {
            console.log(payload);
            state.user = payload
        },
        SET_ADMIN_TRUE: (state) => {
            state.isAdmin = true
        },
        SET_SEARCH_QUERY: (state, payload) => {
            state.searchQuery = payload
        }
    },
    actions: {
        getUserInfo: async (context, payload) => {
            try {
                const token = localStorage.getItem("token")
                const username = localStorage.getItem("username")
                const config = {
                    headers: {
                        authorization: "Bearer " + token,
                    },

                }
                const user = axios.get(import.meta.env.VITE_SERVER_URL + "/users/" + username, config).then((res) => {
                    if (res.data.user.role == "Admin") {
                        context.commit("SET_ADMIN_TRUE")
                    }
                    context.commit('SET_USER_INFO', res.data.user)
                })
            } catch (err) {
                console.log(err);
            }
        },
        handleLogin: async (context, payload) => {
            context.commit('LOGIN')
        },
        handleLogout: async (context) => {
            context.commit('LOGOUT')
        },
        setHalls: async (context) => {
            try {
                const token = localStorage.getItem("token");
                const hallsResponse = axios
                    .get(import.meta.env.VITE_SERVER_URL + "/halls", {
                        headers: {
                            authorization: "Bearer " + token,
                        },
                    })
                    .then((res) => {
                        console.log(res);
                        context.commit('SET_HALLS', res.data.halls)
                    });
            } catch (err) {
                console.log(err);
            }
        },
        setEvents: async (context) => {
            try {
                const token = localStorage.getItem("token");
                console.log(token);
                const hallsResponse = axios
                    .get(import.meta.env.VITE_SERVER_URL + "/events", {
                        headers: {
                            authorization: "Bearer " + token,
                        },
                    })
                    .then((res) => {
                        console.log(res);
                        context.commit('SET_EVENTS', res.data.events)
                    });
            } catch (err) {
                console.log(err);
            }
        },
        handleBooking: async (context, payload) => {
            try {
                console.log(payload);
                const token = localStorage.getItem('token')
                console.log(token);
                const bookingResponse = await axios.post(import.meta.env.VITE_SERVER_URL + "/book/events").then((res) => {
                    console.log(res);
                })

            } catch (err) {
                console.log(err);
            }
        },
    },
    modules: {
    }
})