<template>
  <v-container>
    <v-sheet max-width="960" class="mx-auto">
      <v-row justify="center" class="ma-4">
        <v-avatar color="primary" size="72">
          <span class="white--text display-2">
            {{ this.$store.state.nickname.charAt(0).toUpperCase() }}
          </span>
        </v-avatar>
      </v-row>
      <v-row justify="center">
        <p class="headline" id="title">
          Welcome, {{ this.$store.state.nickname }}
        </p>
      </v-row>
      <v-row justify="center" class="mx-4 mt-4">
        <p>
          There are currently <strong>{{ articles }}</strong> articles, click
          the links below to get started:
        </p>
      </v-row>
      <v-row justify="center" class="mx-2">
        <router-link to="editor" class="subtitle-1 font-weight-medium mx-2">
          New article
        </router-link>
        <router-link to="articles" class="subtitle-1 font-weight-medium mx-2">
          Articles
        </router-link>
        <router-link to="category" class="subtitle-1 font-weight-medium mx-2">
          Category
        </router-link>
        <router-link to="labels" class="subtitle-1 font-weight-medium mx-2">
          Labels
        </router-link>
      </v-row>
      <v-row class="mt-4">
        <v-col cols="12" :sm="6">
          <v-card class="mx-auto" outlined>
            <v-card-title>Recently published articles</v-card-title>
            <v-card-text>
              <p v-if="published.length === 0" class="body-1 ml-4">
                No published articles.
              </p>
              <v-list-item v-for="item in published" :key="item.cid">
                <v-list-item-content>
                  <v-list-item-title class="body-1">
                    {{ item.created.substring(5, 10) }} | {{ item.title }}
                  </v-list-item-title>
                </v-list-item-content>
              </v-list-item>
            </v-card-text>
          </v-card>
        </v-col>
        <v-col cols="12" :sm="6">
          <v-card class="mx-auto" outlined>
            <v-card-title>New drafts</v-card-title>
            <v-card-text>
              <p v-if="drafts.length === 0" class="body-1 ml-4">
                No new drafts.
              </p>
              <v-list-item v-for="item in drafts" :key="item.cid">
                <v-list-item-content>
                  <v-list-item-title class="body-1">
                    {{ item.created.substring(5, 10) }} | {{ item.title }}
                  </v-list-item-title>
                </v-list-item-content>
              </v-list-item>
            </v-card-text>
          </v-card>
        </v-col>
      </v-row>
    </v-sheet>
  </v-container>
</template>

<script>
import { getDashboard } from "@/api/settings.js";

export default {
  name: "Dashboard",

  data: () => ({
    articles: 0,
    published: [],
    drafts: []
  }),

  created() {
    getDashboard().then(res => {
      this.articles = res.data[0].articles;
      this.published = res.data[1];
      this.drafts = res.data[2];
    });
  }
};
</script>

<style scoped>
#title {
  font-size: 1.75rem !important;
}
a {
  text-decoration: none;
}
</style>
