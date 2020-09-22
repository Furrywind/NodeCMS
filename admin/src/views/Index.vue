<template>
  <div>
    <v-navigation-drawer
      v-model="primaryDrawer.model"
      :color="this.$vuetify.breakpoint.mdAndDown ? '' : 'transparent'"
      width="280"
      app
      clipped
      floating
    >
      <v-list shaped active-class>
        <v-list subheader>
          <v-list-item
            v-for="item in primaryDrawer.items"
            :key="item.title"
            :to="item.route"
            :ripple="false"
            color="primary"
            link
          >
            <v-list-item-icon>
              <v-icon>{{ item.icon }}</v-icon>
            </v-list-item-icon>
            <v-list-item-content>
              <v-list-item-title>{{ item.title }}</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-list>
        <div v-if="$store.state.role !== 2">
          <v-divider />
          <v-subheader>{{ primaryDrawer.subHeader }}</v-subheader>
          <v-list subheader>
            <v-list-item
              v-for="item in primaryDrawer.secondItems"
              :key="item.title"
              :to="item.route"
              :ripple="false"
              color="primary"
              link
            >
              <v-list-item-icon>
                <v-icon>{{ item.icon }}</v-icon>
              </v-list-item-icon>
              <v-list-item-content>
                <v-list-item-title>{{ item.title }}</v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </v-list>
        </div>
      </v-list>
    </v-navigation-drawer>

    <v-app-bar app clipped-left elevate-on-scroll>
      <v-app-bar-nav-icon
        @click.stop="primaryDrawer.model = !primaryDrawer.model"
      >
        <v-icon>{{ icons.mdiMenu }}</v-icon>
      </v-app-bar-nav-icon>
      <v-toolbar-title>
        <router-link to="/">
          <span
            :class="this.$vuetify.theme.dark ? 'white--text' : 'black--text'"
          >
            NodeCMS
          </span>
        </router-link>
      </v-toolbar-title>
      <v-spacer />
      <v-menu offset-y>
        <template v-slot:activator="{ on }">
          <v-btn v-on="on" icon>
            <v-icon>{{ icons.mdiDotsVertical }}</v-icon>
          </v-btn>
        </template>
        <v-list min-width="180" dense>
          <v-list-item @click="$vuetify.theme.dark = !$vuetify.theme.dark">
            <v-list-item-content class="body-2 ml-2">
              Dark theme
            </v-list-item-content>
          </v-list-item>
        </v-list>
      </v-menu>

      <v-menu offset-y>
        <template v-slot:activator="{ on }">
          <v-btn v-on="on" icon>
            <v-avatar color="primary" size="32">
              <span class="white--text headline">
                {{ avatar }}
              </span>
            </v-avatar>
          </v-btn>
        </template>
        <v-card min-width="340" outlined>
          <v-row>
            <v-col class="mx-auto mt-2" cols="auto">
              <v-avatar color="primary" size="72">
                <span class="white--text display-2">
                  {{ this.$store.state.nickname.charAt(0).toUpperCase() }}
                </span>
              </v-avatar>
            </v-col>
          </v-row>
          <v-row justify="center">
            <p class="subtitle-2">{{ this.$store.state.nickname }}</p>
          </v-row>
          <v-row class="mb-4" justify="center">
            <v-btn id="btnBorder" rounded outlined>Manage your account</v-btn>
          </v-row>
          <v-divider></v-divider>
          <v-row class="py-3" justify="center">
            <v-btn @click="logOut" id="btnBorder" outlined>Log out</v-btn>
          </v-row>
          <v-divider class="mb-4"></v-divider>
          <v-row justify="center">
            <p class="caption">2020 © All rights reserved</p>
          </v-row>
        </v-card>
      </v-menu>
    </v-app-bar>

    <v-content>
      <router-view />
    </v-content>

    <Snackbar />
  </div>
</template>

<script>
import Snackbar from "@/components/Snackbar.vue";

import {
  mdiMenu,
  mdiClose,
  mdiDotsVertical,
  mdiViewDashboardOutline,
  mdiTableOfContents,
  mdiBookOutline,
  mdiLabelOutline,
  mdiAccountMultipleOutline,
  mdiCogOutline
} from "@mdi/js";

export default {
  name: "Index",

  components: { Snackbar },

  data: () => ({
    primaryDrawer: {
      model: null,
      items: [
        {
          title: "Dashboard",
          route: "/",
          icon: mdiViewDashboardOutline
        },
        { title: "Articles", route: "articles", icon: mdiTableOfContents },
        { title: "Category", route: "category", icon: mdiBookOutline },
        { title: "Labels", route: "labels", icon: mdiLabelOutline }
      ],
      secondItems: [
        {
          title: "Users",
          route: "users",
          icon: mdiAccountMultipleOutline
        },
        { title: "Settings", route: "settings", icon: mdiCogOutline }
      ],
      subHeader: "Management"
    },

    icons: { mdiMenu, mdiClose, mdiDotsVertical }
  }),

  computed: {
    avatar() {
      return this.$store.state.nickname.charAt(0).toUpperCase();
    }
  },

  methods: {
    logOut() {
      localStorage.removeItem("token");
      localStorage.removeItem("userInfo");
      this.$router.push("login");
    }
  }
};
</script>

<style scoped>
a {
  text-decoration: none;
}
#btnBorder {
  border-color: #dadce0 !important;
}
</style>
