<template>
  <v-app>
    <router-view />
  </v-app>
</template>

<script>
export default {
  name: "App",

  created() {
    if (localStorage.getItem("userInfo")) {
      this.$store.commit(
        "setRole",
        JSON.parse(localStorage.getItem("userInfo")).role
      );
      this.$store.commit(
        "setNickname",
        JSON.parse(localStorage.getItem("userInfo")).nickname
      );
    }
  }
};
</script>

<style style="scss">
* {
  text-transform: none !important;
}
html {
  overflow-y: auto; /* hide scrollbar which default is on */
}
</style>
