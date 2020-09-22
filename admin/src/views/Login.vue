<template>
  <v-content>
    <v-container class="fill-height" fluid>
      <v-row no-gutters>
        <v-col>
          <v-card
            :disabled="disabled"
            :loader-height="showLoading"
            :flat="$vuetify.breakpoint.xsOnly"
            :outlined="$vuetify.breakpoint.smAndUp"
            class="mx-auto my-4 "
            max-width="448"
            min-height="500"
            loading
          >
            <v-sheet class="d-flex flex-column mx-4 mx-sm-10 my-12">
              <v-icon class="mx-auto mb-2" color="primary" x-large>
                {{ icons.mdiAccountCircleOutline }}
              </v-icon>
              <p class="text-center headline">Login</p>
              <v-form
                @submit.prevent="submit"
                id="form"
                ref="form"
                class="my-8"
              >
                <v-text-field
                  v-model="username"
                  :rules="usernameRules"
                  label="Username"
                  required
                  outlined
                />
                <v-text-field
                  v-model="password"
                  @click:append="showPassword = !showPassword"
                  :rules="passwordRules"
                  :error-messages="errMsg"
                  :type="showPassword ? 'text' : 'password'"
                  :append-icon="
                    showPassword ? icons.mdiEyeOffOutline : icons.mdiEyeOutline
                  "
                  label="Password"
                  required
                  outlined
                />
              </v-form>
              <v-btn
                type="submit"
                form="form"
                class="ml-auto"
                color="primary"
                depressed
              >
                Login
              </v-btn>
            </v-sheet>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </v-content>
</template>

<script>
import { login } from "@/api/users.js";
import {
  mdiAccountCircleOutline,
  mdiEyeOutline,
  mdiEyeOffOutline
} from "@mdi/js";

export default {
  name: "Login",

  data: () => ({
    username: "",
    password: "",
    usernameRules: [],
    passwordRules: [],
    errMsg: [],
    disabled: false,
    showLoading: 0,
    showPassword: false,
    icons: { mdiAccountCircleOutline, mdiEyeOffOutline, mdiEyeOutline }
  }),

  watch: {
    /* set these watch for validate only on submit */
    username() {
      this.usernameRules = [];
    },
    password() {
      this.passwordRules = [];
    }
  },

  methods: {
    submit() {
      /* validate only on submit */
      this.usernameRules = [v => !!v || "Enter username!"];
      this.passwordRules = [v => !!v || "Enter password!"];
      this.$refs.form.validate();

      if (this.username && this.password) {
        this.disabled = true;
        this.showLoading = 4;
        login(this.username, this.password).then(res => {
          if (res.status === 200) {
            this.$store.commit("setRole", res.data.userInfo.role);
            this.$store.commit("setNickname", res.data.userInfo.nickname);
            return this.$router.push("/");
          } else if (res.request.status === 400)
            this.errMsg = ["Wrong password. Try again."];
          else this.errMsg = ["Sorry, something went wrong there. Try again."];
          this.showLoading = 0;
          this.disabled = false;
        });
      }
    }
  }
};
</script>
