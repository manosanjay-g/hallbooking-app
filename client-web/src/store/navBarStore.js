import { defineStore } from 'pinia'

export const useNavBarStore = defineStore('navBar', {
    state: () => ({
        query: ""
    }),
    actions: {
        setSearchQuery(query) {
            this.query = query
        }
    }
})