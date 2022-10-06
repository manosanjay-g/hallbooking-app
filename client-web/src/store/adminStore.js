import { defineStore } from 'pinia'
import axios from 'axios'
export const useAdminStore = defineStore('admin', {
    state: () => ({
        events: [],
        halls: [],
        users: [],
    }),
    actions: {
        async getUsersInfoAdmin() {
            try {
                const token = localStorage.getItem("token");
                const config = {
                    headers: {
                        authorization: "Bearer " + token,
                    },
                };
                const user = axios
                    .get(import.meta.env.VITE_SERVER_URL + "/admin/read/users", config)
                    .then((res) => {
                        console.log(res.data);
                        this.users = res.data.users;
                    });
            } catch (err) {
                console.log(err);
            }
        }
    }
})