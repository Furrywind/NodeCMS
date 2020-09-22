<template>
  <v-container class="pa-0">
    <v-sheet max-width="1650" class="mx-auto">
      <v-row no-gutters class="ma-4">
        <v-col cols="auto">
          <span class="headline">{{ "Labels" }}</span>
        </v-col>
      </v-row>
      <v-divider />
      <v-row no-gutters class="mt-2 pa-2">
        <v-col
          class="pa-2"
          cols="12"
          :sm="8"
          :order="$vuetify.breakpoint.smAndDown ? 1 : 0"
        >
          <v-card class="mx-auto" outlined>
            <v-card-title>
              <span class="title">Label management</span>
            </v-card-title>
            <v-card-text>
              <span class="body-2">Select Label to modify</span>
              <v-chip-group
                v-model="editedIndex"
                active-class="primary--text"
                column
              >
                <v-chip v-for="label in labels" :key="label.mid" outlined>
                  {{ label.name }}
                </v-chip>
              </v-chip-group>
            </v-card-text>
          </v-card>
        </v-col>
        <v-col
          class="pa-2"
          cols="12"
          :sm="4"
          :order="$vuetify.breakpoint.smAndDown ? 0 : 1"
        >
          <v-card :disabled="disabled" class="mx-auto" outlined>
            <v-card-title>
              <span class="title">{{ cardTitle }}</span>
            </v-card-title>
            <v-card-text>
              <v-text-field
                v-model="editedItem.name"
                label="Name"
                maxlength="16"
                outlined
                dense
              />
              <v-text-field
                v-model="editedItem.slug"
                label="Slug"
                maxlength="16"
                outlined
                dense
              />
              <v-row no-gutters>
                <v-btn
                  v-if="editedIndex !== undefined"
                  @click="del"
                  color="primary"
                  class="mx-0"
                  text
                >
                  {{ "Delete" }}
                </v-btn>
                <v-spacer />
                <v-col cols="auto">
                  <v-btn @click="save" color="primary" class="mx-0" depressed>
                    {{ "Save" }}
                  </v-btn>
                </v-col>
              </v-row>
            </v-card-text>
          </v-card>
        </v-col>
      </v-row>
    </v-sheet>
  </v-container>
</template>

<script>
// import Tooltip from "@/components/Tooltip.vue";
import { getLabels, addLabel, editLabel, deleteLabel } from "@/api/labels.js";
// import { mdiTrashCanOutline } from "@mdi/js";

export default {
  name: "Labels",

  components: {},

  data: () => ({
    labels: [],

    disabled: false,

    editedIndex: undefined,
    editedItem: {
      mid: NaN,
      name: "",
      slug: ""
    },
    defaultItem: {},

    icons: {}
  }),

  computed: {
    cardTitle() {
      return this.editedIndex !== undefined ? "Edit label" : "Create new Label";
    }
  },

  watch: {
    editedIndex(val) {
      if (val !== undefined) {
        this.editedItem = Object.assign({}, this.labels[val]);
      } else {
        this.reset();
      }
    }
  },

  created() {
    getLabels().then(res => {
      this.labels = res.data;
    });
    this.defaultItem = Object.assign({}, this.editedItem);
  },

  methods: {
    del() {
      this.disabled = true;
      deleteLabel(this.editedItem).then(res => {
        if (res.status === 200) {
          this.labels.splice(this.editedIndex, 1);
          this.$store.commit(
            "showSnackbar",
            this.editedItem.name + " has been deleted."
          );
          this.reset();
        } else {
          this.$store.commit(
            "showSnackbar",
            "Sorry, something went wrong there. Try again."
          );
        }
        this.disabled = false;
      });
    },

    save() {
      this.disabled = true;
      if (this.editedIndex !== undefined) {
        editLabel(this.editedItem).then(res => {
          if (res.status === 200) {
            this.labels[this.editedIndex].name = this.editedItem.name;
            this.labels[this.editedIndex].slug = this.editedItem.slug;
            this.$store.commit("showSnackbar", "Label updated.");
          } else if (res.request.status === 409) {
            this.$store.commit("showSnackbar", "Slug already exist.");
          } else {
            this.$store.commit(
              "showSnackbar",
              "Sorry, something went wrong there. Try again."
            );
          }
          this.disabled = false;
        });
      } else {
        addLabel(this.editedItem).then(res => {
          if (res.status === 200) {
            this.labels.push(this.editedItem);
            this.labels[this.labels.length - 1].mid = res.data.mid;
            this.$store.commit("showSnackbar", "Label created.");
            this.reset();
          } else if (res.request.status === 409) {
            this.$store.commit("showSnackbar", "Slug already exist.");
          } else {
            this.$store.commit(
              "showSnackbar",
              "Sorry, something went wrong there. Try again."
            );
          }
          this.disabled = false;
        });
      }
    },

    reset() {
      this.editedItem = Object.assign({}, this.defaultItem);
    }
  }
};
</script>
