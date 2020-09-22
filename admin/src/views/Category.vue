<template>
  <v-container class="pa-0">
    <v-sheet max-width="1650" class="mx-auto">
      <v-row no-gutters>
        <v-col>
          <DataTable
            :headers="headers"
            :items="categorys"
            :items-per-page="10"
            :loading="isLoading"
            :mobile-breakpoint="0"
            :items-per-page-options="[10, 30, 50]"
            :table-name="tableName"
          >
            <template #tableNameMenu>
              <v-list-item @click="dialog = true">
                <v-list-item-icon class="ml-1 mr-4">
                  <v-icon color="grey darken-1">$plus</v-icon>
                </v-list-item-icon>
                <v-list-item-content class="body-2">
                  {{ newCategoryText }}
                </v-list-item-content>
              </v-list-item>
            </template>

            <template #item.actions="{ item }">
              <Tooltip :tool-tip-text="tooltipEdit">
                <template #activator="{ on }">
                  <v-icon @click="editItem(item)" v-on="on">
                    {{ icons.mdiPencilOutline }}
                  </v-icon>
                </template>
              </Tooltip>
              <Tooltip :tool-tip-text="tooltipDelete">
                <template #activator="{ on }">
                  <v-icon
                    @click="deleteItem(item)"
                    :disabled="item.mid === 0"
                    v-on="on"
                    class="ml-2"
                  >
                    {{ icons.mdiTrashCanOutline }}
                  </v-icon>
                </template>
              </Tooltip>
            </template>
          </DataTable>

          <v-dialog
            v-model="dialog"
            :persistent="disabled"
            max-width="420"
            scrollable
          >
            <v-card :disabled="disabled">
              <v-card-title class="title">
                {{ formTitle }}
              </v-card-title>
              <v-sheet v-if="editedItem.count !== -1">
                <v-divider />
                <v-card-text>
                  <v-container>
                    <v-form v-model="vaild" id="form" ref="form">
                      <v-row>
                        <v-col cols="6" class="py-0">
                          <v-text-field
                            v-model="editedItem.name"
                            :rules="[rules.required]"
                            label="Name"
                            maxlength="16"
                            outlined
                            dense
                          />
                        </v-col>
                        <v-col cols="6" class="py-0">
                          <v-text-field
                            v-model="editedItem.slug"
                            :rules="[rules.required, rules.slug]"
                            label="Slug"
                            maxlength="16"
                            outlined
                            dense
                          />
                        </v-col>
                      </v-row>
                      <span>
                        {{
                          "Slug is used to create a friendly link, only lowercase letters, numbers, underscores and dashs are allowed."
                        }}
                      </span>
                      <v-row no-gutters class="mt-6">
                        <v-col cols="12">
                          <v-textarea
                            v-model="editedItem.description"
                            label="Description"
                            maxlength="140"
                            counter
                            auto-grow
                            outlined
                            dense
                          />
                        </v-col>
                      </v-row>
                    </v-form>
                  </v-container>
                </v-card-text>
                <v-divider />
              </v-sheet>
              <v-card-text v-if="editedItem.count === -1" />
              <v-card-actions>
                <v-spacer />
                <v-btn @click="close" color="primary" text>
                  {{ closeBtn }}
                </v-btn>
                <v-btn
                  v-if="this.editedItem.count !== -1"
                  @click="save"
                  color="primary"
                  text
                >
                  {{ saveBtn }}
                </v-btn>
                <v-btn
                  v-if="this.editedItem.count === -1"
                  @click="del"
                  color="primary"
                  text
                >
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
import {
  getCategorys,
  addCategory,
  editCategory,
  deleteCategory
} from "@/api/categorys.js";
import { mdiPencilOutline, mdiTrashCanOutline } from "@mdi/js";

export default {
  name: "Categorys",

  components: { DataTable, Tooltip },

  data: () => ({
    categorys: [],
    headers: [
      { text: "Name", value: "name" },
      { text: "Slug", value: "slug" },
      { text: "Articles", value: "count" },
      { text: "", value: "actions", sortable: false, width: 88 }
    ],
    isLoading: true,
    tableName: "Category",
    newCategoryText: "Add new category",
    tooltipEdit: "Edit",
    tooltipDelete: "Delete",

    dialog: false,
    disabled: false,
    closeBtn: "Cancel",
    saveBtn: "Save",
    deleteBtn: "Delete",

    editedIndex: -1,
    editedItem: {
      mid: NaN,
      name: "",
      slug: "",
      description: "",
      count: 0
    },
    defaultItem: {},
    titleName: {},

    vaild: false,
    rules: {
      required: v => !!v || "Required.",
      slug: v => {
        const pattern = /^[a-z0-9_-]{1,16}$/;
        return pattern.test(v) || "Syntax error.";
      }
    },
    errMsg: [],

    icons: {
      mdiPencilOutline,
      mdiTrashCanOutline
    }
  }),

  computed: {
    formTitle() {
      return this.editedIndex === -1
        ? "New category"
        : this.editedItem.count !== -1
        ? "Edit category"
        : "Delete " + this.editedItem.name + " ?";
    }
  },

  watch: {
    dialog(val) {
      val || this.close();
    }
  },

  created() {
    getCategorys().then(res => {
      this.categorys = res.data;
      this.isLoading = false;
    });
    this.defaultItem = Object.assign({}, this.editedItem);
  },

  methods: {
    editItem(item) {
      this.editedIndex = this.categorys.indexOf(item);
      this.editedItem = Object.assign({}, this.editedItem, item);
      this.dialog = true;
    },

    deleteItem(item) {
      this.editedIndex = this.categorys.indexOf(item);
      this.editedItem = Object.assign({}, item);
      this.editedItem.count = -1;
      this.dialog = true;
    },

    del() {
      this.disabled = true;
      deleteCategory(this.editedItem).then(res => {
        if (res.status === 200) {
          this.categorys.splice(this.editedIndex, 1);
          this.$store.commit(
            "showSnackbar",
            this.editedItem.name + " has been deleted."
          );
          this.close();
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
      this.vaild = this.$refs.form.validate();
      this.disabled = true;
      if (this.editedIndex > -1) {
        editCategory(this.editedItem).then(res => {
          if (res.status === 200) {
            this.categorys[this.editedIndex].name = this.editedItem.name;
            this.categorys[this.editedIndex].slug = this.editedItem.slug;
            this.categorys[
              this.editedIndex
            ].description = this.editedItem.description;
            this.$store.commit("showSnackbar", "Category updated.");
            this.close();
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
        addCategory(this.editedItem).then(res => {
          if (res.status === 200) {
            this.categorys.unshift(this.editedItem);
            this.categorys[0].mid = res.data.mid;
            this.$store.commit("showSnackbar", "Category added.");
            this.close();
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

    close() {
      this.dialog = false;
      setTimeout(() => {
        this.errMsg = [];
        this.editedItem = Object.assign({}, this.defaultItem);
        this.editedIndex = -1;
        if (this.vaild === false) this.$refs.form.resetValidation();
      }, 300);
    }
  }
};
</script>
