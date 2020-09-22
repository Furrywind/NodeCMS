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
        <v-col>
          <v-card class="mx-auto" outlined>
            <v-card-text>
              <v-sheet class="ml-4 mb-6">
                <v-row>
                  <span class="title primary--text">
                    {{ article.title }}
                  </span>
                </v-row>
                <v-row>
                  <span class="body-2">
                    {{ article.date.substring(0, 10) }}
                  </span>
                  <span class="ml-3 body-2">
                    author:
                    <span class="decoration primary--text font-weight-medium">
                      {{ article.author }}
                    </span>
                  </span>
                  <span class="ml-3 body-2">
                    category:
                    <span class="decoration primary--text font-weight-medium">
                      {{ article.category }}
                    </span>
                  </span>
                </v-row>
              </v-sheet>
              <span v-html="article.content"></span>
            </v-card-text>
          </v-card>
        </v-col>
      </v-row>
    </v-sheet>
  </v-container>
</template>

<script>
import { getArticle } from "@/api/article.js";

export default {
  name: "Article",

  data: () => ({
    article: {}
  }),

  created() {
    getArticle(this.$route.query.slug).then(res => {
      if (this.$route.query.slug !== undefined) {
        this.article = res.data;
      } else {
        this.$router.push("/");
      }
    });
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
