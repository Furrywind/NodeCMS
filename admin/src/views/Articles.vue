<template>
  <v-container class="pa-0">
    <v-sheet max-width="1650" class="mx-auto">
      <v-row no-gutters>
        <v-col>
          <DataTable
            :headers="headers"
            :items="articles"
            :items-per-page="10"
            :loading="isLoading"
            :mobile-breakpoint="768"
            :items-per-page-options="[10, 30, 50]"
            :table-name="tableName"
          >
            <template #tableNameMenu>
              <v-list-item @click="newArticle()">
                <v-list-item-icon class="ml-1 mr-4">
                  <v-icon color="grey darken-1">$plus</v-icon>
                </v-list-item-icon>
                <v-list-item-content class="body-2">
                  {{ newArticleText }}
                </v-list-item-content>
              </v-list-item>
            </template>

            <template #item.status="{ item }">
              <span>{{ displayStatus(item.status) }}</span>
            </template>

            <template #item.date="{ item }">
              <span>{{ displayDate(item.date) }}</span>
            </template>

            <template #item.actions="{ item }">
              <Tooltip :tool-tip-text="tooltipEdit">
                <template #activator="{ on }">
                  <v-icon @click="editArticle(item)" v-on="on">
                    {{ icons.mdiPencilOutline }}
                  </v-icon>
                </template>
              </Tooltip>
              <Tooltip :tool-tip-text="tooltipDelete">
                <template #activator="{ on }">
                  <v-icon @click="deleteItem(item)" v-on="on" class="ml-2">
                    {{ icons.mdiTrashCanOutline }}
                  </v-icon>
                </template>
              </Tooltip>
            </template>
          </DataTable>

          <v-dialog v-model="dialog" :persistent="disabled" max-width="380">
            <v-card :disabled="disabled">
              <v-card-title class="title">
                {{ formTitle }}
              </v-card-title>
              <v-card-text />
              <v-card-actions>
                <v-spacer />
                <v-btn @click="close" color="primary" text>
                  {{ closeBtn }}
                </v-btn>
                <v-btn @click="del" color="primary" text>
                  {{ deleteBtn }}
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>
        </v-col>
      </v-row>
    </v-sheet>
  </v-container>
</template>

<script>
import DataTable from "@/components/DataTable.vue";
import Tooltip from "@/components/Tooltip.vue";
import { getArticles, deleteArticle } from "@/api/articles.js";
import { mdiPencilOutline, mdiTrashCanOutline } from "@mdi/js";

export default {
  name: "Articles",

  components: { DataTable, Tooltip },

  data: () => ({
    articles: [],
    headers: [
      { text: "Title", value: "title" },
      { text: "Author", value: "author" },
      { text: "Category", value: "category" },
      { text: "Status", value: "status" },
      { text: "Date", value: "date" },
      { text: "", value: "actions", sortable: false, width: 88 }
    ],
    isLoading: true,
    tableName: "Articles",
    newArticleText: "New article",
    tooltipEdit: "Edit",
    tooltipDelete: "Delete",

    dialog: false,
    disabled: false,
    closeBtn: "Cancel",
    deleteBtn: "Delete",

    editedIndex: -1,
    editedItem: {},

    icons: {
      mdiPencilOutline,
      mdiTrashCanOutline
    }
  }),

  computed: {
    formTitle() {
      return "Delete " + this.editedItem.title + " ?";
    }
  },

  created() {
    getArticles().then(res => {
      this.articles = res.data;
      this.isLoading = false;
    });
  },

  methods: {
    displayStatus(val) {
      if (val === 0) return "Draft";
      if (val === 1) return "Public";
    },

    displayDate(val) {
      return new Date(val * 1000).toLocaleDateString();
    },

    newArticle() {
      this.$router.push({ name: "editor" });
    },

    editArticle(item) {
      this.$router.push({ name: "editor", query: { cid: item.cid } });
    },

    deleteItem(item) {
      this.editedIndex = this.articles.indexOf(item);
      this.editedItem = Object.assign({}, item);
      this.dialog = true;
    },

    del() {
      this.disabled = true;
      deleteArticle(this.editedItem).then(res => {
        if (res.status === 200) {
          this.articles.splice(this.editedIndex, 1);
          this.$store.commit(
            "showSnackbar",
            this.editedItem.title + " has been deleted."
          );
          this.dialog = false;
        } else {
          this.$store.commit(
            "showSnackbar",
            "Sorry, something went wrong there. Try again."
          );
        }
        this.disabled = false;
      });
    },

    close() {
      this.dialog = false;
    }
  }
};
</script>
