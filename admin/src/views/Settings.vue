/* NOT FINISHED YET */

<template>
  <v-container>
    <v-sheet max-width="600" class="mx-auto">
      <v-row justify="center" class="mt-4">
        <span class="headline" id="title">Settings</span>
      </v-row>
      <v-row justify="center" class="mx-4 mt-4">
        <span>
          Manage your site
        </span>
      </v-row>
      <v-row class="mt-4">
        <v-col cols="12">
          <v-card :disabled="disabled" class="mx-auto" outlined>
            <v-card-title>Basic settings</v-card-title>
            <v-card-text>
              <p class="subtitle-1">Site name</p>
              <v-text-field
                v-model="editedData.siteName"
                maxlength="32"
                outlined
                dense
              />
              <p class="subtitle-1">Site address</p>
              <v-text-field v-model="editedData.address" outlined dense />
              <p class="subtitle-1">Site description</p>
              <v-text-field
                v-model="editedData.description"
                maxlength="150"
                outlined
                dense
              />
            </v-card-text>
            <v-card-actions>
              <v-spacer />
              <v-btn @click="save" color="primary" text>Save</v-btn>
            </v-card-actions>
          </v-card>
        </v-col>
      </v-row>
    </v-sheet>
  </v-container>
</template>

<script>
import { getSettings, editSettings } from "@/api/settings.js";

export default {
  name: "Settings",

  data: () => ({
    editedData: {
      siteName: "",
      address: "",
      description: "",
    },

    disabled: false,
  }),

  created() {
    getSettings().then((res) => {
      this.editedData = res.data;
    });
  },

  methods: {
    save() {
      this.disabled = true;
      editSettings(this.editedData).then((res) => {
        if (res.status === 200) {
          this.$store.commit("showSnackbar", "Save succeed.");
        } else {
          this.$store.commit(
            "showSnackbar",
            "Sorry, something went wrong there. Try again."
          );
        }
        this.disabled = false;
      });
    },
  },
};
</script>

<style scoped>
#title {
  font-size: 1.75rem !important;
}
</style>
