<template>
  <v-container class="pa-0">
    <v-sheet max-width="1650" class="mx-auto">
      <v-row no-gutters class="ma-4">
        <v-col cols="auto">
          <span class="headline">{{ editorTitle }}</span>
        </v-col>
        <v-spacer />
        <v-col cols="auto">
          <v-btn @click="save" color="primary" class="mx-0" depressed>
            {{ "Save" }}
          </v-btn>
        </v-col>
      </v-row>
      <v-divider />
      <v-row class="mt-2 pa-2 pb-0" no-gutters>
        <v-col class="pa-2 pb-0" cols="12" :sm="8">
          <v-text-field
            v-model="editedData.title"
            label="Title"
            maxlength="150"
            outlined
          />
        </v-col>
        <v-col class="pa-2 pb-0" cols="12" :sm="4">
          <v-text-field
            v-model="editedData.slug"
            label="Slug"
            maxlength="16"
            outlined
          />
        </v-col>
      </v-row>
      <v-row class="ma-0 pa-2 pt-0" no-gutters>
        <v-col class="pa-2 pt-0" cols="12" :sm="8">
          <TinyMCE
            v-model="editedData.content"
            :init="{
              height: 550,
              menubar: false,
              plugins: ['lists link image paste wordcount'],
              toolbar:
                'undo redo | formatselect | bold italic backcolor | link image| \
            alignleft aligncenter alignright alignjustify | \
            bullist numlist | outdent indent removeformat'
            }"
          />
        </v-col>
        <v-col class="pa-2 pt-0" cols="12" :sm="4">
          <v-card class="mx-auto" outlined>
            <v-card-title>
              <span class="title">Options</span>
            </v-card-title>
            <v-card-text>
              <span class="subtitle-1">Status</span>
              <v-radio-group v-model="editedData.status" row>
                <v-radio :value="1" label="Public" />
                <v-radio :value="0" label="Draft" />
              </v-radio-group>
              <p class="subtitle-1">Category</p>
              <v-select
                v-model="editedData.categoryId"
                :items="categorys"
                item-value="mid"
                item-text="name"
                outlined
                dense
              />
              <p class="subtitle-1">Labels</p>
              <v-select
                v-model="editedLabel"
                :items="labels"
                item-value="mid"
                item-text="name"
                placeholder="Not selected"
                chips
                multiple
                outlined
                dense
              />
            </v-card-text>
          </v-card>
          <v-card class="mx-auto mt-4" outlined>
            <v-card-title>
              <span class="title">Infomation</span>
            </v-card-title>
            <v-card-text>
              <span class="subtitle-1">{{ "Author: " + displayAuthor }}</span>
              <br />
              <span class="subtitle-1" v-if="editedData.created !== undefined">
                {{
                  "Created: " +
                    new Date(editedData.created * 1000).toLocaleString()
                }}
              </span>
              <br />
              <span class="subtitle-1" v-if="editedData.modified !== undefined">
                {{
                  "Modified: " +
                    new Date(editedData.modified * 1000).toLocaleString()
                }}
              </span>
            </v-card-text>
          </v-card>
        </v-col>
      </v-row>
    </v-sheet>
  </v-container>
</template>

<script>
import TinyMCE from "@tinymce/tinymce-vue";
import { getArticle, addArticle, editArticle } from "@/api/articles.js";

export default {
  name: "Editor",

  components: { TinyMCE },

  data: () => ({
    editedData: {
      cid: 0,
      title: "",
      slug: "",
      content: "",
      categoryId: 0,
      status: 0
    },
    editedLabel: [],
    author: "",

    categorys: [],
    labels: []
  }),

  computed: {
    editorTitle() {
      return this.$route.query.cid === undefined
        ? "New article"
        : "Edit Article";
    },
    displayAuthor() {
      return this.$route.query.cid === undefined
        ? this.author
        : this.editedData.author;
    }
  },

  created() {
    getArticle(this.$route.query.cid).then(res => {
      if (this.$route.query.cid !== undefined) {
        this.editedData = res.data[0];
        this.editedLabel = res.data[1];
      } else {
        this.author = this.$store.state.nickname;
      }
      this.categorys = res.data[2];
      this.labels = res.data[3];
    });
  },

  methods: {
    save() {
      if (this.$route.query.cid !== undefined) {
        editArticle([this.editedData, this.editedLabel]).then(res => {
          if (res.status === 200) {
            this.$store.commit("showSnackbar", "Article updated.");
          } else {
            this.$store.commit(
              "showSnackbar",
              "Sorry, something went wrong there. Try again."
            );
          }
        });
      } else {
        addArticle([this.editedData, this.editedLabel]).then(res => {
          if (res.status === 200) {
            this.$router.push({
              name: "editor",
              query: { cid: res.data.cid }
            });
            this.editedData = res.data;
            this.$store.commit("showSnackbar", "Article Add.");
          } else {
            this.$store.commit(
              "showSnackbar",
              "Sorry, something went wrong there. Try again."
            );
          }
        });
      }
    }
  }
};
</script>

<style>
/* Remove the TinyMCE message */
.tox-notification {
  display: none !important;
}
</style>
