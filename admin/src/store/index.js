import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    nickname: "",
    role: NaN,

    snackbar: false,
    snackbarText: "Working..."
  },

  getters: {},

  mutations: {
    setNickname(state, payload) {
      state.nickname = payload;
    },
    setRole(state, payload) {
      state.role = payload;
    },
    snackbar(state) {
      state.snackbar = !state.snackbar;
    },
    showSnackbar(state, payload) {
      state.snackbarText = payload;
      state.snackbar = true;
    }
  },

  actions: {},

  modules: {}
});
