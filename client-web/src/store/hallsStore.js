import { defineStore } from 'pinia'
import axios from 'axios'
export const useHallsStore = defineStore('halls', {
    state: () => ({
        halls: [],
        error: null
    }),
    getters: {
        getHallsLength(state) {
            return state.halls.length
        },
        getHallName: (state) => {
            return (hallId) => state.halls.find((hall) => hall._id === hallId).name
        },
        getHallCapacity: (state) => {
            return (hallId) => state.halls.find((hall) => {
                if (hall._id === hallId) {
                    console.log(hall);
                };
                return hall._id === hallId
            })
        },
    },
    actions: {
        async getHalls() {
            try {
                const token = localStorage.getItem("token");
                const hallsResponse = axios
                    .get(import.meta.env.VITE_SERVER_URL + "/halls", {
                        headers: {
                            authorization: "Bearer " + token,
                        },
                    })
                    .then((res) => {
                        this.halls = res.data.halls
                    });
            } catch (err) {
                this.error = err;
                console.log(this.error);
            }
        }
    }
})