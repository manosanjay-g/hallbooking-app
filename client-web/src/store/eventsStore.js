import { defineStore } from 'pinia'
import axios from 'axios'

export const useEventsStore = defineStore('events', {
    state: () => ({
        events: [],
        error: null
    }),
    getters: {
        getEventsLength(state) {
            return state.events.length
        },
        getEventsByUser(state) {
            const user_id = localStorage.getItem("username")
            return state.events.filter(event => event.user_id === user_id)
        },
        getEventsByUserLength(state) {
            const user_id = localStorage.getItem("username")

            return state.events.filter(event => event.user_id === user_id).length
        },

    },
    actions: {
        async getEvents() {
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
                        this.events = res.data.events
                    });
            } catch (err) {
                this.error = err;
                console.log(this.error);
            }
        }
    }
})