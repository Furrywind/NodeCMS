<template>
  <v-container>
    <v-sheet max-width="960" class="mx-auto mt-4">
      <v-row>
        <v-col cols="12" sm="8">
          <span class="display-2">
            NodeCMS
          </span>
        </v-col>
        <v-col cols="12" sm="4">
          <v-text-field
            class="pa-2"
            label="Search..."
            solo
            dense
          ></v-text-field>
        </v-col>
      </v-row>
      <v-row>
        <router-link to="/" class="headline mx-4"> Home </router-link>
        <span class="headline grey--text">|</span>
        <router-link to="articles" class="headline mx-4">
          Articles
        </router-link>
        <span class="headline grey--text">|</span>
        <router-link to="labels" class="headline mx-4">
          Labels
        </router-link>
        <span class="headline grey--text">|</span>
        <a class="headline mx-4" href="http://localhost:8080">Admin</a>
      </v-row>
    </v-sheet>
    <v-divider class="my-4"></v-divider>
    <v-sheet max-width="960" class="mx-auto mt-4">
      <v-row>
        <v-col cols="8">
          <v-card class="mx-auto" outlined>
            <v-card-title>
              <span class="headline">Newest articles</span>
            </v-card-title>
            <v-card-text>
              <v-sheet
                class="ml-4 my-4"
                v-for="item in articles"
                :key="item.slug"
              >
                <v-row>
                  <router-link
                    :to="{ name: 'Article', query: { slug: item.slug } }"
                  >
                    <span class="title primary--text">
                      {{ item.title }}
                    </span>
                  </router-link>
                </v-row>
                <v-row>
                  <span class="body-2">
                    {{ item.date.substring(0, 10) }}
                  </span>
                  <span class="ml-3 body-2">
                    author:
                    <span class="decoration primary--text font-weight-medium">{{
                      item.author
                    }}</span>
                  </span>
                  <span class="ml-3 body-2">
                    category:
                    <span class="decoration primary--text font-weight-medium">{{
                      item.category
                    }}</span>
                  </span>
                </v-row>
              </v-sheet>
            </v-card-text>
          </v-card>
        </v-col>
        <v-col cols="4">
          <v-card class="mx-auto" outlined>
            <v-card-title>
              <span class="headline">Category</span>
            </v-card-title>
            <v-card-text>
              <v-sheet class="ms-1" v-for="item in category" :key="item.slug">
                <span class="subtitle-1 font-weight-medium primary--text">
                  {{ item.name }}
                </span>
              </v-sheet>
            </v-card-text>
          </v-card>
        </v-col>
      </v-row>
    </v-sheet>
  </v-container>
</template>

<script>
import { getHome } from "@/api/home.js";

export default {
  name: "Home",

  data: () => ({
    articles: [],
    category: []
  }),

  created() {
    getHome().then(res => {
      this.articles = res.data[0];
      this.category = res.data[1];
    });
  },
  methods: {
    goto(slug) {
      this.$router.push({ name: "article", query: { slug: slug } });
    }
  }
};
</script>

<style scoped>
a {
  text-decoration: none;
}
.decoration {
  text-decoration: underline;
}
</style>
