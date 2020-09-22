<template>
  <v-container class="pa-0">
    <v-sheet max-width="1650" class="mx-auto">
      <v-row no-gutters>
        <v-col>
          <DataTable
            :headers="headers"
            :items="users"
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
                  {{ "Add new user" }}
                </v-list-item-content>
              </v-list-item>
            </template>

            <template #item.role="{ item }">
              <span>{{ displayRole(item.role) }}</span>
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
                    :disabled="
                      item.role == $store.state.role ||
                        (item.role == 0 && $store.state.role != 0)
                    "
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
            max-width="380"
            scrollable
          >
            <v-card :disabled="disabled">
              <v-card-title class="title">
                {{ formTitle }}
              </v-card-title>
              <v-sheet v-if="editedItem.password !== undefined">
                <v-divider />
                <v-card-text>
                  <v-container>
                    <v-form v-model="vaild" id="form" ref="form">
                      <v-row no-gutters>
                        <v-col v-if="editedIndex === -1" cols="12">
                          <v-text-field
                            v-model="editedItem.username"
                            :rules="[rules.required, rules.username]"
                            label="Username"
                            hint="Fill with letters or numbers."
                            maxlength="16"
                            outlined
                            dense
                          />
                        </v-col>
                        <v-col cols="12" class="pt-2">
                          <v-text-field
                            v-model="editedItem.nickname"
                            :rules="[rules.required]"
                            label="Nickname"
                            maxlength="16"
                            outlined
                            dense
                          />
                        </v-col>
                        <v-col v-if="editedIndex === -1" cols="12">
                          <span class="subtitle-1">
                            {{ "Select user's role" }}
                          </span>
                          <v-radio-group v-model="editedItem.role" row>
                            <v-radio
                              v-if="$store.state.role === 0"
                              :value="1"
                              label="Admin"
                            />
                            <v-radio :value="2" label="Editor" />
                          </v-radio-group>
                        </v-col>
                      </v-row>
                      <span v-if="editedIndex !== -1" class="subtitle-1">
                        {{ "Change password" }}
                      </span>
                      <v-row>
                        <v-col cols="6" class="pb-0">
                          <v-text-field
                            v-model="editedItem.password"
                            :rules="[rules.required, rules.password]"
                            type="password"
                            label="Password"
                            maxlength="64"
                            outlined
                            dense
                          />
                        </v-col>
                        <v-col cols="6" class="pb-0">
                          <v-text-field
                            v-model="editedItem.confirmPassword"
                            :rules="[rules.required]"
                            :error-messages="errMsg"
                            type="password"
                            label="Confirm"
                            maxlength="64"
                            outlined
                            dense
                          />
                        </v-col>
                      </v-row>
                      <span>
                        {{
                          "Use 8 or more characters with letters, numbers & symbols."
                        }}
                      </span>
                      <span v-if="editedIndex !== -1">
                        {{ "Leave blank won't change anything." }}
                      </span>
                    </v-form>
                  </v-container>
                </v-card-text>
                <v-divider />
              </v-sheet>
              <v-card-text v-if="editedItem.password === undefined" />
              <v-card-actions>
                <v-spacer />
                <v-btn @click="close" color="primary" text>
                  {{ closeBtn }}
                </v-btn>
                <v-btn
                  v-if="this.editedItem.password !== undefined"
                  @click="save"
                  color="primary"
                  text
                >
                  {{ saveBtn }}
                </v-btn>
                <v-btn
                  v-if="this.editedItem.password === undefined"
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
import { getUsers, addUser, editUser, deleteUser } from "@/api/users.js";
import { mdiPencilOutline, mdiTrashCanOutline } from "@mdi/js";

export default {
  name: "Users",

  components: { DataTable, Tooltip },

  data: () => ({
    users: [],
    headers: [
      { text: "Username", value: "username" },
      { text: "Nickname", value: "nickname" },
      { text: "Role", value: "role", filterable: false },
      { text: "", value: "actions", sortable: false, width: 88 }
    ],
    isLoading: true,
    tableName: "Users",
    tooltipEdit: "Edit",
    tooltipDelete: "Delete",

    dialog: false,
    disabled: false,
    closeBtn: "Cancel",
    saveBtn: "Save",
    deleteBtn: "Delete",

    editedIndex: -1,
    editedItem: {
      username: "",
      password: "",
      confirmPassword: "",
      nickname: "",
      role: 2
    },
    defaultItem: {},

    vaild: false,
    rules: {
      required: v => !!v || "Required.",
      username: v => {
        const pattern = /^[a-z0-9]{1,16}$/;
        return pattern.test(v) || "Fill with lowercase letters or numbers.";
      },
      password: v => {
        const pattern = /^[a-zA-Z0-9@^$!%*#?&]{8,64}$/;
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
        ? "New user"
        : this.editedItem.password !== undefined
        ? "Edit user"
        : "Delete " + this.editedItem.username + " ?";
    }
  },

  watch: {
    dialog(val) {
      val || this.close();
    }
  },

  created() {
    getUsers().then(res => {
      this.users = res.data;
      this.isLoading = false;
    });
    this.defaultItem = Object.assign({}, this.editedItem);
  },

  methods: {
    displayRole(val) {
      if (val === 0) return "System";
      if (val === 1) return "Admin";
      if (val === 2) return "Editor";
    },

    editItem(item) {
      this.editedIndex = this.users.indexOf(item);
      this.editedItem = Object.assign({}, this.editedItem, item);
      this.dialog = true;
    },

    deleteItem(item) {
      this.editedIndex = this.users.indexOf(item);
      this.editedItem = Object.assign({}, item);
      this.dialog = true;
    },

    del() {
      this.disabled = true;
      deleteUser(this.editedItem).then(res => {
        if (res.status === 200) {
          this.users.splice(this.editedIndex, 1);
          this.$store.commit(
            "showSnackbar",
            this.editedItem.username + " has been deleted."
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
      if (this.editedIndex > -1) {
        if (this.editedItem.nickname === "") return;
        if (this.editedItem.password !== this.editedItem.confirmPassword)
          return (this.errMsg = ["Those passwords didn't match. Try again."]);
        this.disabled = true;
        editUser(this.editedItem).then(res => {
          if (res.status === 200) {
            this.users[this.editedIndex].nickname = this.editedItem.nickname;
            this.$store.commit("showSnackbar", "User updated.");
            this.close();
          } else if (res.request.status === 409) {
            this.$store.commit("showSnackbar", "Nickname already exist.");
          } else {
            this.$store.commit(
              "showSnackbar",
              "Sorry, something went wrong there. Try again."
            );
          }
          this.disabled = false;
        });
      } else {
        this.vaild = this.$refs.form.validate();
        if (this.editedItem.password !== this.editedItem.confirmPassword)
          return (this.errMsg = ["Those passwords didn't match. Try again."]);
        else this.errMsg = [];
        if (!this.vaild) return;
        this.disabled = true;
        addUser(this.editedItem).then(res => {
          if (res.status === 200) {
            delete this.editedItem.password;
            delete this.editedItem.confirmPassword;
            this.users.unshift(this.editedItem);
            this.$store.commit("showSnackbar", "New user created.");
            this.close();
          } else if (res.request.status === 409) {
            this.$store.commit(
              "showSnackbar",
              "Username or Nickname already exist."
            );
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
        this.editedIndex = -1;
        this.editedItem = Object.assign({}, this.defaultItem);
        if (this.vaild === false) this.$refs.form.resetValidation();
      }, 300);
    }
  }
};
</script>
