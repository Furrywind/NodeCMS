<template>
  <v-snackbar v-model="snackbar" left>
    {{ this.$store.state.snackbarText }}
    <v-btn @click="onClick" color="white" icon>
      <v-icon>{{ mdiClose }}</v-icon>
    </v-btn>
  </v-snackbar>
</template>

<script>
import { mdiClose } from "@mdi/js";

export default {
  name: "Snackbar",

  data: () => ({
    mdiClose
  }),

  methods: {
    onClick() {
      this.$store.commit("snackbar");
    }
  },

  computed: {
    snackbar: {
      get() {
        return this.$store.state.snackbar;
      },
      set() {
        this.$store.commit("snackbar");
      }
    }
  }
};
</script>
